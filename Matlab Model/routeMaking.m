function [angle, waypoints] = routeMaking

    %WAZNA ADNOTACJA, JAK ANGLEDIFF JEST UJEMNY TO TRASA SCKRECA W PRAWO, MOZNA
    %TO LATWO ZMIENIC W MIEJSCU GDZIE ANGLEDIFF JEST LICZONY

    %waypoints loading
    waypoints = load('waypoints');
    waypoints = waypoints.waypoints;
    
    %"sampling density"
    pathVectorLength = 0.5;
    
    %path lentgth calculation
    curveLength = arclength(waypoints(:,1), waypoints(:,2));
   
    %creating new route with more waypoints
    points_all = interparc(round(curveLength/pathVectorLength), waypoints(:,1), waypoints(:,2)); 

    %calculation of slope angles of each part of path
    angle = [];
    for j = 1:(length(points_all)-1)
       angle = [angle atan2((points_all(j+1,2)-points_all(j,2)), (points_all(j+1,1)-points_all(j,1)))];
    end

    waypoints = points_all;
end