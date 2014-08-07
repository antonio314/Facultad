mejoresGenes = dlmread('mejoresGenes.txt');

mejoresGenes = sort(mejoresGenes);

entrada1 = dlmread('entradaProcesada.txt');

genes = zeros(34,2);
genes(:,1) = mejoresGenes;

k = 1;

while k <= 34
    
    genes(k,2) = entrada1(mejoresGenes(k),1);
    
    k = k + 1;
    
end

k = k - 1;

dlmwrite('datosMejoresGenes.txt', genes);
    