function attackAngleMatrix = attackAngleCalc(angleMatrix, frontVelocityMatrix)
global vMax
k = 15; %smieszny wspolczynnik
attackAngleMatrix = k*atan(frontVelocityMatrix/(pi*vMax)).*([0 diff(angleMatrix)]);
attackAngleMatrix = attackAngleMatrix-[diff(angleMatrix) attackAngleMatrix(length(attackAngleMatrix))];
end

