function [file1,fileout11,fileout12,fileout13,file2,fileout21,fileout22,fileout23] = ProcesamientoIris

%Procesamiento de Iris1.txt
file1 = fopen('Iris1.txt');
fileout11 = fopen ('Entrena.txt', 'w');
fileout12 = fopen('Salida2.txt', 'w');
fileout13 = fopen('Salida3.txt', 'w');

%salto las lineas que forman la cabecera
fgetl(file1);
fgetl(file1);
fgetl(file1);
fgetl(file1);
fgetl(file1);
fgetl(file1);
fgetl(file1);
fgetl(file1);
fgetl(file1);
%leo la primera linea
linea = fgetl(file1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Para comprobar que el fichero lo lee bien: leo linea a linea y muestro
%cada linea para ver que no existen cabeceras

%while ischar(linea)
%    disp(linea)
%    linea = fgetl(file1);
%end
%
%fclose(file1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%comienzo a leer todo el archivo
while length(linea) > 2
    
    i = 1;%para leer caracter a caracter
    entrada = '';
    veces = 0;

    %leo hasta que no llego a la palabra Iris......
    while strcmp(linea(i),'I') == 0 

        %leo hasta que no llego a una coma
        if strcmp(linea(i),',') == 0 

            entrada = strcat(entrada,linea(i));

        else

            fprintf(fileout11,entrada);%escribo en el fichero lo que llevo

                if veces < 3 %agrego un espacio para separar los datos mientras 
                             %no haya introducido  las 4 columnas de datos

                    veces = veces + 1;    
                    fprintf(fileout11, char(32));%agrego el espacio

                end

                entrada = '';
                i = i + 1; %paso al caracter siguiente

        end 

        i = i + 1; %paso al caracter siguiente

    end
    
    fprintf(fileout11, char(13)); %escribo un salto de linea en el fichero

    while strcmp(linea(i),'-') == 0 %leo hasta llegar donde dice el tipo
       
        i = i+1;
        
    end
    
    if(strcmp(linea(i + 1),'s') == 1)%si empieza por s, ya se que es sestos
        
       fprintf(fileout12,'1 0\n');
       fprintf(fileout13,'1 0 0\n');
        
    end
    
    %si empieza por v, puede ser versicolor o virginica, asi que tengo que ver 
    %tambien la segunda letra
    
    if(strcmp(linea(i + 1),'v') == 1 && strcmp(linea(i + 2),'e') == 1)%versicolor
        
       fprintf(fileout12,'0 1\n');
       fprintf(fileout13,'0 1 0\n');
        
    end
    
    if(strcmp(linea(i + 1),'v') == 1 && strcmp(linea(i + 2),'i') == 1)%virginica
        
       fprintf(fileout12,'1 1\n');
       fprintf(fileout13,'0 0 1\n');
        
    end

    fgetl(file1);%me salto la linea en blanco
    linea = fgetl(file1);%leo una nueva linea

end
    
%cierro los ficheros
fclose(fileout11);
fclose(fileout12);
fclose(fileout13);
fclose(file1);



%Procesamiento de Iris2.txt
file2 = fopen('Iris2.txt');
fileout21 = fopen ('TestEntrada.txt', 'w');
fileout22 = fopen('TestSalida2.txt', 'w');
fileout23 = fopen('TestSalida3.txt', 'w');

%salto las lineas que forman la cabecera
fgetl(file2);
fgetl(file2);
fgetl(file2);
fgetl(file2);
fgetl(file2);
fgetl(file2);
fgetl(file2);
fgetl(file2);
fgetl(file2);
%leo la primera linea
linea = fgetl(file2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Para comprobar que el fichero lo lee bien: leo linea a linea y muestro
%cada linea para ver que no existen cabeceras

%while ischar(linea)
%    disp(linea)
%    linea = fgetl(file2);
%end
%
%fclose(file2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%comienzo a leer todo el archivo
while length(linea) > 2
    
    i = 1;%para leer caracter a caracter
    entrada = '';
    veces = 0;

    %leo hasta que no llego a la palabra Iris......
    while strcmp(linea(i),'I') == 0 

        %leo hasta que no llego a una coma
        if strcmp(linea(i),',') == 0 

            entrada = strcat(entrada,linea(i));

        else

            fprintf(fileout21,entrada);%escribo en el fichero lo que llevo

                if veces < 3 %agrego un espacio para separar los datos mientras 
                             %no haya introducido las 4 columnas de datos

                    veces = veces + 1;    
                    fprintf(fileout21, char(32));%agrego el espacio

                end

                entrada = '';
                i = i + 1; %paso al caracter siguiente

        end 

        i = i + 1; %paso al caracter siguiente

    end
    
    fprintf(fileout21, char(13)); %escribo un salto de linea en el fichero

    while strcmp(linea(i),'-') == 0 %leo hasta llegar donde dice el tipo
       
        i = i+1;
        
    end
    
    if(strcmp(linea(i + 1),'s') == 1)%si empieza por s, ya se que es sestos
        
       fprintf(fileout22,'1 0\n');
       fprintf(fileout23,'1 0 0\n');
        
    end
    
    %si empieza por v, puede ser versicolor o virginica, asi que tengo que ver 
    %tambien la segunda letra
    
    if(strcmp(linea(i + 1),'v') == 1 && strcmp(linea(i + 2),'e') == 1)%versicolor
        
       fprintf(fileout22,'0 1\n');
       fprintf(fileout23,'0 1 0\n');
        
    end
    
    if(strcmp(linea(i + 1),'v') == 1 && strcmp(linea(i + 2),'i') == 1)%virginica
        
       fprintf(fileout22,'1 1\n');
       fprintf(fileout23,'0 0 1\n');
        
    end

    fgetl(file2);%me salto la linea en blanco
    linea = fgetl(file2);%leo una nueva linea

end
    
%cierro los ficheros
fclose(fileout21);
fclose(fileout22);
fclose(fileout23);
fclose(file2);

