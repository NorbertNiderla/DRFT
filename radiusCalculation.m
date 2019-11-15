function [R] = radiusCalculation(x,y)

    k=size(x,2);%wektor x jest poziomy
 
    for n = 3:k
    b2=(y(n)*x(n-1)-y(n-1)*x(n))/(x(n)+x(n-1));
    a2=(y(n-1)-b2)/x(n-1);
    a2n=-1/a2;
    b2n=y(n)-x(n)*a2n;
    
    b1=(y(n-1)*x(n-2)-y(n-2)*x(n-1))/(x(n-1)+x(n-2));
    a1=(y(n-2)-b1)/x(n-2);
    a1n=-1/a1;
    b1n=y(n-2)-x(n-2)*a1n;
    
    xr = (b1n-b2n)/(a2n-a1n);
    yr = xr*a2n+b2n;
    R(n-2)=sqrt((xr-x(n))^2+(yr-y(n))^2)
    end
    
end