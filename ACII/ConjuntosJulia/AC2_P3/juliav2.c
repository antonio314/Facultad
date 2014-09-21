#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "mpi.h"

/*****************************************
Para el conjunto de julia se resuelve:
          f_c(z) = z^2 + c 
Siendo c un valor constante complejo,
z una variable compleja donde 
z0 = coordenadas del punto
******************************************/

int main(int argc, char* argv[]) {

	// Parametros por defecto
	long Col=512,Fil=512; // Numero de filas y columnas de la imagen
	float cr=-0.8,ci=-0.156; // Valor de c (parte real e imaginaria)
	float Ventx=-2,Venty=-2; // Esq inferior izquierda del espacio a evaluar (encuadre)
	float Tamx=4,Tamy=4;    	//Tamaño de la ventana

	//float tamr=Tamx-Ventx;
	//float tami=Tamy-Venty;
	float Incx=Tamx/(float)Col;
	float Incy=Tamy/(float)Fil;

	float zr,zi;
	float zrs,zis;
	int i,j;
	unsigned char color;
	double secs;

	int iproc, nproc,proceso_envia;

	char ** im;
	char * auxiliar;
	FILE * fim;

	int tam_aux, k;
	int intervalos=2;

	//double comienzo, fin;
	MPI_Status status;

	if (argc!=7 ){

		//Cojo los parámetros por defecto
	}

	else{
		// Carga del zoom
		Col = atoi(argv[1]);
		Fil = atoi(argv[2]);

		// Carga del encuadre
		Ventx = Venty = atof(argv[3]);
		Tamx = Tamy = atof(argv[4]);

		// Carga de la constante C
		cr = atof(argv[5]);
		ci = atof(argv[6]);

		//intervalos = atoi(argv[7]);

		Tamx=Tamx-Ventx;
		Tamy=Tamy-Venty;
		Incx=Tamx/(float)Col;
		Incy=Tamy/(float)Fil;
	}

	// Inicio temporizador y MPI

	MPI_Init(&argc, &argv);

	MPI_Comm_size(MPI_COMM_WORLD, &nproc); //Num total de procesos
	MPI_Comm_rank(MPI_COMM_WORLD, &iproc); //Identificador de proceso

	//clock_t comienzo = clock();
	double comienzo,fin;
	comienzo=MPI_Wtime();

	// si el número de intervalos es menor que el de procesos, salgo del programa
	//if(nproc > intervalos) exit(1);

	// Calculo el tamaño de cada submatriz y reservo memoria
	tam_aux = (Fil/nproc*Col+Col);
	auxiliar = (char*)malloc(tam_aux*sizeof(char));


	//Cada proceso irá realizando ciertas filas.
	k=0;

	for (j=iproc;j<Fil;j+=nproc){
		for (i=0;i<Col;i++){

		zi=(float)Venty+(float)j*Incx;
		zr=(float)Ventx+(float)i*Incy;
		zrs=zis=(float)0; // semilla
		color=0;    // colorea y limita las iteraciones de puntos del conjunto

		while (zrs+zis<(float)4 && color<256){
			zrs=zr*zr;
			zis=zi*zi;
			zi=(float)2*zr*zi+ci;
			zr=zrs-zis+cr;
			color++;
		}

		auxiliar[k]=color-1; // asigno el color
		k++;

		}
	}



	if(iproc != 0){ //Si no soy el proceso principal, envío mi parte

		MPI_Send(auxiliar, tam_aux, MPI_CHAR, 0, 0, MPI_COMM_WORLD);
	}

	// Si soy el principal, recivo las partes y reconstruyo la imágen utilizando también mi parte
	else{
		// Reservamos la memoria de la imagen sólo en el proceso principal para así no sobrecargar el programa
		im = (char**)malloc(Fil*sizeof(char*));
		for (i=0;i<Fil;i++)
			im[i] = (char*)malloc(Col*sizeof(char));

		// Empezamos la reconstrucción, copiando la parte que ha creado el proceso principal  
		k=0;

		for (j=iproc;j<Fil;j+=nproc){
			for (i=0;i<Col;i++){
				im[j][i]=auxiliar[k*Col+i];
			}
			k++;
		}

		// Una vez que el proceso principal ha terminado con su parte, continua la reconstrucción.
		int n;
		for (n=1; n<nproc; ++n){
			// Recibimos las submatrices e identficamos quien es el proceso que envia
			MPI_Recv(auxiliar, tam_aux, MPI_CHAR, MPI_ANY_SOURCE,MPI_ANY_TAG, MPI_COMM_WORLD, &status);
			proceso_envia= status.MPI_SOURCE;

			// Copiamos el contenido de la submatriz recibida en la imagen
			k=0;
			for (j=proceso_envia;j<Fil;j+=nproc){
				for (i=0;i<Col;i++){
					im[j][i]=auxiliar[k*Col+i];
				}
				k++;
			}
		}
	}

	fin=MPI_Wtime();

	//printf("Proceso (%d) Julia: %li milisegundos\n",iproc,(/*fin*/clock()-comienzo)*1000/CLOCKS_PER_SEC);

	// Finalizamos MPI
	MPI_Finalize();


	// Pasamos los valores de la matriz definitiva a la futura imagen
	if(!iproc){

		//double fin=MPI_Wtime();
		printf("Total Julia: %f = \n",(fin-comienzo));
		// paso los valores de la matriz al fichero Imagen
		fim=fopen("julia.raw","wb");
		if (!fim){
			printf("No se puede abrir el fichero de salida.\n");
			exit(1);
		}

		for(i=Fil-1;i>=0;i--)
			fwrite(im[i],sizeof(char),Col,fim);
		fclose(fim);
	
		// Incluyendo la creacion del fichero imagen
		//tiempo_fin=MPI_Wtime();
		//printf("Tiempo Conjunto Julia generando fichero imagen: %f milisegundos\n",(double)(tiempo_fin-comienzo));

	}

	return EXIT_SUCCESS;
}

