#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "hola.h"

void main(int argc, char *argv[]) {
    CLIENT *cliente;
    int *return_value;
    char *servidor;
    // Revisamos el buen uso de los argumentos para nuestro programa.
    if (argc <= 2){
            fprintf(stderr, "error: mal uso de los parámetros.\n");
            exit (1);
    }
   
    servidor = argv[1];
    // Generamos el handle cliente para llamar al servidor.
    if ((cliente=clnt_create(servidor, SERVIDORARCHIVOS, SERVIDORARCHIVOSVERS, "tcp")) == (CLIENT *)NULL) {
            clnt_pcreateerror(servidor);
            exit(2);
    }
   
    // Elegimos una opción mediante parámetro.
    if (strcmp(argv[2], "crear_archivo") == 0) { // 'Crear Archivo'.
            return_value = crear_1(&argv[3], cliente);
            if (! *return_value) {
                    fprintf(stderr, "error: abriendo el archivo %s.\n", argv[3]);
                    exit(1);
            }
            exit(0);
           
    } else if (strcmp(argv[2], "escribir_archivo") == 0) { // 'Escribir Archivo'.
            char **buffer;
            dobleString ficheros;
            ficheros.primero = argv[3];
            ficheros.segundo = argv[4];
            buffer = escribir_1(&ficheros, cliente);
            if(strcmp(buffer[0], "") != 0) { // Ha habido algún error.
                    printf("%s\n", buffer[0]);
                    exit(1);
            }
            exit(0);
           
    } else if (strcmp(argv[2], "leer_archivo") == 0) { // 'Leer Archivo'.
           
            char **buffer;
            buffer = leer_1(&argv[3], cliente);
            printf("%s\n", buffer[0]);
            exit(0);
   
    } else if (strcmp(argv[2], "renombrar_archivo") == 0) { // 'Renombrar Archivo'.
           
            dobleString fichero;
            fichero.primero = argv[3];
            fichero.segundo = argv[4];             
            return_value = renombrar_1(&fichero, cliente);
            if (*return_value) {
                    fprintf(stderr, "error: renombrando el archivo %s.\n", argv[3]);
                    exit(1);
            }
            exit(0);
    } else if (strcmp(argv[2], "crear_directorio") == 0) { // 'Crear Directorio'.
           
            return_value = creardir_1(&argv[3], cliente);
            if (*return_value) {
                    fprintf(stderr, "error: creando el directorio %s.\n", argv[3]);
                    exit(1);
            }
            exit(0);
           
    } else if (strcmp(argv[2], "borrar_directorio") == 0){ // 'Borrar Directorio'.
           
            return_value = borrardir_1(&argv[3], cliente);
            if (*return_value){
                    fprintf(stderr, "error: borrando el directorio %s.\n", argv[3]);
                    exit(1);
            }
            exit(0);
           
    } else {
   
            printf("*** INFO: Ejemplos de ejecución ***\n");
            printf("./cliente <server> crear_archivo <nombre_archivo>\n");
            printf("./cliente <server> escribir_archivo <nombre_archivo> <texto a escribir..señala los espacios con barra lateral >\n");
            printf("./cliente <server> leer_archivo <nombre_archivo>\n");
            printf("./cliente <server> renombrar_archivo <nombre_archivo> <nombre_nuevo_archivo>\n");
            printf("./cliente <server> crear_directorio <nombre_archivo>\n");
            printf("./cliente <server> borrar_directorio <nombre_archivo>\n");
            printf("***//INFO***\n");
            exit(0);
           
    }
}


