%  ______ _____ ____  ______ _____    _______ ______          __  __ 
% |  ____|_   _|  _ \|  ____|  __ \  |__   __|  ____|   /\   |  \/  |
% | |__    | | | |_) | |__  | |__) |    | |  | |__     /  \  | \  / |
% |  __|   | | |  _ <|  __| |  _  /     | |  |  __|   / /\ \ | |\/| |
% | |     _| |_| |_) | |____| | \ \     | |  | |____ / ____ \| |  | |
% |_|    |_____|____/|______|_|  \_\    |_|  |______/_/    \_\_|  |_|
%function is used to calculate the radius of each curve along route
function result = radiusCalc(waypoints)
    k=length(waypoints);
    x=waypoints(:,1);
    y=waypoints(:,2);
    R = zeros(1, k);
    for n = 2:k-1
        %interpolation with circle function
        a1n=-(x(n-1)-x(n))*(y(n-1)-y(n));
        b1n=y(n-1)-x(n-1)*a1n;
        a2n=-(y(n)-y(n+1))*(x(n)-x(n+1));
        b2n=y(n+1)-x(n+1)*a2n;
        xr = (b1n-b2n)/(a2n-a1n);
        yr = a2n*xr+b2n;
        R(n)=sqrt((x(n)-xr)^2+(y(n)-yr)^2);
    end
    result = R;
end