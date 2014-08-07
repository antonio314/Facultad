%Procesar la entrada para sustituir los datos perdidos (con vecinos mas cercanos)

poblacionEsc = dlmread('EntradaP3.txt');
poblacionEsc = knnimpute(poblacionEsc,'15');
dlmwrite('entradaProcesada.txt', poblacionEsc);
