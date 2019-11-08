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

global carLenght turnRadius size turnRadiusBack angleMatrix;
carLenght = 4;
turnRadius = linspace(1,10,100);
size = 100;

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