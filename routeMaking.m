function [angle, angleDiff, waypoints] = routeMaking


%WAZNA ADNOTACJA, JAK ANGLEDIFF JEST UJEMNY TO TRASA SCKRECA W PRAWO, MOZNA
%TO LATWO ZMIENIC W MIEJSCU GDZIE ANGLEDIFF JEST LICZONY


waypoints = load('waypoints');
waypoints = waypoints.waypoints;

%limitAngle = 0.5233;  
%degreeOfPolynomial = 3;
pathVectorLength = 0.5; %gestosc "probkowania"
%size = length(waypoints);
%rest = mod(size-1, degreeOfPolynomial);

% for i = 0:((size - rest)/degreeOfPolynomial - 1)
%     x = transpose(waypoints(degreeOfPolynomial*i+1 : degreeOfPolynomial*(i+1)+1 , 1));
%     y = transpose(waypoints(degreeOfPolynomial*i+1 : degreeOfPolynomial*(i+1)+1 , 2));
%     p = polyfit(x,y,degreeOfPolynomial);
%     
%     xPlot = linspace(x(1),x(degreeOfPolynomial+1),round((((x(degreeOfPolynomial+1)-x(1))^2+(y(degreeOfPolynomial+1)-y(1))^2)^0.5)/pathVectorLength));
%     val = polyval(p,xPlot);
%     curveLength = arclength(xPlot, val);
%     
%     points = interparc(round(curveLength/pathVectorLength), xPlot, val);
%     points_all = [points_all; points];
% end

curveLength = arclength(waypoints(:,1), waypoints(:,2));
points_all = interparc(round(curveLength/pathVectorLength), waypoints(:,1), waypoints(:,2)); 

angle = [];
for j = 1:(length(points_all)-1)
   angle = [angle atan2((points_all(j+1,2)-points_all(j,2)), (points_all(j+1,1)-points_all(j,1)))];
end

angleDiff = angle - [0 angle(1:(length(angle)-1))];
waypoints = points_all;
% t = 1;
% while t <= length(angleDiff)
%     if abs(angleDiff(t)) > limitAngle
%         switch t
%             case t == 1
%                 for x = 1:5
%                     angle = [x*angle(t)/5 angle(t+1:length(angle))];
%                 end
%             otherwise
%                 for x = 1:5
%                     angle = [angle(1:t+x-2)   angle(t-1)+x*abs(angleDiff(t))/5   angle(t+x:length(angle))];
%                 end
%         end
%         t = t+3;
%     end
%     t = t+1;
% end
      
% finalPoints(1,1) = 0;
% finalPoints(1,2) = 0;
% for t = 2:length(points_all)
%     finalPoints(t,1) = finalPoints(t-1,1) + cos(angle(t-1))*pathVectorLength;
%     finalPoints(t,2) = finalPoints(t-1,2) + sin(angle(t-1))*pathVectorLength;
% end

end