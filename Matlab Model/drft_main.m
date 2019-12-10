%  ______ _____ ____  ______ _____    _______ ______          __  __ 
% |  ____|_   _|  _ \|  ____|  __ \  |__   __|  ____|   /\   |  \/  |
% | |__    | | | |_) | |__  | |__) |    | |  | |__     /  \  | \  / |
% |  __|   | | |  _ <|  __| |  _  /     | |  |  __|   / /\ \ | |\/| |
% | |     _| |_| |_) | |____| | \ \     | |  | |____ / ____ \| |  | |
% |_|    |_____|____/|______|_|  \_\    |_|  |______/_/    \_\_|  |_|

close all
aMax=5.5; %Maximum acceleration
vMax=50; %Maximum velocity
v0=20; %Initial speed
carLenght = 4.433; %BMW E36 Rubble length
a = @(v, r) (v.^2)./r; %Tangential acceleration equation

%Calculation of model parameters
[angle, waypoints] = routeMaking;
N = length(waypoints);
radius = radiusCalc(waypoints);
frontVelocity = velocityCalc(angle, aMax, vMax, v0); 
attackAngle = attackAngleCalc(angle, frontVelocity, vMax);

%Parameters of cars back-end calculation
radiusBack = radius + (carLenght*abs(sin(attackAngle)));
backVelocity = frontVelocity.*(radiusBack./radius);

%Calculation of acceleration
aFrontMovement =  [diff(frontVelocity) 0].*exp(1i*(attackAngle));
aBackMovement =  [diff(backVelocity) 0].*exp(1i*(attackAngle));
aFront = a(frontVelocity, radius).*exp(1i*(attackAngle+0.5*pi));
aBack = a(backVelocity, radiusBack).*exp(1i*(attackAngle+0.5*pi));

aFrontAll = aFront + aFrontMovement;
aBackAll = aBack + aFrontMovement;

t = [0];
for x = 2:length(waypoints)
    t(x) = t(x-1) + norm(waypoints(x,:) - waypoints(x-1,:))/frontVelocity(x);  
end

drift = [];
driftRatio = 1.00001;
for i = 1:length(ratio)
    if ratio(i) < driftRatio
        drift(i) = 0;
    else
        drift(i) = 1;
    end
end

dane_dla_ernesta = transpose([t; real(aBackAll); imag(aBackAll); real(aFrontAll); imag(aFrontAll); drift]);
ratio = [0 abs(aBack(2:N-1))./abs(aFront(2:N-1)) 0];        
ratioAll = [0 abs(aBackAll(2:N-1))./abs(aFrontAll(2:N-1)) 0];

figure(1)
plot(1:N,ratio,1:N,[0 diff(angle)]+1, 1:N, attackAngle+1)
legend('Ratio', 'Drive Angle', 'Attack Angle')
figure(2)
plot(1:N, ratio*1e3 ,1:N, radius, 1:N, radiusBack)
legend('Ratio * 1000', 'Front Radius', 'Back Radius')
axis([1 N 0 1e4])
figure(3)
plot(1:N, ratio*30,1:N, frontVelocity,1:N, backVelocity)
legend('Ratio * 30', 'Front Velocity', 'Back Velocity')