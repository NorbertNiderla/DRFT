%  ______ _____ ____  ______ _____    _______ ______          __  __ 
% |  ____|_   _|  _ \|  ____|  __ \  |__   __|  ____|   /\   |  \/  |
% | |__    | | | |_) | |__  | |__) |    | |  | |__     /  \  | \  / |
% |  __|   | | |  _ <|  __| |  _  /     | |  |  __|   / /\ \ | |\/| |
% | |     _| |_| |_) | |____| | \ \     | |  | |____ / ____ \| |  | |
% |_|    |_____|____/|______|_|  \_\    |_|  |______/_/    \_\_|  |_|

function v = velocityCalc(angleMatrix, aMax, vMax, v0)

    k=length(angleMatrix);
    v=ones(1,k);
    v(1)=v0;
    z=10; %Acceleration Factor
    f=2; %Decceleration Factor
    a=z*[cos(diff(angleMatrix)*2.5*pi)*aMax 0].*[atan(diff(diff(angleMatrix))*f) 0 0];

    for i=1:k-1
        v(i+1)=v(i)+(-v(i)/vMax+1)*a(i);
        if v(i+1)>vMax
            v(i+1)=50;
        end
    end
end
