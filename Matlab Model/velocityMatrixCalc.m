function v = velocityMatrixCalc(angleMatrix)

global aMax vMax v0
k=length(angleMatrix);
v=ones(1,k);
v(1)=v0;
a=[(aMax-(aMax/0.9)*diff(angleMatrix)) 0].*[(diff(diff(angleMatrix))/1.8) 0 0];

for i=1:k
    v(i+1)=(-vMax*v(i))/aMax^2+1+a(i);
end

