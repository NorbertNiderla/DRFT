%  ______ _____ ____  ______ _____    _______ ______          __  __ 
% |  ____|_   _|  _ \|  ____|  __ \  |__   __|  ____|   /\   |  \/  |
% | |__    | | | |_) | |__  | |__) |    | |  | |__     /  \  | \  / |
% |  __|   | | |  _ <|  __| |  _  /     | |  |  __|   / /\ \ | |\/| |
% | |     _| |_| |_) | |____| | \ \     | |  | |____ / ____ \| |  | |
% |_|    |_____|____/|______|_|  \_\    |_|  |______/_/    \_\_|  |_|

function attackAngle = attackAngleCalc(angle, frontVelocity, vMax)
    k = 15; %Slip Factor
    
    %creation and calculation of attack angle matrix, where attack angle is
    %angle between road and longitudinal axis of car
    attackAngle = k*atan(frontVelocity/(pi*vMax)).*([0 diff(angle)]);
    attackAngle = attackAngle-[diff(angle) attackAngle(length(attackAngle))];
end

