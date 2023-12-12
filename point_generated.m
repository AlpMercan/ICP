clc
clear 

% Number of points for the curve
num_points = 100;

% Generate a curve for P
t = linspace(0, 4 * pi, num_points);
x = t;
y = 0.5 * cos(t);

P = [x; y];

% Apply a rotation and translation to P to get Q
angle = 30; % Rotation angle in degrees
R = [cosd(angle), -sind(angle); sind(angle), cosd(angle)]; % Rotation matrix
translation = [5; 3]; % Translation vector
Q = R * P + translation;

% Add some noise to Q
Q = Q + 0.2 * randn(size(Q));

% Visualize the points
figure;
scatter(P(1, :), P(2, :), 'b', 'filled', 'DisplayName', 'P');
hold on;
scatter(Q(1, :), Q(2, :), 'r', 'filled', 'DisplayName', 'Q');
title('Generated Point Sets P and Q');
xlabel('X-axis');
ylabel('Y-axis');
legend('Location', 'Best');
axis equal;
hold off;

% Save the data to a file if needed
save('icp_example_data.mat', 'P', 'Q');