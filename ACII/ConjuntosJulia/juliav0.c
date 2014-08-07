#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <mpi.h>

typedef struct{
	char color;
	long fil;
	long col;
} Casilla;

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
	long i,j;
	unsigned char color;
	
	//double tiempo;
	int nproc, iproc;
	MPI_Status status;

	clock_t comienzo = clock();
	//tiempo=MPI_Wtime();
	
	if(MPI_Init(&argc, &argv) != MPI_SUCCESS) exit(1);
	MPI_Comm_size(MPI_COMM_WORLD, &nproc);
	MPI_Comm_rank(MPI_COMM_WORLD, &iproc);
	
	// reserva de memoria para la imagen, solo reserva memoria el proceso 0
	Casilla * im;
	
	if(iproc == 0){
		im = (Casilla *)malloc(Col * Fil * sizeof(Casilla));
		if(im == NULL){
			printf("\nError en la reserva de memoria de la matriz (1)");
			exit(1);
		}
		long pos;
		for(i=0; i<Col; i++){
			for(j=0; j<Fil; j++){
				pos = i*Fil+j;
				im[pos].fil = i;
				im[pos].col = j;
				im[pos].color = 0;
			}
		}
	}
	
	// reserva para obtener los trozos
	Casilla * recv;
	long num_casillas = (Fil*Col)/nproc;
	unsigned long int tam_porcion = num_casillas*sizeof(Casilla);
	recv = (Casilla *)malloc(num_casillas*sizeof(Casilla));

	
/*
int MPI_Scatter(void* sendbuf, int sendcount, MPI_Datatype sendtype, void* recvbuf, int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm);

Es como si la raíz ejecutara n operaciones de envío, una a cada proceso que ejecutase la función. 
En cada operación se enviaría un trozo de igual tamaño del mensaje completo original de forma ordenada. Esto significa que el mensaje original se parte en n partes iguales, que es exactamente el valor que debe tener recvcount.
Los tipos tanto de envío como de recepción deben ser iguales. Esto significa que la cantidad de datos enviados debe ser la misma que el conjunto de los datos recibidos.

sendbuf 	Dirección inicial del buffer de salida, solo útil para el proceso raíz, el resto de procesos ignoran este parámetro.
sendcount 	Número de elementos que se envía a cada proceso del comunicador.
sendtype 	Tipo de dato que se va a enviar, solo lo tendrá en cuenta la raíz.
recvcount 	Número de elementos que espera recibir cada proceso (int).
recvtype 	Tipo de datos de los elementos a recibir.
root 		Identificador del proceso que realizará el envío.
comm 		Comunicador por el que realizar la comunicación.
*/
	
	MPI_Scatter(im, tam_porcion,  MPI_BYTE, recv, tam_porcion, MPI_BYTE, 0, MPI_COMM_WORLD);
	
	for(i=0; i<num_casillas; i++){
		zi=(float)Venty+(float)recv[i].col*Incx;
		zr=(float)Ventx+(float)recv[i].fil*Incy;
		zrs=zis=(float)0; // semilla 
		color=0;	    // colorea y limita las iteraciones de puntos del conjunto

		while (zrs+zis<(float)4 && color<256){
			zrs=zr*zr; 
			zis=zi*zi; 
			zi=(float)2*zr*zi+ci; 
			zr=zrs-zis+cr; 
			color++; 
		}
		recv[i].color = color-1; // asigno el color
	}
	
/*
int MPI_Gather(void* sendbuf, int sendcount, MPI_Datatype sendtype, void* recvbuf, int recvcount, MPI_Datatype recvtype, int root, MPI_Comm comm);

Permite realizar la recolección de los datos en el proceso raíz de forma consecutiva.
Cada proceso (incluido el proceso raíz) envía el contenido de su buffer de salida al proceso raíz. El proceso raíz recibe los mensajes y los guarda por el orden del rango de cada proceso. El resultado final es que se reune en el proceso raíz el mensaje completo y ordenado.

sendbuf 	Dirección inicial del buffer de envío.
sendcount 	Número de elementos que va a enviar cada proceso individualmente, en general, el número de elementos del buffer de envío.
sendtype 	Tipo de dato de cada elemento del buffer de envío.
recvcount 	Número de elementos que se espera recibir de cada uno de los procesos (igual que recvcount si los tipos son iguales). 
recvtype 	Tipo de dato que se espera recibir en el buffer de entrada (útil únicamente para el proceso raíz).
root 		Identificador del proceso receptor.
comm 		Comunicador por el que se realiza la transferencia de datos.
*/	

	MPI_Gather(recv, tam_porcion, MPI_BYTE, im, tam_porcion, MPI_BYTE, 0, MPI_COMM_WORLD);
	
	free(recv);

	printf("Proceso (%d) Julia: %li milisegundos\n",iproc,(/*fin*/clock()-comienzo)*1000/CLOCKS_PER_SEC);

	MPI_Finalize();


	
	if(!iproc){
		//tiempo=MPI_Wtime()-tiempo;
		
		// paso los valores de la matriz al fichero Imagen
		FILE *fim;
		fim=fopen("julia.raw","wb");
		if (!fim)
		{
			printf("No se puede abrir el fichero de salida.\n");
			exit(1);
		}
		for(i=Col*Fil-1;i>=0;i--){
			fwrite(&(im[i].color),sizeof(char),1,fim);
		}
		
		fclose(fim);
	}
	 
	return EXIT_SUCCESS;
}


