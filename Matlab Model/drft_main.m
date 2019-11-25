clear all
close all

global aMax vMax v0
aMax=5.5;
vMax=50;
v0=20;

a = @(v, r) (v.^2)./r;

carLenght = 4;
[angle, waypoints] = routeMaking;
N = length(waypoints);

radius = radiusCalc(waypoints);
frontVelocity = velocityCalc(angle, radius); 
attackAngle = attackAngleCalc(angle, frontVelocity);

radiusBack = radius + (carLenght*abs(sin(attackAngle)));

backVelocity = frontVelocity.*(radiusBack./radius);

aFrontMovement =  [diff(frontVelocity) 0].*exp(1i*(attackAngle));
aBackMovement =  [diff(backVelocity) 0].*exp(1i*(attackAngle));
aFront = a(frontVelocity, radius).*exp(1i*(attackAngle+0.5*pi));
aBack = a(backVelocity, radiusBack).*exp(1i*(attackAngle+0.5*pi));

aFrontAll = aFront + aFrontMovement;
aBackAll = aBack + aFrontMovement;

ratio = [0 abs(aBack(2:N-1))./abs(aFront(2:N-1)) 0];        
ratioAll = [0 abs(aBackAll(2:N-1))./abs(aFrontAll(2:N-1)) 0];
figure(1)
plot(1:N,ratio,1:N,[0 diff(angle)]+1, 1:N, attackAngle+1)
legend('ratio', 'angle', 'attack')
figure(2)
plot(1:N, ratio*1e3 ,1:N, radius, 1:N, radiusBack)
legend('ratio', 'radius', 'radius back')
axis([1 N 0 1e4])
figure(3)
plot(1:N, ratio*30,1:N, frontVelocity,1:N, backVelocity)
legend('ratio', 'velocity', 'velocity back')