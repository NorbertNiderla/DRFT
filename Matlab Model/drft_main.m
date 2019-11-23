clear all
close all

global aMax vMax v0
aMax=5.5;
vMax=50;
v0=20;

a = @(v, r) (v.^2)./r;

carLenght = 4;
[angle, waypoints] = routeMaking;
size = length(waypoints);

radius = radiusCalc(waypoints);
radiusBack = radius + (carLenght*sin(angle));

frontVelocity = velocityMatrixCalc(angle); 
attackAngle = attackAngleCalc(angle, frontVelocity);

backVelocityMatrix = frontVelocity + frontVelocity.*(carLenght ./ radius).*sin(angle);

aFront = a(frontVelocity, radius).*exp(1i*(angle+0.25*pi));
aBack = a(backVelocityMatrix, radiusBack).*exp(1i*(angle+0.25*pi));

ratio = real(aFront ./ aBack);        

%plot(1:length(frontVelocityMatrix),frontVelocityMatrix,1:length(diff(angleMatrix)),diff(angleMatrix)*50,1:length(attackAngleMatrix),attackAngleMatrix*50)
%legend('velocity','angle')

