function[] = PracticaIris (ficheroSalida, ficheroTestSalida);

% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by NPRTOOL
% Created Thu Apr 11 01:05:28 CEST 2013
%
% This script assumes these variables are defined:
%
%   Entrena - input data.
%   Salida2 - target data.

clear all; %limpio todas las variables creadas en anteriores ejecuciones
clc; %limpio la pantalla para que no se mezclen resultados

    
ProcesamientoIris();%llamo a la funcion ProcesamientoIris para que obtenga 
                    %los ficheros de entrada y test si no estan creados

mediaError2 = 0;
mediaAciertos2 = 0;

mediaError3 = 0;
mediaAciertos3 = 0;

for ens = 1:10 %para realizar 10 ensayos
    Entrena = dlmread('Entrena.txt',' ');
    Salida2 = dlmread('Salida2.txt',' ');
    Salida3 = dlmread('Salida3.txt',' ');
    TestEntrada = dlmread('TestEntrada.txt', ' ');
    TestSalida2 = dlmread('TestSalida2.txt', ' ');
    TestSalida3 = dlmread('TestSalida3.txt', ' ');
    
    inputs = Entrena';
    targets2 = Salida2';
    targets3 = Salida3';
    
    testInputs = TestEntrada';
    testTargets2 = TestSalida2';
    testTargets3 = TestSalida3';

    %  R E D para salida con 2 neuronas
    
    % Create a Pattern Recognition Network
    net2 = feedforwardnet([5 10]);
    net2.trainParam.showWindow= false;
    net2.trainParam.showCommandLine = false;

    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivide
    net2.divideFcn = 'dividerand';  % Divide data randomly
    net2.divideMode = 'sample';  % Divide up every sample
    net2.divideParam.trainRatio = 80/100;
    net2.divideParam.valRatio = 20/100;
    net2.divideParam.testRatio = 0/100;

    % For help on training function 'trainlm' type: help trainlm
    % For a list of all training functions type: help nntrain
    net2.trainFcn = 'trainlm';  % Levenberg-Marquardt

    % Choose a Performance Function
    % For a list of all performance functions type: help nnperformance
    net2.performFcn = 'mse';  % Mean squared error

    % Choose Plot Functions
    % For a list of all plot functions type: help nnplot
    net2.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
      'plotregression', 'plotfit'};
  
  
  
    % R E D para salida con 3 neuronas
  
    % Create a Pattern Recognition Network
    net3 = feedforwardnet([10]);
    net3.trainParam.showWindow= false;
    net3.trainParam.showCommandLine = false;


    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivide
    net3.divideFcn = 'dividerand';  % Divide data randomly
    net3.divideMode = 'sample';  % Divide up every sample
    net3.divideParam.trainRatio = 80/100;
    net3.divideParam.valRatio = 20/100;
    net3.divideParam.testRatio = 0/100;

    % For help on training function 'trainlm' type: help trainlm
    % For a list of all training functions type: help nntrain
    net3.trainFcn = 'trainlm';  % Levenberg-Marquardt

    % Choose a Performance Function
    % For a list of all performance functions type: help nnperformance
    net3.performFcn = 'mse';  % Mean squared error

    % Choose Plot Functions
    % For a list of all plot functions type: help nnplot
    net3.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
      'plotregression', 'plotfit'};


    % Train the Network
    [net2,tr2] = train(net2,inputs,targets2);
    [net3,tr3] = train(net3,inputs,targets3);

    % Test the Network
    outputsaux2 = net2(testInputs);
    outputs2 = round(outputsaux2);
    
    outputsaux3 = net3(testInputs);
    outputs3 = round(outputsaux3);
    
    errors2 = gsubtract(testTargets2,outputs2);
    errors3 = gsubtract(testTargets3,outputs3);
    
    performance2 = perform(net2,testTargets2,outputs2);
    performance3 = perform(net3,testTargets3,outputs3);
    
    errorAux2(ens) = performance2;
    errorAux3(ens) = performance3;
    
    tam2 = size(outputs2);
    fallos2 = 0;

    %cuento el numero de fallos para calcular el porcentaje de acierto
    %cuando hay 2 neuronas en la salida
    for i = 1:tam2(2)

        valor = abs(errors2(1,i)) + abs(errors2(2,i));%calculo el valor del error

        if  valor > 0%si el error es >0, existe fallo y aumento los fallos en 1

            fallos2 = fallos2 + 1;

        end

    end

    porcentajeFallos2 = (fallos2 * 100)/30;
    porcentajeAciertos2 = 100 - porcentajeFallos2;
    aciertosAux2(ens) = porcentajeAciertos2;


    tam3 = size(outputs3);
    fallos3 = 0;
    %cuento el numero de fallos para calcular el porcentaje de acierto
    %cuando hay 2 neuronas en la salida
    for i = 1:tam3(2)

        valor = abs(errors3(1,i)) + abs(errors3(2,i));%calculo el valor del error

        if  valor > 0%si el error es >0, existe fallo y aumento los fallos en 1

            fallos3 = fallos3 + 1;

        end

    end

    porcentajeFallos3 = (fallos3 * 100)/30;
    porcentajeAciertos3 = 100 - porcentajeFallos3;
    aciertosAux3(ens) = porcentajeAciertos3;
    
end %fin del for de ensayos

%calculo la media de los 10 ensayos realizados 
%para el error y los aciertos
mediaError2 = mean (errorAux2)
mediaAciertos2 = mean (aciertosAux2)

mediaError3 = mean (errorAux3)
mediaAciertos3 = mean (aciertosAux3)

