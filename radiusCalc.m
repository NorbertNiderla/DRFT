function result = radiusCalc(waypoints)

   k=length(waypoints);%wektor x jest poziomy
    x=waypoints(:,1);
    y=waypoints(:,2);
    R = zeros(1, k);
    for n = 2:k-1
        a1=(y(n-1)-y(n))/(x(n-1)-x(n));
        %b1=y(n)-a1*x(n);
        a1n=-1/a1;
        b1n=y(n-1)-x(n-1)*a1n;

        a2=(y(n)-y(n+1))/(x(n)-x(n+1));
        %b2=y(n+1)-a1*x(n+1);
        a2n=-1/a2;
        b2n=y(n+1)-x(n+1)*a2n;

        xr = (b1n-b2n)/(a2n-a1n);
        yr = a2n*xr+b2n;
        R(n)=sqrt((x(n)-xr)^2+(y(n)-yr)^2);
    end
    result = R;
end