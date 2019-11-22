% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Bloki funkcjonalne (elementy projektu):
% 1. konwersja mapy z Automated Driving Toolbox na zbior wektorow
% 2. konwersja zbioru wektorow sciezki na macierz promieni lukow po ktorych porusza sie pojazd
% 3. konwersja zbioru wektorow sciezki na macierz katow natarcia pojazdu
% 4. funkcja tworzaca macierz predkosci pojazdu na podstawie punktoww 2 i 3 oraz jakiegos wspolczynnika przyspieszenia
% 5. blok liczacy material koncowy i koordynujacy reszte blokow na podstawie punktow 2,3,4.
% 6. wykresy 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. blok wykrywajacy understeer w wynikach
% 8. blok wykrywajacy oversteer w wynikach
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

carLenght = 4;
[routeAngleMatrix, routeAngleDiffMatrix, waypoints] = routeMaking;
size = length(waypoints);
radiusMatrix = radiusCalculation;

%tu wchodzi funkcja na kat natarcia
%angleMatrix = costam;

%tu wchodzi funkcja na predkosc pojazdu
%frontVelocityMatrix = costam; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = @(v, r) (v.^2)./r;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

backVelocityMatrix = frontVelocityMatrix + frontVelocityMatrix.*(carLenght ./ radiusMatrix).*sin(angleMatrix);
radiusMatrixBack = radiusMatrix + (carLenght*sin(angleMatrix));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aFront = a(frontVelocityMatrix, radiusMatrix);
aBack = a(backVelocityMatrix, radiusMatrixBack);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xFront = aFront.*sin(-angleMatrix);
xBack = aBack.*sin(-angleMatrix);
yFront = aFront.*cos(angleMatrix);
yBack = aBack.*cos(angleMatrix);

%zalozenia: jak leci lewym bokiem do przodu, czyli tak jakby skreca w prawo
%to ktory jest dodatni
%x = a*sin(-ang)
%y = a*cos(ang)
%rd = l*sin(ang)

aFront = (xFront.^2+yFront.^2).^0.5;
aBack = (xBack.^2+yBack.^2).^0.5;

ratio = aFront ./ aBack;