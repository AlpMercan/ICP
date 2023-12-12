clc;
clear;
% % %
% Generate a random data to visualize and check our calculations
rng(42); % Set seed for reproducibility

num_points = 100; %important parameter

% Its 2D so 2, num_points
P = randn(2, num_points);

% What will be the magic transformation/rotation between Q and P
%P is our imaginary scan data
%Q is our imaginary target data
angle = 30; % Rotation angle in degrees
R = [cosd(angle), -sind(angle); sind(angle), cosd(angle)]; % Rotation matrix
translation = [5; 3]; % Translation vector
Q = R * P + translation;

% Add some noise to Q to increase it
Q = Q + 0.2 * randn(size(Q));
% % % % 

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


