#include <stdio.h>
#include <malloc.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/time.h>




int main(int argc, char *argv[])
{
	int sd;
	struct sockaddr_in sockname;
	char buffer[500];
	char buffer2[500];
	char usu[30];
	char pswd[15];
	char opc[10];
	int opcion;
	int noExito;
	int maxIntentos = 3;

	if(argc!=2){

		perror("Argumentos:Incorrecto"),exit(1);
	 
	}

	int puerto=atoi(argv[1]);


	if((sd=socket(AF_INET,SOCK_STREAM,0))==-1)
	perror("Cliente:Socket"),exit(1);
	sockname.sin_family=AF_INET;
	sockname.sin_addr.s_addr=inet_addr("127.0.0.1");
		                    /*  ^^^^^^^^^^^^   Direccion server  */
	sockname.sin_port=htons(puerto);

	if(connect(sd,&sockname,sizeof(sockname))==-1)
	perror("Cliente:Connect"),exit(1);

	printf("\nEstá navegado desde la dirección IP: %s\n\n", inet_ntoa(sockname.sin_addr));
    
	//elijo opcion
   	if(recv(sd,buffer,500,0)==-1)
 		perror("Cliente:Recv"),exit(1);
	printf("%s",buffer);
	scanf("%s",opc);

	opcion=atoi(opc);

	//envio opcion
	if(send(sd,opc,10,0)==-1)
		perror("Cliente:Send"),exit(1);

	switch (opcion){

		case 1:

			//envio usuario
		   	if(recv(sd,buffer,500,0)==-1)
		 		perror("Cliente:Recv"),exit(1);

			printf("%s",buffer);
			scanf("%s",usu);

			if(send(sd,usu,30,0)==-1)
				perror("Cliente:Send"),exit(1);

			//recibo si es correcto o no
		   	if(recv(sd,buffer2,500,0)==-1)
		 		perror("Cliente:Recv"),exit(1);
	
		   	if(recv(sd,buffer,500,0)==-1)
		 		perror("Cliente:Recv"),exit(1);
			printf("%s",buffer);


			//envio password
			if(strcmp(buffer2,"0")==0) 
				exit(1);


			scanf("%s",pswd);

			if(send(sd,pswd,15,0)==-1)
				perror("Cliente:Send"),exit(1);

			//recibo confirmacion
		   	if(recv(sd,buffer2,500,0)==-1)
		 		perror("Cliente:Recv"),exit(1);

		   	if(recv(sd,buffer,500,0)==-1)
		 		perror("Cliente:Recv"),exit(1);

			printf("%s",buffer);


			if(strcmp(buffer2,"0")==0) 
				exit(1);
			
			//conexion iniciada. Chateando...
			printf("\nTeclee el mensaje a transmitir ('FIN'/'fin' para cerrar sesion__ dameip: para conocer su IP).\n\n");
	
			do{ 
				printf("%s: ",usu);
				scanf("%s",buffer);

				if(send(sd,buffer,500,0)==-1)
					perror("Cliente:Send"),exit(1);


				if(strcmp(buffer,"dameip:")==0){

				   	if(recv(sd,buffer,500,0)==-1)
		 				perror("Cliente:Recv"),exit(1);
					
					printf("Su IP es: %s\n",buffer);
																	
				}

			}while(strcmp(buffer,"FIN")!=0 && strcmp(buffer,"fin")!=0);

			

		break;


		case 2:

			//recibo peticion de introducir nombre de usuario
		   	if(recv(sd,buffer,500,0)==-1)
		 		perror("Cliente:Recv"),exit(1);

			printf("%s",buffer);
			scanf("%s",usu);



			do{

				//envio usuario
				if(send(sd,usu,30,0)==-1)
					perror("Cliente:Send"),exit(1);

				//recibo si el nombre de usuario es correcto o no
				if(recv(sd,buffer,500,0)==-1)
			 		perror("Cliente:Recv"),exit(1);
		
				maxIntentos--;
				noExito=atoi(buffer);
				

				if(noExito == 1 && maxIntentos!=0){

					//recibo que no se ha enviado bien
					if(recv(sd,buffer,500,0)==-1)
				 		perror("Cliente:Recv"),exit(1);
					printf("%s", buffer);
					scanf("%s",usu);

				}

				if(noExito == 1 && maxIntentos == 0){

					printf("Ha alcanzado el número máximo de intentos.\n");
					if(send(sd,"99",30,0)==-1)
					perror("Cliente:Send"),exit(1);

					

				}


			}while(noExito == 1 && maxIntentos!=0);

			
			if(noExito == 0){

				//recibo solicitud de introducir password
			   	if(recv(sd,buffer,500,0)==-1)
			 		perror("Cliente:Recv"),exit(1);

				printf("%s",buffer);
				scanf("%s",pswd);

				//envio password
				if(send(sd,pswd,15,0)==-1)
					perror("Cliente:Send"),exit(1);


				//recibo confirmacion
			   	if(recv(sd,buffer,500,0)==-1)
			 		perror("Cliente:Recv"),exit(1);

				printf("%s",buffer);


			}

		break;

		default: printf("Saliendo...\n"); break;


	}

	
}
