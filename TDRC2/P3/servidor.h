#include <stdio.h>
#include <malloc.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include "md5.c"

struct usuario{

	char nombre[30];
	char pswd[15];
	char ip[15];

}Users[20];

numUsuarios = 0;


int comprobarUsuario(char nom[]){

	int j;
	for(j = 0; j < numUsuarios; j++){

		if(strcmp(nom, Users[j].nombre) == 0){

			return 1;

		}

	}
	
	return 0;

}

int comprobarPswd(char nom[], char pass[]){

	int j;

	for(j = 0; j < numUsuarios; j++){

		if(strcmp(nom, Users[j].nombre) == 0){

			if(strcmp(pass, Users[j].pswd) == 0){

				return 1;

			}

			else return 0;

		}

	}
	
	return 0;
}

int registrarUsuario(char nom[], char pass[]){

	if(numUsuarios<20){

		strcpy(Users[numUsuarios].nombre, nom);
		strcpy(Users[numUsuarios].pswd, pass);
	
		numUsuarios++;

		return 1;
	}

	else return 0;
}








