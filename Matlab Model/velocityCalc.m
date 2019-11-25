function v = velocityCalc(angleMatrix, radius)

global aMax vMax v0
k=length(angleMatrix);
v=ones(1,k);
v(1)=v0;
z=10;
f=2;
a=z*[cos(diff(angleMatrix)*2.5*pi)*aMax 0].*[atan(diff(diff(angleMatrix))*f) 0 0];

    %a=[(aMax-(aMax/0.9)*diff(angleMatrix)) 0].*[(diff(diff(angleMatrix))/1.8) 0 0];

for i=1:k-1
    v(i+1)=v(i)+(-v(i)/vMax+1)*a(i);
    if v(i+1)>vMax
        v(i+1)=50;
    end
end

