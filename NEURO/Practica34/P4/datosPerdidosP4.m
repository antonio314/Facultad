clc;
clear all;

poblacionEsc = dlmread('EntradaP4.txt');
poblacionEsc = knnimpute(poblacionEsc,'15');
dlmwrite('Datos_Microarrays_Cancer.txt', poblacionEsc);
