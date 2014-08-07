clc;
clear all;

poblacion = dlmread('resultado.txt');
objetivo = dlmread('SalidaP4.txt')';

inputs = poblacion(:,2:41)';



x = simplecluster_dataset;
net = selforgmap([6 6]); %vecindad de tamaño (a X b), en este caso 6x6 = 36 clases posibles
net.trainParam.epochs = 450;

net.plotFcns = {'plotsomtop','plotsomnc','plotsomnd', ...
  'plotsomplanes', 'plotsomhits', 'plotsompos'};
net = train(net,inputs);
view(net)
y = net(inputs);
classes = vec2ind(y)


%plotsompos(net,inputs);
clases = zeros(625,2) - 1;
clases(:,1) = (1:625);

i = 1;

while i <= 625
    
    num = find(classes == i);
    numero = size(num);
    clases(i,2) = numero(2);
    
   i = i + 1; 
    
end

num = find(clases(:,2) == 0);
numero = size(num);
resultado = 625 - numero(2);



clases;