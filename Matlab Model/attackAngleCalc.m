function attackAngleMatrix = attackAngleCalc(angleMatrix, frontVelocityMatrix)
global vMax
k = 2; %smieszny wspolczynnik
attackAngleMatrix = k*atan(frontVelocityMatrix/(pi*vMax)).*[0 diff(angleMatrix)];

end

