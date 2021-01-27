function [prom_X,prom_Y]=promSizeLetter(boundingbox)
% Función que devuelve el tamaño medio de cada letra de un texto pasado
% de entrada (imagen de una palabra, una línea, etc.)
% Entrada :
% boundingbox: matriz (regionProps) de cuadros delimitadores para cada letra
%
% Salida :
% prom_x: tamaño medio de las letras que siguen a x
% promy: tamaño medio de las letras que siguen a x

[x, xses] = size(boundingbox);

for i=1:xses
    sizeBounding = cell2mat(boundingbox(i));
    %https://www.mathworks.com/help/matlab/ref/cell2mat.html convierte un
    %array de arrays enn un array normal //matriz
    x_size(i) = sizeBounding(3);
    y_size(i) = sizeBounding(4);
end
prom_X = mean(x_size); %prom de x_size que es los valoes en x de bounding box
prom_Y = mean(y_size);  %prom de y_size que es los valoes en x de bounding box