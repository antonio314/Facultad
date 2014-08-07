function [output1,output2] = ProcesarArchivosIntervalos(fichero)

output1 = 'EntrenaModIn.txt';
output2 = 'EntrenaModOutInt.txt';

if strcmp(fichero,'Funcion2Entrena.txt')
    
    ficheroIn = 'EntrenaModIn.txt';
    ficheroOut = 'EntrenaModOut.txt';
    ficheroOut1 = 'EntrenaModOutInt.txt'
    
else
    
    ficheroIn = 'TestModIn.txt';
    ficheroOut = 'TestModOut.txt';
    ficheroOut1 = 'TestModOutInt.txt'
    
end

fileid = fopen(fichero);
filein = fopen(ficheroIn, 'w');
fileout = fopen(ficheroOut,'w');


fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
fgetl(fileid);
linea = fgetl(fileid);

while length(linea) ~= 1
    
    linea = fgetl(fileid);
    entrada = '';
    for i = 1:length(linea)
    
        if linea(i) ~= ' ' && i ~= length(linea) 
            
            entrada = strcat(entrada,linea(i));
           
        else if linea(i) == ' '
                
                fprintf(filein, entrada);
                fprintf(filein, char(32));
                entrada = '';
               
            else
                
                fprintf(filein, entrada);
                fprintf(filein, char(13));
                entrada = '';
                
            end
        end
   
    end
    
    fgetl(fileid);
    linea = fgetl(fileid);
    
    fprintf(fileout, linea);
    fprintf(fileout, char(13));
    linea = fgetl(fileid);
    
    
end

fclose(fileid);
fclose(filein);
fclose(fileout);


filein = fopen(ficheroOut,'r');
fileout = fopen(ficheroOut1,'w');

salida = fopen(ficheroOut,'r');
linea = fgetl(salida);
num = str2double(linea);
max = num;
    
while length(linea) ~= 1 %calculo el máximo de la lista
    
    num = str2double(linea);

    if num > max 
        
        max = num;
        
    end

    linea = fgetl(salida);
end
       
intervalos = 1;
while max > 10 %calculo el número de intervalos
        
        max = max / 10;
        intervalos = intervalos + 1;
end

%para la primera iteracion se conocen los siguientes datos
cota_inf = 0;
cota_sup = 10;
error = 1;
origen = [0 0];
coeficientes(1,:) = [0 0]; %esta es mi amtriz de coeficientes

for i = 1:intervalos
    %calculo la recta en el intervalo actual
    coeficientes(i,:) = recta(origen, error);

    %actualiza para la siguiente iteracion
    cota_inf = cota_sup;
    cota_sup = cota_sup * 10;
    error = error * 10;
    origen = [cota_inf, aproximacionLineal(coeficientes(i,:), cota_inf)];
end
fclose(salida);  
salida2 = fopen(ficheroOut,'r');
linea = fgetl(salida2);
i=1;

while ischar(linea) %calculo el máximo de la lista
    x = str2num(linea);
    %para ver al intervalo que pertenece
    intervalo = 1;
    while x > 10 
            x = x / 10;
            intervalo = intervalo + 1;
    end

    coefs = coeficientes(intervalo,:);
    salidas_proc(1,i) = aproximacionLineal(coefs, x);

    linea = fgetl(salida2);
    i = i + 1;
    
end

%escribo las salidas procesadas en el fichero correspondiente
tam = size(salidas_proc);

for i=1:tam(2)
    
    entrada = num2str(salidas_proc(1,i));
    fprintf(fileout, entrada);
    fprintf(fileout, char(13));
    
end

fclose(filein);
fclose(fileout);
fclose(salida2);


end

function [transf] = aproximacionLineal(coeficientes, x)
%transforma el número
    a= coeficientes(1,1);
    b = coeficientes(1,2);
    transf = a*x + b;
end

function [coeficientes] = recta(origen, error)%la recta tiene la forma y = a * x + b
%calcula los coeficientes de la recta que pasa por el origen y tiene la pendiente que hace que cumpla el error
    x = origen(1);
    y = origen(2);
    a = 1/(error * 10.0);
    b = y - a*x;
    coeficientes = [a b];
end
