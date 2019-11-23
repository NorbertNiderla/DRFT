% % Bloki funkcjonalne (elementy projektu):
% 1. konwersja mapy z Automated Driving Toolbox na zbior wektorow
% 2. konwersja zbioru wektorow sciezki na macierz promieni lukow po ktorych porusza sie pojazd
% 3. konwersja zbioru wektorow sciezki na macierz katow natarcia pojazdu
% 4. funkcja tworzaca macierz predkosci pojazdu na podstawie punktoww 2 i 3 oraz jakiegos wspolczynnika przyspieszenia
% 5. blok liczacy material koncowy i koordynujacy reszte blokow na podstawie punktow 2,3,4.
% 6. wykresy 

% 7. blok wykrywajacy understeer w wynikach
% 8. blok wykrywajacy oversteer w wynikach

clear all
close all

%equations
a = @(v, r) (v.^2)./r;

%basic parameters
carLenght = 4;
[angleMatrix, angleDiffMatrix, waypoints] = routeMaking;
size = length(waypoints);

%front and backend radius
radiusMatrix = radiusCalc;
radiusMatrixBack = radiusMatrix + (carLenght*sin(angleMatrix));

%tu wchodzi liczenie macierzy w funkcjach wlasnie pisanych
%frontVelocityMatrix = velocityMatrixCalc(angleMatrix, angleDiffMatrix); 
%attackAngleMatrix = attackAngleMatrixCalc(frontVelocityMatrix, angleMatrix, angleDiffMatrix);

%backend velocity
backVelocityMatrix = frontVelocityMatrix + frontVelocityMatrix.*(carLenght ./ radiusMatrix).*sin(angleMatrix);

%acceleration on front and back
aFront = a(frontVelocityMatrix, radiusMatrix);
aBack = a(backVelocityMatrix, radiusMatrixBack);

%acceleration along x and y axes
axFront = aFront.*sin(-angleMatrix);
axBack = aBack.*sin(-angleMatrix);
ayFront = aFront.*cos(angleMatrix);
ayBack = aBack.*cos(angleMatrix);

%zalozenia: jak leci lewym bokiem do przodu, czyli tak jakby skreca w prawo
%to ktory jest dodatni
%x = a*sin(-ang)
%y = a*cos(ang)
%rd = l*sin(ang)

%front and back end complex acceleration
aFront = (axFront.^2+ayFront.^2).^0.5;
aBack = (axBack.^2+ayBack.^2).^0.5;

%acceleration ratio
ratio = aFront ./ aBack;