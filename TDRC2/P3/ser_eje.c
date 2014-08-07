#include <stdio.h>
#include <malloc.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include "servidor.h"



int main(int argc, char *argv[])
{

     	int sd,from_len,new_socket;
     	struct sockaddr_in from,sockname;
     	char buffer[500];
	char opc[10];
	int opcion;
	char usu[30];
	char pswd[15];
	int maxIntentos = 3;
	int fin=0;
	int existe=0;
	int exito=0;
	char peticion[15];

     	if(argc!=2){

             perror("Argumentos:Incorrecto"),exit(1);
         
    	 }

	int puerto=atoi(argv[1]);

 
      	if((sd=socket(AF_INET,SOCK_STREAM,0))==-1)
           	perror("Servidor:Socket"),exit(1);
      
	sockname.sin_family=AF_INET;
      	sockname.sin_addr.s_addr=INADDR_ANY;
      	sockname.sin_port=htons(puerto);

      	if(bind(sd,&sockname,sizeof(sockname))==-1)
             	perror("Servidor:Bind"),exit(1);
      
	while(fin!=1){ 
	      printf("Escuchando...\n");

	      if(listen(sd,1)==-1)
		    perror("Servidor1:Listen"),exit(1);
	      from_len=sizeof(from);
	      if((new_socket=accept(sd,&from,&from_len))==-1)
		perror("Servidor:Accept"),exit(1);
	      
		do{	       

 			if(send(new_socket,"1.- Iniciar Sesion.\n2.- Registrarse\n0.- Salir\n",500,0)==-1)
           			perror("Servidor:Send"),exit(1);


		   	if(recv(new_socket,opc,500,0)==-1)
				 	perror("Servidor:Recv1"),exit(1);

			opcion=atoi(opc);

			switch (opcion){

				case 1:

		 			if(send(new_socket,"Introduzca su nombre de usuario para iniciar sesion\n",500,0)==-1)
           					perror("Servidor:Send"),exit(1);

			   		if(recv(new_socket,usu,30,0)==-1)
			 			perror("Servidor:Recv2"),exit(1);

	  	 			else{
					
						printf("Comprobando el usuario '%s' en el sistema...\n",usu);
						if(!comprobarUsuario(usu)){

							if(send(new_socket,"0",500,0)==-1)
           							perror("Servidor:Send"),exit(1);

							if(send(new_socket,"El usuario no existe en el sistema, vaya al menu principal y registrese\n",500,0)==-1)
           							perror("Servidor:Send"),exit(1);


						}
					
						else{

							if(send(new_socket,"1",500,0)==-1)
           							perror("Servidor:Send"),exit(1);
					

							if(send(new_socket,"Introduzca su clave de acceso:\n",500,0)==-1)
           							perror("Servidor:Send"),exit(1);

					   		if(recv(new_socket,pswd,15,0)==-1)
					 			perror("Servidor:Recv3"),exit(1);
			  	 			else{
					
								printf("Comprobando que usuario '%s' y clave '%s' coinciden...\n", usu, pswd);
								
								if(!comprobarPswd(usu, pswd)){

									if(send(new_socket,"0",500,0)==-1)
           									perror("Servidor:Send"),exit(1);
									
									if(send(new_socket,"Usuario y pass no coinciden\n",500,0)==-1)
          									perror("Servidor:Send"),exit(1);

		
								}

								else{

									if(send(new_socket,"1",500,0)==-1)
           									perror("Servidor:Send"),exit(1);

									if(send(new_socket,"Sesion iniciada correctamen. Puede comenzar a chatear.\n",500,0)==-1)
          									perror("Servidor:Send"),exit(1);

									printf("Sesion iniciada correctamente. El cliente esta chateando en la IP: %s\n", inet_ntoa(from.sin_addr));

									do{

									   	if(recv(new_socket,buffer,500,0)==-1)
										 	perror("Servidor:Recv4"),exit(1);
									  	 else{
											if(strcmp(buffer,"dameip:")==0){

												strcpy(peticion,inet_ntoa(from.sin_addr));

												if(send(new_socket,peticion,500,0)==-1)
           												perror("Servidor:Send"),exit(1);
												
											}
											printf("%s: %s \n", usu, buffer);

										}
									}while(strcmp(buffer,"FIN")!=0 && strcmp(buffer,"fin")!=0);
									//printf("¿Cerrar conversacion? 0 = NO / 1 = SI:\n");
									//scanf("%d",&fin);


								}


							}
						}
					}	

				break;

				case 2:

					maxIntentos=3;
					if(send(new_socket,"Introduzca el nombre de usuario con el que se quiere registrar (max. 30 caracteres y 3 intentos): \n",500,0)==-1)
	   					perror("Servidor:Send"),exit(1);

					do{

				   		if(recv(new_socket,usu,30,0)==-1)
				 			perror("Servidor:Recv2"),exit(1);

						printf("Comprobando el usuario '%s' en el sistema...\n",usu);

						maxIntentos--;
						existe = comprobarUsuario(usu);
						
						sprintf(buffer,"%d",existe);

						if(send(new_socket,buffer,500,0)==-1)
								perror("Servidor:Send"),exit(1);

						if(existe == 1){

							if(send(new_socket,"El usuario ya existe, introduzca un nuevo nombre: \n",500,0)==-1)
   								perror("Servidor:Send2"),exit(1);

							printf("Usuario incorrecto. A la espera de un nuevo nombre de usuario...\n");	
						}

					}while(existe == 1 && maxIntentos!=0);


					if(existe == 0){
						if(send(new_socket,"Usuario valido. Introduzca su clave de acceso:\n",500,0)==-1)
							perror("Servidor:Send"),exit(1);

				   		if(recv(new_socket,pswd,15,0)==-1)
				 			perror("Servidor:Recv3"),exit(1);

						exito=registrarUsuario(usu,pswd);
				
						if(exito == 1){

							if(send(new_socket,"Usuario registrado con exito. Reconecte para iniciar sesion.\n",500,0)==-1)
								perror("Servidor:Send"),exit(1);
					
						}

						else{
							if(send(new_socket,"Error al registrar usuario. Intentelo de nuevo mas tarde.\n",500,0)==-1)
								perror("Servidor:Send"),exit(1);
						
						}

					}
				break;

				default: printf("Saliendo...\n"); break;


			}

		}while((strcmp(buffer,"1")==0 || strcmp(buffer,"2")==0) && strcmp(buffer,"99") == 0);
	}
}
