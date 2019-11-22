function att_angle = attack_angle(agent_coordinates, waypoints)
% function calculating attack angle of the agent.
% params:
%   - agent_coordinates: 2x2 matrix, containing front and rear coordinates
%           of the agent, first row for front, second for the rear
%   - waypoints: 2x2 matrix, containing coordinates of two consecutive
%           waypoints
% returns:
%   - angle of attack of the agent (in radians)

% argument size check
if ~isequal(size(agent_coordinates), size(waypoints), [2 2])
    erorr('Wrong dimensions of the arguments.')
end

% normalizing coordinates
% agent coordinates
cord_norm = agent_coordinates(1, :);
agent_coordinates(1, :) = agent_coordinates(1, :) - cord_norm;
agent_coordinates(2, :) = agent_coordinates(2, :) - cord_norm;

% waypoints
wayp_norm = waypoints(1, :);
waypoints(1, :) = waypoints(1, :) - wayp_norm;
waypoints(2, :) = waypoints(2, :) - wayp_norm;

% creating vectors
agent_vec = agent_coordinates(2, :) - agent_coordinates(1, :);
waypoints_vec = waypoints(2, :) - waypoints(1, :);

% calculating angle of attack
att_angle = acos(min(1,max(-1, agent_vec(:).' * waypoints_vec(:) ...
    / norm(agent_vec) / norm(waypoints_vec) )));



end

