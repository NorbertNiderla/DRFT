%  ______ _____ ____  ______ _____    _______ ______          __  __ 
% |  ____|_   _|  _ \|  ____|  __ \  |__   __|  ____|   /\   |  \/  |
% | |__    | | | |_) | |__  | |__) |    | |  | |__     /  \  | \  / |
% |  __|   | | |  _ <|  __| |  _  /     | |  |  __|   / /\ \ | |\/| |
% | |     _| |_| |_) | |____| | \ \     | |  | |____ / ____ \| |  | |
% |_|    |_____|____/|______|_|  \_\    |_|  |______/_/    \_\_|  |_|


function data = createData(aFront, aBack, waypoints, frontVelocity, drift)
t = [0];
% calculating time stamps of each sample
for x = 2:length(waypoints)
    t(x) = t(x-1) + norm(waypoints(x,:) - waypoints(x-1,:))/frontVelocity(x);  
end
%saving data
data = transpose([t; real(aBack); imag(aBack); real(aFront); imag(aFront); drift]);
csvwrite('data.csv', data);
end

