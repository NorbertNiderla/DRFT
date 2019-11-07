% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Bloki funkcjonalne (elementy projektu):
% 1. konwersja mapy z Automated Driving Toolbox na zbiór wektorów
%             a) w najlepszym wypadku wystarczy zbiór argumentów tych wektorów, 
%                 jeœli u¿ywany bêdzie wektor znormalizowany
% 2. konwersja zbioru wektorów œcie¿ki na macierz promieni ³uków po których porusza siê pojazd
% 3. konwersja zbioru wektorów œcie¿ki na macierz k¹tów natarcia pojazdu
% 4. funkcja tworz¹cac macierz prêdkoœci pojazdu na podstawie punktów 2 i 3 oraz jakiegoœ wspó³czynnika przyœpieszenia
% 5. blok licz¹cy materia³ koñcowy i koordynuj¹cy resztê bloków na podstawie 
%                    punktów 2,3,4. ( w³aœciwie to na ten moment to ju¿ tu jest)
% 6 jakiœ frontend dla ambitnych ( wykres czy coœtam)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. blok wykrywaj¹cy understeer w wynikach
% 8. blok wykrywaj¹cy oversteer w wynikach
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

%za³o¿enia: jak leci lewym bokiem do przodu, czyli tak jakby skrêca w prawo
%to k¹t jest dodatni
%x = a*sin(-ang)
%y = a*cos(ang)
%rd = l*sin(ang)

aFront = (xFront.^2+yFront.^2).^0.5;
aBack = (xBack.^2+yBack.^2).^0.5;

ratio = aFront ./ aBack;