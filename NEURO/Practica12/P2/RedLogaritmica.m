
%limpio todas las variables creadas en anteriores ejecuciones
clear all;
%limpio la pantalla para no mezclar resultados
clc;

%proceso los archivos por si no estan procesados
ProcesarArchivosLogaritmo('Funcion2Test.txt');
ProcesarArchivosLogaritmo('Funcion2Entrena.txt');

file = fopen('ResultadosLog.txt', 'w');
    
for iter = 1:10

    fileIn = fopen('TestModIn.txt');
    fileOut = fopen('TestModOut.txt');
    file = fopen('ResultadosLog.txt', 'a');


    entrena = dlmread('EntrenaModIn.txt',' ');
    salidaModEntrena = dlmread('EntrenaModOutLog.txt',' ');
    test = dlmread('TestModIn.txt',' ');
    salidaModTest = dlmread('TestModOutLog.txt',' ');
    salida = dlmread('TestModOut.txt',' ');


    inputs = entrena';
    targets = salidaModEntrena';
    testTargets = salidaModTest';
    testInputs = test';
    
    net = feedforwardnet([5]);%capas y neuronas de cada capa

    net.divideFcn = 'dividerand';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 20/100;
    net.divideParam.testRatio = 0/100;

    net.trainFcn = 'trainlm';  % Levenberg-Marquardt

    net.performFcn = 'mse';  % Mean squared error

    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
      'plotregression', 'plotfit'};


    % Train the Network
    [net,tr] = train(net,inputs,targets);


    % Test the Network
    outputs = net(testInputs);
    outputs = round (outputs);
    %errors = gsubtract(testTargets,outputs);
    performance = perform(net,testTargets,outputs);
    errorAux(iter) = double(performance);
    e = 2,718282818;
    tam = size(outputs);


    %imprimo una cabecera en el archivo ResultadosLog
    fprintf(file,'# (E   E)');
    fprintf(file,char(09));
    fprintf(file,'SEsp');
    fprintf(file,char(09));
    fprintf(file,'Salida');
    fprintf(file,char(09));
    fprintf(file,'Error\n');    
    
    for i = 1:tam(2)

        linea = fgetl(fileIn);%entrada
        fprintf(file,linea);
        fprintf(file,char(09));
        linea = fgetl(fileOut);%salidaEsperada
        fprintf(file,linea);
        fprintf(file,char(09));
        numero = str2double(linea);

        numeroAux = e^outputs(i)- 1; %la inversa de log(x+1) = e^x-1

        fprintf(file,num2str(abs(numeroAux)));%salida con transf. deshecha
        fprintf(file,char(09));

        error = round(numero-numeroAux);

        fprintf(file,num2str(error));%error
        fprintf(file,char(13));


    end
    fclose(file);
    file = fopen('ResultadosLog.txt');
    for i = 1:tam(2)
       fgetl(file) 
    end
    
    fclose(fileIn);
    fclose(fileOut);
    fclose(file);

end%fin iter

mediaError = mean (errorAux)

