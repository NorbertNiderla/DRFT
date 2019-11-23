function attackAngle = attackAngleCalc(angle, frontVelocity)
global vMax
k = 15; %smieszny wspolczynnik
attackAngle = k*atan(frontVelocity/(pi*vMax)).*([0 diff(angle)]);
attackAngle = attackAngle-[diff(angle) attackAngle(length(attackAngle))];
end

