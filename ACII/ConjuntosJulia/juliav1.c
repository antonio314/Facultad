#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "mpi.h"

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



        MPI_Status estado;
	int iproc, nproc;

	if (argc!=7){

	}
	else{

		long Col = atoi(argv[1]);
		long Fil = atoi(argv[2]);
		float cr = atof(argv[3]);
		float ci = atof(argv[4]);
		float Ventx = atof(argv[5]);
		float Venty = atof(argv[6]);
		float Tamx = atof(argv[7]);
		float Tamy = atof(argv[8]);

	}

	int linea;
	
	float zr,zi;
	float zrs,zis;
	int i,j,h;
	unsigned char color;
	double secs;
	
	// inicializacion estatica de la imagen		
	char im[Fil][Col];	
	char imAux[Col];
	


	MPI_Init(&argc, &argv); // Inicializamos los procesos
	MPI_Comm_size(MPI_COMM_WORLD, &nproc); // Obtenemos el numero Fil de procesos
	MPI_Comm_rank(MPI_COMM_WORLD, &iproc); // Obtenemos el valor de nuestro identificador

	//int Fil = Fil;
	clock_t comienzo = clock();

	for (j=iproc;j<Fil;j+=nproc){
	     for (i=0;i<Col;i++)
	     {

		//printf("posicion:[%d][%d]\n", j, i);

		  zi=(float)Venty+(float)j*Incx;
		  zr=(float)Ventx+(float)i*Incy; 
		  zrs=zis=(float)0; // semilla 
		  color=0;	    // colorea y limita las iteraciones de puntos del conjunto
	
		  while (zrs+zis<(float)4 && color<256)
		  {
		         zrs=zr*zr; 
		         zis=zi*zi; 
		         zi=(float)2*zr*zi+ci; 
		         zr=zrs-zis+cr; 
		         color++; 
		  }
		  //im[j][i]=color-1; // asigno el color
		  imAux[i] = color-1;

	     }

	     if(iproc == 0){

		  

		  for(h = 0;h < Col;h++)
			im[j][h] = imAux[h];

		  for(h = 1;h < nproc;h++){

			MPI_Recv(&linea // Referencia al vector donde se almacenara lo recibido
				,1 // tamaño del vector a recibir
				,MPI_INT // Tipo de dato que recibe
				,iproc + h // pid del proceso origen de la que se recibe
				,0 // etiqueta
				,MPI_COMM_WORLD // Comunicador por el que se recibe
				,&estado); // estructura informativa del estado

			MPI_Recv(&im[linea] // Referencia al vector donde se almacenara lo recibido
				,Fil // tamaño del vector a recibir
				,MPI_CHAR // Tipo de dato que recibe
				,iproc + h // pid del proceso origen de la que se recibe
				,0 // etiqueta
				,MPI_COMM_WORLD // Comunicador por el que se recibe
				,&estado); // estructura informativa del estado

		  }

	     }
	     else{

			MPI_Send(&j //referencia al vector de elementos a enviar
                		,1 // tamaño del vector a enviar
                		,MPI_INT // Tipo de dato que envias
                		,0 // pid del proceso destino
                		,0 //etiqueta
                		,MPI_COMM_WORLD); //Comunicador por el que se manda

			MPI_Send(&imAux //referencia al vector de elementos a enviar
                		,Fil // tamaño del vector a enviar
                		,MPI_CHAR // Tipo de dato que envias
                		,0 // pid del proceso destino
                		,0 //etiqueta
                		,MPI_COMM_WORLD); //Comunicador por el que se manda


	     }

 	 }

	printf("Proceso (%d) Julia: %li milisegundos\n",iproc,(clock()-comienzo)*1000/CLOCKS_PER_SEC);

	 MPI_Finalize();
	 if(!iproc){

		 
		 // paso los valores de la matriz al fichero Imagen
		 FILE *fim;
		 fim=fopen("julia.raw","wb");
		 if (!fim)
		 {
		     printf("No se puede abrir el fichero de salida.\n");
		     exit(1);
		 }
		 for(i=Fil-1;i>=0;i--)
	 	 	fwrite(im[i],sizeof(char),Col,fim);
		 fclose(fim);

	 }	 
	 return EXIT_SUCCESS;
}


