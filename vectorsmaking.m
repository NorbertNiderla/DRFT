close all
clear all

waypoints = [0 0 0;
    6 -5.1 0;
    8.8 -5.6 0;
    11.8 -5.7 0;
    15.7 -3.3 0;
    17.4 -0.4 0;
    19.6 4 0;
    21.3 4.2 0;
    24.8 4.9 0;
    28.6 3.1 0;
    28.9 -1.3 0;
    32.5 -4.3 0;
    34.1 -6.7 0;
    34.8 -11.6 0;
    39.4 -10.2 0;    42.3 -2.5 0;
    39.3 4.6 0;
    37.2 10.1 0;
    27.9 12.8 0;
    18.1 13.7 0;
    8.8 14.5 0];

waypoints = waypoints(:,1:2);
functionValue = 3;
pathVectorLength = 0.1;
size = size(waypoints, 1);
reszta = mod(size-1, functionValue);

for i = 0:((size - reszta)/functionValue - 1)
    x = transpose(waypoints(functionValue*i+1 : functionValue*(i+1)+1 , 1));
    y = transpose(waypoints(functionValue*i+1 : functionValue*(i+1)+1 , 2));
    p = polyfit(x,y,functionValue);
    
    xPlot = linspace(x(1),x(functionValue+1),round((((x(functionValue+1)-x(1))^2+(y(functionValue+1)-y(1))^2)^0.5)/pathVectorLength));
    val = polyval(p,xPlot);
    curveLength = arclength(xPlot, val);
    
    points = interparc(round(curveLength/pathVectorLength), xPlot, val);
    plot(points(:,1),points(:,2),'.')
    hold on
end


angle = [];
for i = 1:(size(points, 1)-1)
   angle = [angle arctan((points(i+1,2)-points(i,2))/(points(i+1,1)-points(i,1)))];
    

end



