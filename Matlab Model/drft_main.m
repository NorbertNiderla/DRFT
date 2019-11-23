clear all
close all

a = @(v, r) (v.^2)./r;

carLenght = 4;
[angleMatrix, waypoints] = routeMaking;
size = length(waypoints);

radiusMatrix = radiusCalc;
radiusMatrixBack = radiusMatrix + (carLenght*sin(angleMatrix));

frontVelocityMatrix = velocityMatrixCalc(angleMatrix); 
attackAngleMatrix = attackAngleMatrixCalc(angleMatrix, frontVelocityMatrix);

backVelocityMatrix = frontVelocityMatrix + frontVelocityMatrix.*(carLenght ./ radiusMatrix).*sin(angleMatrix);

aFront = a(frontVelocityMatrix, radiusMatrix).*exp(1i*(angleMatrix+0.25*pi));
aBack = a(backVelocityMatrix, radiusMatrix).*exp(1i*(angleMatrix+0.25*pi));

ratio = aFront ./ aBack;