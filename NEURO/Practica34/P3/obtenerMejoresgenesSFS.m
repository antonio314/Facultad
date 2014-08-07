entrada1 = dlmread('entradaProcesada.txt');
entrada = entrada1(:,2:41)';
objetivo = dlmread('SalidaP3.txt');


maxdev = chi2inv(.90,1); 

opt = statset('display','iter','TolFun',maxdev,'TolTypeFun','abs');

inmodel = sequentialfs(@funcioncriterio,entrada,objetivo,'cv','none','nullmodel',true,'options',opt,'direction','forward');


%obtengo las columnas de inmodel para guardarlas en un archivo
cont = 1;
genesSFS = zeros(4,1);

for aux=1:4026
    if inmodel(aux) > 0
        genesSFS(cont) = aux;
        cont = cont +1;
    end
end

dlmwrite('mejoresGenesSFS.txt', genesSFS);

