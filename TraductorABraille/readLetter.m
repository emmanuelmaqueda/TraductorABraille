function [letra, braille, numLetra]=readLetter(letraAConvertir,centre,promSizeX,promSizeY)
% Función que devuelve las imágenes de la letra en texto, formato braille
% así como su índice en el diccionario

% Entrada :
% letterAConvert: letra en formato binario y cortada en el borde (boundingBox)
% centro: posición media del centro de las letras (permitirá diferenciar, y ')
% promSizeX: tamaño medio de las letra x
% promsizey: tamaño medio de las letras que siguen a X
%
% Salida :
% letra: imagen de la letra del diccionario en formato de texto correspondiente a la letra de entrada
% braille: imagen de la letra del diccionario en formato braille correspondiente a la letra de entrada
% letterNum: índice de la posición de la letra en el diccionario correspondiente a la letra de entrada

val_correlation = 0;
index_letra = 0;

letraarray=[]; 
braillearray=[];
index_letra=0;




for n=1:33  % para todas las letras 
    
    modeloletra = double((imread(sprintf('./alphabet/alphabet_%d.png',n))))/255; %con indice n para por todos los indices
    modeloletraBW = ~im2bw(modeloletra); %binariza
    
    
        boundingboxStruct=regionprops(modeloletraBW,'BoundingBox'); %bouningbox de cada letra
        boundingboxLetter = struct2cell(boundingboxStruct); %cambia de structura a celda
        
        modelletraCrop = imcrop(modeloletraBW,cell2mat(boundingboxLetter(1))); % imcrop de la binarizada, convierte de celda a array y eso corta  

    
    tamano = size(letraAConvertir); 
    
    cof_correlation = corr2(imresize(modelletraCrop,tamano),letraAConvertir);%https://www.mathworks.com/help/matlab/ref/struct2cell.html
    %resize del tamaño original de la letra al imcrop / corr2 da un
    %coeficiente de correlacion entre 2 arrays letra a convertir y el
    %imcrop
    if (val_correlation<cof_correlation)
        index_letra=n; %se recupera el indice
        val_correlation=cof_correlation;
        letraarray=imresize(modelletraCrop,tamano); %resize del imcrop al tamaño original y almacena en la lista vacia
        braillearray=double((imread(sprintf('./alphabet_braille/braille_%d.png',n))))/255; % asigna al array la imagen del equivalente braille  del indice de la imagen del crop
    end
    
    
    
   % Si el centro de la letra se coloca por encima o por debajo de la media
     % Probablemente uno de los siguientes caracteres ' , o .
     % Si es una coma o un apóstrofo
    if (index_letra == 28 || index_letra == 29)
        
        if (centre.Centroid(1)<0.7*promSizeY) %0.7 del promedio
            index_letra=28;
        else
            index_letra=29;
        end
    end
    
    switch index_letra
        case 27 % el .
            if (centre.Centroid(1)>0.3*promSizeY) % si 0.3 del promedio es 1 
                index_letra=9;
            end
        otherwise
            index_letra=index_letra; % deotro modo es .
    end
end



numLetra = index_letra; %indice de la letra
letra = letraarray; % letra iden
braille = braillearray; %brailee identificada