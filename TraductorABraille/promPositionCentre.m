function [prom_X,prom_Y]=promPositionCentre(rgCentroid)
% Función que devuelve la posición media de cada letra de un texto pasado
% de entrada (imagen de una palabra, una línea, etc.)
% Entrada :
% rgCentroid: matriz (regionProps) del centroide de cada letra
%
% Salida :
% prom_X: posición promedio de las letras después de x
% prom_y: posición media de las letras que siguen a x

for i=1:length(rgCentroid)
    x_centroid(i) = rgCentroid(i).Centroid(1);
    y_centroid(i) = rgCentroid(i).Centroid(2);
end

prom_X = mean(x_centroid);
prom_Y = mean(y_centroid);