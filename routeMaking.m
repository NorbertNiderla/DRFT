%  ______ _____ ____  ______ _____    _______ ______          __  __ 
% |  ____|_   _|  _ \|  ____|  __ \  |__   __|  ____|   /\   |  \/  |
% | |__    | | | |_) | |__  | |__) |    | |  | |__     /  \  | \  / |
% |  __|   | | |  _ <|  __| |  _  /     | |  |  __|   / /\ \ | |\/| |
% | |     _| |_| |_) | |____| | \ \     | |  | |____ / ____ \| |  | |
% |_|    |_____|____/|______|_|  \_\    |_|  |______/_/    \_\_|  |_|

function [angle, waypoints] = routeMaking

    %waypoints loading
    waypoints = load('waypoints.mat');
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
    
    %calculating actual angle
    angle = unwrap([angle angle(length(angle))]);
    
    waypoints = points_all;
end