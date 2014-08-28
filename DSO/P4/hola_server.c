#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include "hola.h"

int *crear_1_svc (char **nombre_fichero, struct svc_req *req) {
            static int resultado = 1;
            FILE *fichero = fopen(*nombre_fichero, "w");
            if (fichero == NULL) {
                    resultado = 0;
            }
            fclose(fichero);
            return (&resultado);
    }
char **escribir_1_svc (dobleString *ficheros, struct svc_req *req) {
            char *buffer[1024];
            buffer[0] = "";
           
            // Abrimos el fichero.
            FILE *fichero = fopen (ficheros->primero, "w");
            if (fichero == NULL) {
                    buffer[0] = "error: abriendo el archivo.";
                    return (&buffer);
            }
           
            // Escribimos en el fichero.
            size_t len = strlen(ficheros->segundo);
            int resultado = fwrite (ficheros->segundo, 1, len, fichero);
            if (resultado != len) {
                    buffer[0] = "error: escribiendo el archivo.";
                    return (&buffer);
            }
           
            // Cerramos el fichero.
            fclose (fichero);
            return (&buffer);
    }
char **leer_1_svc (char **nombre_fichero, struct svc_req *req) {
            FILE *fichero;
            long lSize;
            size_t result;
            char *buffer[1024];
           
            // Abrimos el fichero.
            fichero = fopen(*nombre_fichero, "r");
            if (fichero == NULL) {
                    buffer[0] = "error: abriendo el archivo.";
                    return (&buffer);
            }
           
            // Obtenemos el tamaño del fichero.
            fseek (fichero , 0 , SEEK_END);
            lSize = ftell (fichero);
            rewind (fichero);
           
            // Asignamos la memoria necesaria a nuestro buffer.
            buffer[0] = (char*) malloc (sizeof(char)*lSize);
            if (buffer[0] == NULL) {
                    buffer[0] = "error: asignando memoria.";
                    return (&buffer);
            }
            // Volcamos el fichero en nuestro buffer.
            result = fread (buffer[0], 1, lSize, fichero);
            if (result != lSize) {
                    buffer[0] = "error: leyendo el fichero.";
                    return (&buffer);
            }
           
            // Cerramos el archivo.
            fclose(fichero);
            return (&buffer);
    }
int *renombrar_1_svc (dobleString *ficheros, struct svc_req *req) {
            static int resultado;  
            resultado = rename(ficheros->primero, ficheros->segundo);
            return (&resultado);
    }
int *creardir_1_svc (char **nombre_fichero, struct svc_req *req) {
            static int resultado;
            resultado = mkdir(*nombre_fichero, 0644);
            printf("%i", resultado);
            return (&resultado);
    }
int *borrardir_1_svc (char **nombre_fichero, struct svc_req *req) {
            static int resultado;
            resultado = rmdir(*nombre_fichero);
            printf("%i", resultado);
            return (&resultado);
    }


