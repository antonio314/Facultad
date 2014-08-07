
entrada1 = dlmread('entradaProcesada.txt');
targets = dlmread('SalidaP3.txt');

entrada = zeros(4026*3,40);

i = 1;
h = 1;

while i < 4027
    
    j = 2;
    
   while j < 42
       
       if entrada1(i,j) < 0
           
          entrada(h,j-1) = 1; 
           
       else
           
          entrada(h,j-1) = 0; 
           
       end
       
       if abs(entrada1(i,j)) <= 0.5
           
            entrada(h+1,j-1) = 0;
            entrada(h+2,j-1) = 0;
            
       else
           if abs(entrada1(i,j)) <= 2
               
                entrada(h+1,j-1) = 0;
                entrada(h+2,j-1) = 1;
                
           else
                entrada(h+1,j-1) = 1;
                entrada(h+2,j-1) = 1;
               
           end
           
           
       end
       
       j = j + 1;
       
   end
   
   h = h + 3;
       
   i = i + 1;
    
end

net = feedforwardnet([100]);

net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;

net.trainFcn = 'trainlm';  % Levenberg-Marquardt

net.performFcn = 'mse';  % Mean squared error

net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

inputs = entrada(:,1:30);
% Train the Network
[net,tr] = train(net,entrada,targets');