function attackAngleMatrix = attackAngleMatrixCalc(angleMatrix, frontVelocityMatrix)
k = 0.05; %smieszny wspolczynnik
attackAngleMatrix = k*frontVelocityMatrix.*[0 diff(angleMatrix)];

end

