function [output1,output2] = ProcesarArchivosLogaritmo(fichero)

output1 = 'EntrenaModIn.txt';
output2 = 'EntrenaModOutLog.txt';

if strcmp(fichero,'Funcion2Entrena.txt')
    
    ficheroIn = 'EntrenaModIn.txt';
    ficheroOut = 'EntrenaModOut.txt';
    ficheroOut1 = 'EntrenaModOutLog.txt'
    
else
    
    ficheroIn = 'TestModIn.txt';
    ficheroOut = 'TestModOut.txt';
    ficheroOut1 = 'TestModOutLog.txt'
    
end

fileid = fopen(fichero);
filein = fopen(ficheroIn, 'w');
fileout = fopen(ficheroOut,'w');


%salto las lineas de comentarios
fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
linea = fgetl(fileid);

while length(linea) ~= 1%comienzo a leer lineas del fichero
    
    linea = fgetl(fileid);
    entrada = '';
    for i = 1:length(linea) %leo caracter a caracter toda la linea
    
        if linea(i) ~= ' ' && i ~= length(linea) 
            
            entrada = strcat(entrada,linea(i));
           
        else if linea(i) == ' '
                
                fprintf(filein, entrada);
                fprintf(filein, char(32));
                entrada = '';
               
            else
                entrada = strcat(entrada,linea(i));%le añado el ultimo caracter y escribo en el fichero
                fprintf(filein, entrada);
                fprintf(filein, char(13));
                entrada = '';
                
            end
        end
   
    end
    
    fgetl(fileid); %me salto el comentario
    linea = fgetl(fileid); %leo la siguiente linea
    
    fprintf(fileout, linea);
    fprintf(fileout, char(13));
    linea = fgetl(fileid);
    
    
end

fclose(fileid);
fclose(filein);
fclose(fileout);


%proceso el archivo y lo transformo logaritmicamente
filein = fopen(ficheroOut,'r');
fileout = fopen(ficheroOut1,'w');

linea = fgetl(fileid);

while length(linea) ~= 1
    
    numero = str2double(linea);
    entrada = '';
   
    numero = log(numero + 1); %aplico la transformacion logaritmica
    
    entrada = num2str(numero);
    fprintf(fileout, entrada);
    fprintf(fileout, char(13));
    
    linea = fgetl(fileid);
    
    
end

fclose(filein);
fclose(fileout);
