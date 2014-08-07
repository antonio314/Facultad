echo off;
clc;
clear all;
entrada1 = dlmread('entradaProcesada.txt');
objetivo = dlmread('Salida.txt');

entrada = zeros(4026*2,40);


i = 1;
h = 1;

while i < 4027
    
    j = 2;
    
   while j < 42
       
       if entrada1(i,j) < 0
           
          entrada(h+1,j-1) = 1; 
          entrada(h,j-1) = 0; 
           
       else
           
          entrada(h,j-1) = 1;
          entrada(h+1,j-1) = 0; 
           
       end
       
       j = j + 1;
       
   end
   
   h = h + 2;
       
   i = i + 1;
    
end

net1 = feedforwardnet(67);
inputs = entrada(:,1:30);
targets = objetivo(1:30,:)';
%net = newff(inputs,targets,67);

net1.divideFcn = 'divideblock';  % Divide data randomly
net1.divideMode = 'sample';  % Divide up every sample
net1.divideParam.trainRatio = 80/100;
net1.divideParam.valRatio = 20/100;
net1.divideParam.testRatio = 0/100;


net1.trainFcn = 'trainscg';  % Resilient backpropagation

net1.trainParam.goal = 0.2;
net1.trainParam.max_fail = 6;
net1.trainParam.epochs = 300;

net1.layers{2}.transferFcn = 'purelin';
net1.performFcn = 'mse';  % Mean squared error
net1.layers{1}.initFcn = 'initnw';

net1.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net1 = configure(net1,inputs,targets);
erroresTotales = 0;

donantesCorrectos = zeros(30,2);
j = 1;

% PRIMEROS 30 para el conjunto de entrenamiento
inputs = entrada(:,1:30);
targets = objetivo(1:30,:)';
net1 = configure(net1,inputs,targets);
% Train the Network
[net1,tr] = train(net1,inputs,targets);

testInputs = entrada(:,31:40);
testTargets = objetivo(31:40,:)';

% Test the Network
%outputs = net(testInputs)
outputs1 = sim(net1, testInputs);
outputsAux = outputs1;
outputsAux(outputsAux >= 0.5) = 1;
outputsAux(outputsAux < 0.5)= 0;
errors = outputsAux - testTargets;
errores1 = sum(abs(errors))
erroresTotales = erroresTotales + errores1;
performance = perform(net1,testTargets,outputs1);

i = 1;

while(i<=10)
    
    if(errors(i) == 0)
        
        donantesCorrectos(j,1)= i + 30;
        donantesCorrectos(j,2)= outputs1(i) - testTargets(i);
        j = j + 1;
        
    end
    
    i= i + 1;
    
end

net2 = feedforwardnet(67); %67 neuronas en la capa intermedia, para el resto, igual
%inputs = entrada(:,1:30);
%targets = objetivo(1:30,:)';
%net = newff(inputs,targets,67);

net2.divideFcn = 'divideblock';  % Divide data randomly
net2.divideMode = 'sample';  % Divide up every sample
net2.divideParam.trainRatio = 80/100;
net2.divideParam.valRatio = 20/100;
net2.divideParam.testRatio = 0/100;


net2.trainFcn = 'trainrp';  % Levenberg-Marquardt

net2.trainParam.goal = 0.1;
net2.trainParam.max_fail = 6;
net2.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net2.layers{2}.transferFcn = 'purelin';
net2.performFcn = 'mse';  % Mean squared error
net2.layers{1}.initFcn = 'initnw';

net2.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

% SEGUNDOS 30 para el conjunto de entrenamiento

%net = init(net);

inputs = entrada(:,11:40);
targets = objetivo(11:40,:)';
net2 = configure(net2,inputs,targets);
% Train the Network
[net2,tr] = train(net2,inputs,targets);

testInputs = entrada(:,1:10);
testTargets = objetivo(1:10,:)';

% Test the Network
%outputs = net(testInputs)
outputs2 = sim(net2, testInputs);
outputsAux = outputs2;
outputsAux(outputsAux >= 0.5) = 1;
outputsAux(outputsAux < 0.5) = 0;
errors = testTargets - outputsAux;
errores2 = sum(abs(errors))
erroresTotales = erroresTotales + errores2;
performance = perform(net2,testTargets,outputs2);

i = 1;

while(i<=10)
    
    if(errors(i) == 0)
        
        donantesCorrectos(j,1)= i;
        donantesCorrectos(j,2)= outputs2(i) - testTargets(i);
        j = j + 1;
        
    end
    
    i= i + 1;
    
end


% TERCEROS 30 para el conjunto de entrenamiento

net3 = feedforwardnet(67);
%inputs = entrada(:,1:30);
%targets = objetivo(1:30,:)';
%net = newff(inputs,targets,67);

net3.divideFcn = 'divideblock';  % Divide data randomly
net3.divideMode = 'sample';  % Divide up every sample
net3.divideParam.trainRatio = 80/100;
net3.divideParam.valRatio = 20/100;
net3.divideParam.testRatio = 0/100;


net3.trainFcn = 'trainrp';  % Levenberg-Marquardt

net3.trainParam.goal = 0.1;
net3.trainParam.max_fail = 12;
net3.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net3.layers{2}.transferFcn = 'purelin';
net3.performFcn = 'mse';  % Mean squared error
net3.layers{1}.initFcn = 'initnw';

net3.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

inputs = [entrada(:,21:40) entrada(:,1:10)];
targets = [objetivo(21:40,:)' objetivo(1:10,:)'];
net3 = configure(net3,inputs,targets);
% Train the Network
[net3,tr] = train(net3,inputs,targets);

testInputs = entrada(:,11:20);
testTargets = objetivo(11:20,:)';

% Test the Network
%outputs = net(testInputs)
outputs3 = sim(net3, testInputs);
outputsAux = outputs3;
outputsAux(outputsAux >= 0.5) = 1;
outputsAux(outputsAux < 0.5) = 0;
errors = testTargets - outputsAux;
errores3 = sum(abs(errors))
erroresTotales = erroresTotales + errores3;
performance = perform(net3,testTargets,outputs3);


i = 1;

while(i<=10)
    
    if(errors(i) == 0)
        
        donantesCorrectos(j,1)= i + 10;
        donantesCorrectos(j,2)= outputs3(i) - testTargets(i);
        j = j + 1;
        
    end
    
    i= i + 1;
    
end


% CUARTOS 30 para el conjunto de entrenamiento


net4 = feedforwardnet(67);
%inputs = entrada(:,1:30);
%targets = objetivo(1:30,:)';
%net = newff(inputs,targets,67);

net4.divideFcn = 'divideblock';  % Divide data randomly
net4.divideMode = 'sample';  % Divide up every sample
net4.divideParam.trainRatio = 80/100;
net4.divideParam.valRatio = 20/100;
net4.divideParam.testRatio = 0/100;


net4.trainFcn = 'trainrp';  % Levenberg-Marquardt

net4.trainParam.goal = 0.1;
net4.trainParam.max_fail = 12;
net4.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net4.layers{2}.transferFcn = 'purelin';
net4.performFcn = 'mse';  % Mean squared error
net4.layers{1}.initFcn = 'initnw';

net4.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

inputs = [entrada(:,31:40) entrada(:,1:20)];
targets = [objetivo(31:40,:)' objetivo(1:20,:)'];
net4 = configure(net4,inputs,targets);
% Train the Network
[net4,tr] = train(net4,inputs,targets);

testInputs = entrada(:,21:30);
testTargets = objetivo(21:30,:)';

% Test the Network
%outputs = net(testInputs)
outputs4 = sim(net4, testInputs);
outputsAux = outputs4;
outputsAux(outputsAux >= 0.5) = 1;
outputsAux(outputsAux < 0.5) = 0;
errors = testTargets - outputsAux;
errores4 = sum(abs(errors))
erroresTotales = erroresTotales + errores4
performance = perform(net4,testTargets,outputs4);

i = 1;

while(i<=10)
    
    if(errors(i) == 0)
        
        donantesCorrectos(j,1)= i + 20;
        donantesCorrectos(j,2)= outputs4(i) - testTargets(i);
        j = j + 1;
        
    end
    
    i= i + 1;
    
end


porcentajeAciertos = (40 - erroresTotales)*100/40
donantesCorrectos;

donantesFinales = zeros(12,2);

i = 1;

%Pongo la diferencia con respecto a lo que tendría que dar
while donantesCorrectos(i,1) > 0

    donantesCorrectos(i,2) = abs(donantesCorrectos(i,2) - objetivo(donantesCorrectos(i,1))'); 

    i = i + 1;
    
end

donantesCorrectos

i = 1;

%cojo los primeros 12 elementos
while i <= 12
    
    donantesFinales(i,1) = donantesCorrectos(i,1);
    donantesFinales(i,2) = donantesCorrectos(i,2); 
    
    i = i + 1;
    
end


%Mientras queden elementos comprobamos para introducirlos
while donantesCorrectos(i,1) > 0
    
    j = 2;
    
    peorResultado = [ 1  donantesFinales(1,2)];
    
    while j <= 12
    
        if(peorResultado(2) < donantesFinales(j,2));
    
            peorResultado(1,1) = j;
            peorResultado(1,2) = donantesFinales(j,2);
            
        end
        
        j = j + 1;
        
    end
    
    if donantesCorrectos(i,2) < peorResultado(2)
    
        donantesFinales(peorResultado(1),1) = donantesCorrectos(i,1);
        donantesFinales(peorResultado(1),2) = donantesCorrectos(i,2);

    end
    
    i = i + 1;
end

donantesFinales

   
%%%%%%%%%%%%%%%% CAMBIO DE GENES %%%%%%%%%%%%%%%%%%%%

variacionGenes = zeros(4026,13);
variacionGenes(:,13) = [1:4026];

i = 1;
j = 1;

disp('Ten paciencia. El proceso puede tardar bastante dependiendo de tu ordenador...');
while i < 4027
   %i

    k = 1;

    while k < 13

        entrada(i*2,donantesFinales(k,1)) = entrada(i*2,donantesFinales(k,1)) * 0.85;
        entrada(i*2-1,donantesFinales(k,1)) = entrada(i*2-1,donantesFinales(k,1)) * 0.85;

        k = k + 1;

    end


        
  
    
    %%% Evaluamos
    erroresGenes = 0;
    %PRIMERA
    testInputs = entrada(:,31:40);
    testTargets = objetivo(31:40,:)';
    outputs11 = sim(net1, testInputs);
    outputsAux = outputs11;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux < 0.5) = 0;
    errors = gsubtract(testTargets,outputsAux);
    errores1 = sum(abs(errors));
    erroresGenes = erroresGenes + errores1;
    %SEGUNDA
    testInputs = entrada(:,1:10);
    testTargets = objetivo(1:10,:)';
    outputs12 = sim(net2, testInputs);
    outputsAux = outputs12;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux < 0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores2 = sum(abs(errors));
    erroresGenes = erroresGenes + errores2;
    %TERCERA
    testInputs = entrada(:,11:20);
    testTargets = objetivo(11:20,:)';
    outputs13 = sim(net3, testInputs);
    outputsAux = outputs13;
    outputsAux(outputsAux > 1) = 1;
    outputsAux(outputsAux<0)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores3 = sum(abs(errors));
    erroresGenes = erroresGenes + errores3;
    %CUARTA
    testInputs = entrada(:,21:30);
    testTargets = objetivo(21:30,:)';
    outputs14 = sim(net4, testInputs);
    outputsAux = outputs14;
    outputsAux(outputsAux > 1) = 1;
    outputsAux(outputsAux<0)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores4 = sum(abs(errors));
    erroresGenes = erroresGenes + errores4;
    
    outputs21 = abs(outputs11 - outputs1);
    outputs22 = abs(outputs12 - outputs2);
    outputs23 = abs(outputs13 - outputs3);
    outputs24 = abs(outputs14 - outputs4);
    
    res = [outputs22 outputs23 outputs24 outputs21];
    
    
    k = 1;

    while k < 13

        variacionGenes(i,k) = res(donantesFinales(k,1));

        k = k + 1;

    end

    k = 1;

    while k < 13

        entrada(i*2,donantesFinales(k,1)) = entrada(i*2,donantesFinales(k,1)) * (1/0.85);
        entrada(i*2-1,donantesFinales(k,1)) = entrada(i*2-1,donantesFinales(k,1)) * 1/(0.85);


        k = k + 1;

    end


    i = i + 1;
    
end

donante1 = sortrows([variacionGenes(:,1) variacionGenes(:,13)], 1);
donante2 = sortrows([variacionGenes(:,2) variacionGenes(:,13)], 1);
donante3 = sortrows([variacionGenes(:,3) variacionGenes(:,13)], 1);
donante4 = sortrows([variacionGenes(:,4) variacionGenes(:,13)], 1);
donante5 = sortrows([variacionGenes(:,5) variacionGenes(:,13)], 1);
donante6 = sortrows([variacionGenes(:,6) variacionGenes(:,13)], 1);
donante7 = sortrows([variacionGenes(:,7) variacionGenes(:,13)], 1);
donante8 = sortrows([variacionGenes(:,8) variacionGenes(:,13)], 1);
donante9 = sortrows([variacionGenes(:,9) variacionGenes(:,13)], 1);
donante10 = sortrows([variacionGenes(:,10) variacionGenes(:,13)], 1);
donante11 = sortrows([variacionGenes(:,11) variacionGenes(:,13)], 1);
donante12 = sortrows([variacionGenes(:,12) variacionGenes(:,13)], 1);

mejoresGenes = sort([donante1(3000:4026,2) donante2(3000:4026,2) donante3(3000:4026,2) donante4(3000:4026,2) donante5(3000:4026,2) donante6(3000:4026,2)  donante7(3000:4026,2) donante8(3000:4026,2) donante9(3000:4026,2) donante10(3000:4026,2) donante11(3000:4026,2) donante12(3000:4026,2)]);

k = 1;

genesFinales = zeros(1000,2);

i = 1;

while k < 4027
    
    index = find(mejoresGenes == k);
    
    rep = size(index);
    
    if(rep(1)>4)
        
       genesFinales(i,1) = k;
       genesFinales(i,2) = rep(1);
       
       i = i + 1;
        
    end
    
    k = k + 1;
    
end

porcentajeAciertos = (40 - erroresTotales)*100/40

%los ordeno para que me sea más sencillo guardar los mejores
genesF = sortrows([genesFinales(:,1) genesFinales(:,2)], 2);

%como en el guión dice "alrededor de 34 (numero orientativo)", voy a coger
%34 justamente
dlmwrite('mejoresGenes.txt', genesF(967:1000,1));
    