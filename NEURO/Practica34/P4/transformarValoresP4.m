
entrada = dlmread('Datos_Microarrays_Cancer.txt');

i = 1;
resultado = zeros(1000,41);
k = 1;

while i < 4027
    
    numPicos = 0;
    j  = 2;
    
    while j < 42
    
        if entrada(i,j) > 1 || entrada(i,j) < -1
            
           numPicos = numPicos + 1; 
            
        end
        
        j = j + 1;
    end
    
    if numPicos > 7
        
        resultado(k,:) = entrada(i,:);
        k = k+1;
        
    end
    
    i = i + 1;
    
end

valores = k - 1

dlmwrite('resultado.txt', resultado(1:k-1,:));
