% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Bloki funkcjonalne (elementy projektu):
% 1. konwersja mapy z Automated Driving Toolbox na zbi�r wektor�w
%             a) w najlepszym wypadku wystarczy zbi�r argument�w tych wektor�w, 
%                 je�li u�ywany b�dzie wektor znormalizowany
% 2. konwersja zbioru wektor�w �cie�ki na macierz promieni �uk�w po kt�rych porusza si� pojazd
% 3. konwersja zbioru wektor�w �cie�ki na macierz k�t�w natarcia pojazdu
% 4. funkcja tworz�cac macierz pr�dko�ci pojazdu na podstawie punkt�w 2 i 3 oraz jakiego� wsp�czynnika przy�pieszenia
% 5. blok licz�cy materia� ko�cowy i koordynuj�cy reszt� blok�w na podstawie 
%                    punkt�w 2,3,4. ( w�a�ciwie to na ten moment to ju� tu jest)
% 6 jaki� frontend dla ambitnych ( wykres czy co�tam)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. blok wykrywaj�cy understeer w wynikach
% 8. blok wykrywaj�cy oversteer w wynikach
% dupa
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