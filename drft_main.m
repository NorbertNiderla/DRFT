% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Bloki funkcjonalne (elementy projektu):
% 1. konwersja mapy z Automated Driving Toolbox na zbior wektorow
%             a) w najlepszym wypadku wystarczy zbior argumentow tych wektorow, 
%                 jesli uzywany bedzie wektor znormalizowany
% 2. konwersja zbioru wektorow sciezki na macierz promieni lukow po ktorych porusza sie pojazd
% 3. konwersja zbioru wektorow sciezki na macierz katow natarcia pojazdu
% 4. funkcja tworzaca macierz predkosci pojazdu na podstawie punktoww 2 i 3 oraz jakiegos wspolczynnika przyspieszenia
% 5. blok liczacy material koncowy i koordynujacy reszte blokow na podstawie 
%                    punktow 2,3,4. ( wlasciwie to na ten moment to juz tu jest)
% 6 jakis frontend dla ambitnych ( wykres czy costam)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. blok wykrywajacy understeer w wynikach
% 8. blok wykrywajacy oversteer w wynikach
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global carLenght turnRadius size turnRadiusBack angleMatrix waypoints;
carLenght = 4;
turnRadius = linspace(1,10,100);
size = 100;

waypoints = [0 0;
    6 -5.1;
    8.8 -5.6;
    11.8 -5.7;
    15.7 -3.3;
    17.4 -0.4;
    19.6 4;
    21.3 4.2;
    24.8 4.9;
    28.6 3.1;
    28.9 -1.3;
    32.5 -4.3;
    34.1 -6.7;
    34.8 -11.6;
    39.4 -10.2;    42.3 -2.5;
    39.3 4.6;
    37.2 10.1;
    27.9 12.8;
    18.1 13.7;
    8.8 14.5];

radiusMatrix = radiusCalculation;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = @(v, r) (v.^2)./r;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

angleMatrix =ones(1, size)*(0.25*pi);
frontVelocityMatrix = ones(1, size)*16;
backVelocityMatrix = frontVelocityMatrix + frontVelocityMatrix.*(carLenght ./ turnRadius).*sin(angleMatrix);
turnRadiusBack = turnRadius + (carLenght*sin(angleMatrix));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aFront = a(frontVelocityMatrix, turnRadius);
aBack = a(backVelocityMatrix, turnRadiusBack);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xFront = aFront.*sin(-angleMatrix);
xBack = aBack.*sin(-angleMatrix);
yFront = aFront.*cos(angleMatrix);
yBack = aBack.*cos(angleMatrix);

%za�o�enia: jak leci lewym bokiem do przodu, czyli tak jakby skr�ca w prawo
%to k�t jest dodatni
%x = a*sin(-ang)
%y = a*cos(ang)
%rd = l*sin(ang)

aFront = (xFront.^2+yFront.^2).^0.5;
aBack = (xBack.^2+yBack.^2).^0.5;

ratio = aFront ./ aBack;