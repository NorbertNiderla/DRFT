function result = radiusCalculation(waypoints)

<<<<<<< Updated upstream
    
    k=length(waypoints);%wektor x jest poziomy
    x=waypoints(:,1);
    y=waypoints(:,2);
    R = zeros(1, k);
    for n = 2:k-1
        b2=(y(n+1)*x(n)-y(n)*x(n+1))/(x(n+1)+x(n));
        a2=(y(n)-b2)/x(n);
        a2n=-1/a2;
        b2n=y(n+1)-x(n+1)*a2n;

        b1=(y(n)*x(n-1)-y(n-1)*x(n))/(x(n)+x(n-1));
        a1=(y(n-1)-b1)/x(n-1);
        a1n=-1/a1;
        b1n=y(n-1)-x(n-1)*a1n;

        xr = (b1n-b2n)/(a2n-a1n);
        yr = xr*a2n+b2n;
        R(n)=sqrt((xr-x(n+1))^2+(yr-y(n+1))^2);
>>>>>>> Stashed changes
    end
    result = R;
end