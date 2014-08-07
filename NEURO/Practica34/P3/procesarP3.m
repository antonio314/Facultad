datos = xlsread('Datos_Microarrays_Cancer.xls',1,'2:4027');

fileid = fopen('DLCL_Supervivencia.txt');

fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
linea = fgetl(fileid);

j = 1;
poblacion = zeros(40,1);
salida = zeros(40,1);

while length(linea) > 2  
   
    i = 1;
    entrada = '';
    
    while strcmp(linea(i),' ') == 0 
    
        i = i + 1;
        
    end
    while strcmp(linea(i),' ') == 1 
    
        i = i + 1;
        
    end
    while strcmp(linea(i),' ') == 0 
    
        entrada = strcat(entrada,linea(i));
        i = i + 1;
        
    end
    
    poblacion(j) = str2num(entrada);
    
    while strcmp(linea(i),' ') == 1 
    
        i = i + 1;
        
    end
    
    while strcmp(linea(i),' ') == 0 
    
        i = i + 1;
        
    end
    while strcmp(linea(i),' ') == 1 
    
        i = i + 1;
        
    end
    
    salida(j) = str2num(linea(i));
    j= j +1;
    linea = fgetl(fileid);
    %linea ='';
end

poblacion;
salida;

poblacionEscribir = zeros(4026,41);

j = 1;
poblacionEscribir(:,j) = datos(:,j);

while j < 41;

    poblacionEscribir(:,j + 1) = datos(:,poblacion(j) + 3);
    
    j = j + 1;

end

dlmwrite('EntradaP3.txt', poblacionEscribir, ' ');
dlmwrite('SalidaP3.txt', salida);
