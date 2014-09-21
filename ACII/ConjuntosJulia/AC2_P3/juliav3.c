#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "mpi.h"
#include <math.h>


/*****************************************
Para el conjunto de julia se resuelve:
          f_c(z) = z^2 + c 
Siendo c un valor constante complejo,
z una variable compleja donde 
z0 = coordenadas del punto
******************************************/


int julia(int Fil , int Col , float  cr, float ci ,float Ventx , float Venty , float Tamx , float Tamy );


// Declaración de las funciones para reservar memoria, liberar memoria e inicializar la matriz
char ** reservarMatriz(unsigned int filas, unsigned int columnas);
void liberarMatriz(char** m);
void iniMatriz(char**matriz, unsigned int filas, unsigned int columnas);



int main(int argc, char* argv[]) {

    MPI_Init(&argc, &argv); // Inicializamos la comunicacion de los procesos
    
    if(argc != 9){	
    	julia(512,  512,  -0.8,  0.156, -2.0,  -2.0,  4, 4);
    }
    else{
	
	julia(atoi(argv[1]),atoi(argv[2]),atof(argv[3]),atof(argv[4]),atof(argv[5]),atof(argv[6]),atof(argv[7]),atof(argv[8]));	
    }

    MPI_Finalize(); //Finalizamos la comunicacion
}

int julia(int Fil, int Col, float  cr, float ci,
	 float Ventx, float Venty, float Tamx, float Tamy)
{

	float zr,zi;  /*Parte real e imaginaria de z.*/
	//float cr,ci;  /*Parte real e imaginaria de c.*/
	float zrs,zis;
	int i,j;
	//char im[Fil][Col];  /*Reserva de memoria estática para la imagen*/
	char color;
	FILE *fi;
	//clock_t t_inicio,t_fin;
	double t_inicio,t_fin;
	double tiempo;

	float Incx=Tamx/Col;
	float Incy=Tamy/Fil;

	int iproc,nproc;

	MPI_Comm_size(MPI_COMM_WORLD, &nproc); //Num total de procesos
	MPI_Comm_rank(MPI_COMM_WORLD, &iproc); //Identificador de proceso

	// numero de filas de las matrices de calculo parcial
	//double parcial = ceil(Fil/(double)nproc);   // ceil redondea hacia arriba
	int parcial = Fil/nproc;
	
	// iterador de la matriz de cálculo parcial
	int x = 0;

	char ** im_parcial = reservarMatriz(parcial, Fil);
	iniMatriz(im_parcial,parcial,Fil);


	int indice=0;


	int id_archivo;
	MPI_File miArchivo;
	id_archivo = MPI_File_open( MPI_COMM_WORLD, "julia.raw", MPI_MODE_RDWR | MPI_MODE_CREATE, MPI_INFO_NULL, &miArchivo );

	if (id_archivo) {
		printf( "Imposible abrir \"julia.raw\"\n" );fflush(stdout);
	}

	 t_inicio=MPI_Wtime();// tiempo en segundos

	 for (j=(iproc*parcial); j<((iproc+1)*parcial) && j<Col; j++){ 

	     for (i=0;i<Fil;i++)
	         {
		  zi=(float)Venty+(float)j*Incy; // z0=coordenadas del punto (parte imaginaria).
	          zr=(float)Ventx+(float)i*Incx; // z0=coordenadas del punto (parte real).
	          zrs=zis=(float)0; // Se inicializan los cuadrados de z, su parte real al cuadrado,
					// zrs y su parte imaginaria al cuadrado (zis).
	          color=0; // Cada punto se colorea según el número de iteraciones necesarias para escapar.
			
		  indice=0;//
	          while (zrs+zis<(float)4 && color<256)
	          {
                         //Calculo z^2 + c como zr^2-zi^2+2*zr*zi+c.
	                 zrs=zr*zr; // Calculo zr^2.
	                 zis=zi*zi; // Calculo zi^2.
                         zi=2*zr*zi+ci; // Calculo la parte imaginaria de z --> 2*zr*zi+ci.
	                 zr=zrs-zis+cr; // Calculo la parte real de z --> x^2-y^2+cr.
	                 color++; // Cada punto se colorea según el número de iteraciones necesarias para escapar.
                         //indice++;         // Los puntos que no consiguen escapar se presentan en negro.
                  }

	          im_parcial[x][i]=color-1; // Asigno el color.
		}
		x++;
	}

	 
	MPI_File_seek (miArchivo, iproc*parcial*Col, MPI_SEEK_SET);
	MPI_Status status;
	MPI_File_write( miArchivo, im_parcial[0], parcial*Fil, MPI_CHAR, &status );  
	MPI_File_close( &miArchivo );

	t_fin=MPI_Wtime();
	tiempo=(t_fin-t_inicio);
	if (iproc==0)printf("Tiempo para %d procesos = %f \n", nproc,tiempo);

	liberarMatriz(im_parcial);

	return EXIT_SUCCESS;
}


/*IMPLEMENTACION DE LAS FUNCIONES PARA RESERVAR MEMORIA, INICIALIZAR LA MATRIZ Y LIBERAR MEMORIA*/

// Reserva en el HEAP una matriz.
char ** reservarMatriz(unsigned int filas, unsigned int columnas) {
	// Reserva de Memoria 
	char **m;	
	m = (char **)malloc(filas*sizeof(char*)); 
	m[0]= (char *) malloc(filas*columnas*sizeof(char));
	int i;
	
	
	for (i=1;i<filas;i++) 
		m[i] = &(m[0][columnas*i]); 

	return m;
}

// Libera la memoria dinamica usada por matriz "m"
void liberarMatriz(char ** m) {
	free ( m[0]);
	free ( m);
}

void iniMatriz(char**matriz, unsigned int filas, unsigned int columnas){
	int i,j;
	for(i = 0; i < filas; i++){
		for( j = 0; j < columnas; j++){
			matriz[i][j] = '0';
		}
	}
}

