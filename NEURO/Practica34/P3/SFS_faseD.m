mejoresGenes = dlmread('mejoresGenesSFS.txt');

mejoresGenes = sort(mejoresGenes);

entrada1 = dlmread('entradaProcesada.txt');
objetivo = dlmread('SalidaP3.txt');

tam = size(mejoresGenes);
valor = tam(1);
entrada = zeros(tam(1),40);

k = 1;
i = 1;
h = 1;

while k <= tam(1)

    entrada(k,:) = entrada1(mejoresGenes(k),2:41);   

    k = k + 1;

end


net1 = feedforwardnet([67]);

net1.divideFcn = 'dividerand';  % Divide data randomly
net1.divideMode = 'sample';  % Divide up every sample
net1.divideParam.trainRatio = 80/100;
net1.divideParam.valRatio = 20/100;
net1.divideParam.testRatio = 0/100;

net1.trainFcn = 'trainrp';  % Levenberg-Marquardt

net1.trainParam.goal = 0.08;
net1.trainParam.max_fail = 18;
net1.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net1.layers{2}.transferFcn = 'tansig';
net1.performFcn = 'mse';  % Mean squared error

net1.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net1.trainParam.showWindow = 0;

erroresTotales = 0;

%37-40

inputs = entrada(:,1:36);
targets = objetivo(1:36,:)';
testInputs = entrada(:,37:40);
testTargets = objetivo(37:40,:)';

errores1 = ones(10,1) * 10;

i = 1;

while i <= 10
    
    net1 = init(net1);
    
    % Train the Network
    [net1,tr] = train(net1,inputs,targets);



    % Test the Network
    %outputs = net(testInputs)
    outputs1 = sim(net1, testInputs);
    outputsAux = ceil(outputs1);
    outputsAux(outputsAux > 1) = 1;
    outputsAux(outputsAux<0)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores1(i) = sum(abs(errors));
    
    performance = perform(net1,testTargets,outputs1);

    i = i + 1;
    
end

errores1 = sort(errores1);
err1 = errores1(1)
erroresTotales = erroresTotales + errores1(1);

%1-4

net2 = feedforwardnet([67]);

net2.divideFcn = 'dividerand';  % Divide data randomly
net2.divideMode = 'sample';  % Divide up every sample
net2.divideParam.trainRatio = 80/100;
net2.divideParam.valRatio = 20/100;
net2.divideParam.testRatio = 0/100;

net2.trainFcn = 'trainrp';  % Levenberg-Marquardt

net2.trainParam.goal = 0.08;
net2.trainParam.max_fail = 12;
net2.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net2.layers{2}.transferFcn = 'purelin';
net2.layers{1}.transferFcn = 'tansig';
net2.performFcn = 'mse';  % Mean squared error
net2.trainParam.showWindow = 0;

net2.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};


net2 = init(net2);

inputs = entrada(:,5:40);
targets = objetivo(5:40,:)';
testInputs = entrada(:,1:4);
testTargets = objetivo(1:4,:)';


errores2 = ones(10,1) * 10;

i = 1;

while i <= 10

    net2 = init(net2);
    
    % Train the Network
    [net2,tr] = train(net2,inputs,targets);



    % Test the Network
    outputs1 = net2(testInputs);
    %outputs1 = sim(net2, testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores2(i) = sum(abs(errors));
    
    performance = perform(net2,testTargets,outputs1);

    i = i + 1;

end

errores2 = sort(errores2);
err2 = errores2(1)
erroresTotales = erroresTotales + errores2(1);

%5-8

net3 = feedforwardnet([67]);

net3.divideFcn = 'dividerand';  % Divide data randomly
net3.divideMode = 'sample';  % Divide up every sample
net3.divideParam.trainRatio = 80/100;
net3.divideParam.valRatio = 20/100;
net3.divideParam.testRatio = 0/100;

net3.trainFcn = 'trainrp';  % Levenberg-Marquardt

net3.trainParam.goal = 0.08;
net3.trainParam.max_fail = 12;
net3.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net3.layers{2}.transferFcn = 'purelin';
net3.layers{1}.transferFcn = 'tansig';
net3.performFcn = 'mse';  % Mean squared error

net3.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net3.trainParam.showWindow = 0;
net3 = init(net3);

inputs = [entrada(:,1:4) entrada(:,9:40)];
targets = [objetivo(1:4,:)' objetivo(9:40,:)'];

testInputs = entrada(:,5:8);
testTargets = objetivo(5:8,:)';


i = 1;

errores3 = ones(10,1) * 10;

while i <= 10
    
    net3 = init(net3);
    % Train the Network
    [net3,tr] = train(net3,inputs,targets);



    % Test the Network
    %outputs1 = net3(testInputs)
    outputs1 = sim(net3, testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores3(i) = sum(abs(errors));

    performance = perform(net1,testTargets,outputs1);

    i = i + 1;

end


errores3 = sort(errores3);
err3 = errores3(1)
erroresTotales = erroresTotales + errores3(1);

%9-12

net4 = feedforwardnet([67]);

net4.divideFcn = 'dividerand';  % Divide data randomly
net4.divideMode = 'sample';  % Divide up every sample
net4.divideParam.trainRatio = 80/100;
net4.divideParam.valRatio = 20/100;
net4.divideParam.testRatio = 0/100;

net4.trainFcn = 'trainrp';  % Levenberg-Marquardt

net4.trainParam.goal = 0.1;
net4.trainParam.max_fail = 18;
net4.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net4.layers{2}.transferFcn = 'purelin';
net4.layers{1}.transferFcn = 'tansig';
net4.performFcn = 'mse';  % Mean squared error

net4.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net4.trainParam.showWindow = 0;
net4 = init(net4);

inputs = [entrada(:,1:8) entrada(:,12:40)];
targets = [objetivo(1:8,:)' objetivo(12:40,:)'];
testInputs = entrada(:,9:12);
testTargets = objetivo(9:12,:)';

i = 1;

errores4 = ones(10,1) * 10;

while i <= 10

    net4 = init(net4);
    % Train the Network
    [net4,tr] = train(net4,inputs,targets);
    
    % Test the Network
    outputs1 = net4(testInputs);
    %outputs1 = sim(net4, testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores4(i) = sum(abs(errors));

    performance = perform(net1,testTargets,outputs1);

    i = i + 1;

end

errores4 = sort(errores4);
err4 = errores4(1)
erroresTotales = erroresTotales + errores4(1);

%13-16

net5 = feedforwardnet([67]);

net5.divideFcn = 'dividerand';  % Divide data randomly
net5.divideMode = 'sample';  % Divide up every sample
net5.divideParam.trainRatio = 80/100;
net5.divideParam.valRatio = 20/100;
net5.divideParam.testRatio = 0/100;

net5.trainFcn = 'trainrp';  % Levenberg-Marquardt

net5.trainParam.goal = 0.08;
net5.trainParam.max_fail = 12;
net5.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net5.layers{2}.transferFcn = 'purelin';
net5.layers{1}.transferFcn = 'tansig';
net5.performFcn = 'mse';  % Mean squared error

net5.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net5.trainParam.showWindow = 0;

net5 = init(net5);

inputs = [entrada(:,1:12) entrada(:,17:40)];
targets = [objetivo(1:12,:)' objetivo(17:40,:)'];
testInputs = entrada(:,13:16);
testTargets = objetivo(13:16,:)';

i = 1;

errores5 = ones(10,1) * 10;

while i <= 10

    net5 = init(net5);

    % Train the Network
    [net5,tr] = train(net5,inputs,targets);

    % Test the Network
    outputs1 = net5(testInputs);
    %outputs1 = sim(net5, testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores5(i) = sum(abs(errors));

    performance = perform(net1,testTargets,outputs1);
    
    i = i + 1;

end


errores5 = sort(errores5);
err5 = errores5(1)
erroresTotales = erroresTotales + errores5(1);

%17-20




net6 = feedforwardnet([67]);

net6.divideFcn = 'dividerand';  % Divide data randomly
net6.divideMode = 'sample';  % Divide up every sample
net6.divideParam.trainRatio = 80/100;
net6.divideParam.valRatio = 20/100;
net6.divideParam.testRatio = 0/100;

net6.trainFcn = 'trainrp';  % Levenberg-Marquardt

net6.trainParam.goal = 0.08;
net6.trainParam.max_fail = 18;
net6.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net6.layers{2}.transferFcn = 'tansig';
net6.layers{1}.transferFcn = 'tansig';
net6.performFcn = 'mse';  % Mean squared error

net6.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net6.trainParam.showWindow = 0;
net6 = init(net6);

inputs = [entrada(:,1:16) entrada(:,21:40)];
targets = [objetivo(1:16,:)' objetivo(21:40,:)'];

testInputs = entrada(:,17:20);
testTargets = objetivo(17:20,:)';

i = 1;

errores6 = ones(10,1) * 10;

while i <= 10

    net6 = init(net6);

    % Train the Network
    [net6,tr] = train(net6,inputs,targets);


    % Test the Network
    outputs = net6(testInputs);
    %outputs1 = sim(net6, testInputs);
    outputsAux = ceil(outputs1);
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores6(i) = sum(abs(errors));
    
    performance = perform(net1,testTargets,outputs1);
    
    i = i + 1;
    
end

errores6 = sort(errores6);
err6 = errores6(1)
erroresTotales = erroresTotales + errores6(1);

%21-24

net7 = feedforwardnet([67]);

net7.divideFcn = 'dividerand';  % Divide data randomly
net7.divideMode = 'sample';  % Divide up every sample
net7.divideParam.trainRatio = 80/100;
net7.divideParam.valRatio = 20/100;
net7.divideParam.testRatio = 0/100;

net7.trainFcn = 'trainrp';  % Levenberg-Marquardt

net7.trainParam.goal = 0.08;
net7.trainParam.max_fail = 18;
net7.trainParam.epochs = 300;
%ne7.efficiency.memoryReduction  = 2;
net7.layers{2}.transferFcn = 'tansig';
net7.layers{1}.transferFcn = 'tansig';
net7.performFcn = 'mse';  % Mean squared error

net7.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net7.trainParam.showWindow = 0;

net7 = init(net7);

inputs = [entrada(:,1:20) entrada(:,25:40)];
targets = [objetivo(1:20,:)' objetivo(25:40,:)'];
% Train the Network
[net7,tr] = train(net7,inputs,targets);

testInputs = entrada(:,21:24);
testTargets = objetivo(21:24,:)';

i = 1;

errores7 = ones(10,1) * 10;

while i <= 10

    net7 = init(net7);

    % Test the Network
    outputs1 = net7(testInputs);
    %outputs1 = sim(net7, testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores7(i) = sum(abs(errors));
    
    performance = perform(net1,testTargets,outputs1);

    i = i + 1;

end

errores7 = sort(errores7);
err7 = errores7(1)
erroresTotales = erroresTotales + errores7(1);

%25-28

net8 = feedforwardnet([67]);

net8.divideFcn = 'dividerand';  % Divide data randomly
net8.divideMode = 'sample';  % Divide up every sample
net8.divideParam.trainRatio = 80/100;
net8.divideParam.valRatio = 20/100;
net8.divideParam.testRatio = 0/100;

net8.trainFcn = 'trainrp';  % Levenberg-Marquardt

net8.trainParam.goal = 0.1;
net8.trainParam.max_fail = 12;
net8.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net8.layers{2}.transferFcn = 'purelin';
net8.layers{1}.transferFcn = 'tansig';
net8.performFcn = 'mse';  % Mean squared error

net8.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net8.trainParam.showWindow = 0;

net8 = init(net8);

inputs = [entrada(:,1:24) entrada(:,29:40)];
targets = [objetivo(1:24,:)' objetivo(29:40,:)'];

testInputs = entrada(:,25:28);
testTargets = objetivo(25:28,:)';

i = 1;

errores8 = ones(10,1) * 10;

while i <= 10

    net8 = init(net8);
    % Train the Network
    [net8,tr] = train(net8,inputs,targets);


    % Test the Network
    outputs1 = net8(testInputs);
    %outputs1 = sim(net8, testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores8(i) = sum(abs(errors));

    performance = perform(net1,testTargets,outputs1);

    i = i + 1;

end


errores8 = sort(errores8);
err8 = errores8(1)
erroresTotales = erroresTotales + errores8(1);


%29-32

net9 = feedforwardnet([67]);

net9.divideFcn = 'dividerand';  % Divide data randomly
net9.divideMode = 'sample';  % Divide up every sample
net9.divideParam.trainRatio = 80/100;
net9.divideParam.valRatio = 20/100;
net9.divideParam.testRatio = 0/100;

net9.trainFcn = 'trainrp';  % Levenberg-Marquardt

net9.trainParam.goal = 0.08;
net9.trainParam.max_fail = 18;
net9.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net9.layers{2}.transferFcn = 'purelin';
net9.layers{1}.transferFcn = 'tansig';

net9.performFcn = 'mse';  % Mean squared error

net9.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net9.trainParam.showWindow = 0;

net9 = init(net9);

inputs = [entrada(:,1:28) entrada(:,33:40)];
targets = [objetivo(1:28,:)' objetivo(33:40,:)'];

testInputs = entrada(:,29:32);
testTargets = objetivo(29:32,:)';

i = 1;

errores9 = ones(10,1) * 10;

while i <= 10

    net9 = init(net9);
    % Train the Network
    [net9,tr] = train(net9,inputs,targets);




    % Test the Network
    %outputs = net(testInputs)
    %outputs1 = sim(net9, testInputs);
    outputs1 = net9(testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores9(i) = sum(abs(errors));

    performance = perform(net1,testTargets,outputs1);
    
    i = i + 1;
    
end

errores9 = sort(errores9);
err9 = errores9(1)
erroresTotales = erroresTotales + errores9(1);

%33-36


net10 = feedforwardnet([67]);

%net10 = init(net10);

net10.divideFcn = 'dividerand';  % Divide data randomly
net10.divideMode = 'sample';  % Divide up every sample
net10.divideParam.trainRatio = 80/100;
net10.divideParam.valRatio = 20/100;
net10.divideParam.testRatio = 0/100;

net10.trainFcn = 'trainrp';  % Levenberg-Marquardt

net10.trainParam.goal = 0.01;
net10.trainParam.max_fail = 12;
net10.trainParam.epochs = 300;
%net.efficiency.memoryReduction  = 2;
net10.layers{2}.transferFcn = 'purelin';
net10.layers{1}.transferFcn = 'tansig';
net10.performFcn = 'mse';  % Mean squared error

net10.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};
net10.trainParam.showWindow = 0;

inputs = [entrada(:,1:32) entrada(:,37:40)];
targets = [objetivo(1:32,:)' objetivo(37:40,:)'];

testInputs = entrada(:,33:36);
testTargets = objetivo(33:36,:)';

i = 1;

errores10 = ones(10,1) * 10;

while i <= 10
    
    net10 = init(net10);
    
    % Train the Network
    [net10,tr] = train(net10,inputs,targets);



    % Test the Network
    %outputs = net(testInputs)
    %outputs1 = sim(net10, testInputs);
    outputs1 = net10(testInputs);
    outputsAux = outputs1;
    outputsAux(outputsAux >= 0.5) = 1;
    outputsAux(outputsAux<0.5)= 0;
    errors = gsubtract(testTargets,outputsAux);
    errores10(i) = sum(abs(errors));

    performance = perform(net1,testTargets,outputs1);
    
    i = i + 1;

end

errores10 = sort(errores10);
err10 = errores10(1)
erroresTotales = erroresTotales + errores10(1);

porcentajeAcierto = (40 - erroresTotales)*10/4