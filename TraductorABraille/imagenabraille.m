%la funcion que hace la magia, devuelve 2 args traduccion e imagen
%acepta 2 args ima normal y wait

function [imgBraille,recognizetext]=imagenabraille(imaNormal,wait)


espace = double((imread('./alphabet_braille/braille_espace.png')))/255;

%not im 2 bw 
imgBinarize = ~im2bw(imaNormal);


%usamos regionprops - 'boundingbox'
% region props funciona en imagenes binarizadas - boundingbox Posición y tamaño del cuadro más pequeño que contiene la región, 
%devuelto como un vector 1 por (2 * Q). Los primeros elementos Q son las coordenadas de la esquina mínima de la caja. 

%%fuente https://www.mathworks.com/help/images/ref/regionprops.html#bqkf8hf



boundingboxStruct=regionprops(imgBinarize,'BoundingBox');
%boundingboxStruct tiene la info del cuadro que contiene la imagen

bouningBoxDLetra = struct2cell(boundingboxStruct);
%struct2cell convierte una estructura en un array 

[x longLetra] = size(bouningBoxDLetra);
%devuelve lo mismo pero como array


contadorLetra = 0;

ImagenReconst=[];
word=[ ];
linea=imgBinarize;
filecontent=[];

contaLinea=1;
% mientras haya lineas a procesar

while 1
    %llama a la funcion delineado con arg linea
    [imgLinea, linea]=delineado(linea);
    
    %recuperación de los rectángulos que contienen los ROI
    
     % Cada rectángulo corresponde a una letra dentro de una linea
     % (imgLinea)
    boundingboxStruct=regionprops(imgLinea,'BoundingBox');
    boundingBoxPalabra = struct2cell(boundingboxStruct);
    rgCentroid=regionprops(imgLinea,'Centroid');    %Saca el centroide de una region con Regionprops
    
    [x y] = size(boundingBoxPalabra);
    
    [promX_size, promY_size]=promSizeLettre(boundingBoxPalabra); %llama a promSizeLettre da la salida promedio de las letras de unapalabra
    [promX_cen,promY_cen]=promPositionCentre(rgCentroid); %llama a promCentr da la salida prom de cada centroide de cada imagen vista
    
    
    palabras= cortePalabra(imgLinea,promY_size); %llama a cortePalabra entra el centroide de las letras de una palabra y su tamañoprom
    
    
    for index_palabra=1:length(palabras) %por cada letra
        boundingboxStruct=regionprops(palabras{index_palabra},'BoundingBox'); %sacamos regionprops
        boundingboxLetter = struct2cell(boundingboxStruct);  %cmbiamos la estructura a una celda (array de arrays)
        
        [x ypalabra] = size(boundingboxLetter); %recuperamos el tamaño de ese regionprops
        
     

%             % Para cada ROI buscamos la letra correspondiente
             for i=1:ypalabra %por cada letra
                 
                 
                cropLetra = imcrop(palabras{index_palabra},cell2mat(boundingboxLetter(i)));%aplica imcrop de la letra i aplicando medidas de Boundingbox
%                 %comvierte celda en matriz
                [letra, braille, numLetra]= readLetter(cropLetra,rgCentroid(i),promX_cen,promY_cen);%llama a ReadLetter
%                 %regresa index, la letra braille y la letra recortada
                
                ImagenReconst=[ImagenReconst braille]; 
                word = [word convertLetter(numLetra)]; %para obtener el texto se recupera el num de indice y se trae el string equivalente
                %se llama convertLetter 
                contadorLetra = contadorLetra +1;
                waitbar(contadorLetra/longLetra,wait,'Traduccion en curso')
                
            
        end
        %cuando acaba una palabraa mete espacio
        ImagenReconst=[ImagenReconst espace];
        word = [word ' '];
        
    end
    
    reconstruirLinea{contaLinea}=ImagenReconst;
    ImagenReconst=[];
    
    filecontent{contaLinea} = (word); %agregas la palabra en el array file content como un index
    %se limpia la var word
    word=[ ];
    % Cuando las oraciones terminan, rompe el ciclo
    if isempty(linea)  %si linea es 0 rompes
        break
    end
    contaLinea=contaLinea+1;
end
close(wait); %cierra waitbar
imgBraille=reconstructBraille(reconstruirLinea); %llamas reconstructImg

recognizetext = filecontent;
