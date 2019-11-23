clear all
close all

global aMax vMax v0
aMax=5.5;
vMax=50;
v0=20;

a = @(v, r) (v.^2)./r;

carLenght = 4;
[angleMatrix, waypoints] = routeMaking;
size = length(waypoints);

radiusMatrix = radiusCalc(waypoints);
radiusMatrixBack = radiusMatrix + (carLenght*sin(angleMatrix));

frontVelocityMatrix = velocityMatrixCalc(angleMatrix); 
attackAngleMatrix = attackAngleMatrixCalc(angleMatrix, frontVelocityMatrix);

backVelocityMatrix = frontVelocityMatrix + frontVelocityMatrix.*(carLenght ./ radiusMatrix).*sin(angleMatrix);

aFront = a(frontVelocityMatrix, radiusMatrix).*exp(1i*(angleMatrix+0.25*pi));
aBack = a(backVelocityMatrix, radiusMatrix).*exp(1i*(angleMatrix+0.25*pi));

ratio = aFront ./ aBack;


plot(1:length(frontVelocityMatrix),frontVelocityMatrix,1:length(diff(angleMatrix)),diff(angleMatrix)*50,1:length(attackAngleMatrix),attackAngleMatrix*50)
legend('velocity','angle','attack angle')
%,diff(angleMatrix),attackAngleMatrix,1:1.8)

