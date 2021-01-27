function [line, lineRestatnte]=delineado(imgText)
% Función que devuelve cada línea de la imagen de un texto
% Entrada :
% imgText: imagen de un texto en forestPalabrasato binario
%
% Salida :
% line: primera línea desde arriba extraída de la imagen de entrada
% lineRestante: imagen del texto que contiene las líneas restantes



imgText=clip(imgText); 
%funcion clip (abajo)
num_filas=size(imgText,1);

for s = 1:num_filas
    if sum(imgText(s,:))==0
        primPalabra=imgText(1:s-1, :); 
        restPalabras=imgText(s:end, :);
        line = clip(primPalabra); %todos valores en x de la prim linea
        lineRestatnte=clip(restPalabras); %todos valores en y en la lineas restantes
        break
    else %Si solo es una linea.
        line=imgText;
        lineRestatnte=[];
    end
end

%esta funcion da los valores en x que tiene la imagen en filas y columnas
function img_out = clip(img_in)
[f c]=find(img_in); %funcion find regresa todos los indices de x de un array no vacio. f filas c columnas
%https://www.mathworks.com/help/matlab/ref/find.html
img_out=img_in(min(f):max(f),min(c):max(c));% img_out = a la imagen de entrada desde las filas de min a max y la col 