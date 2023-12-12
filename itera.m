clc;
clear;

% Load data
load('icp_example_data.mat');

% Set ICP parameters
max_iterations = 1000;
threshold = 0.000001;

ICP(P, Q, max_iterations, threshold);

%%%%%%
%%%%%% Iterative Closest Point (ICP) algorithm
%%%%%%
function ICP(P, Q, max_iterations, threshold)
    n = size(P, 2); % size of matrices

    % Store original points for visualization
    P_original = P;

    % Iterate until the maximum number of iterations or convergence
    for iter = 1:max_iterations
        % Finding out Rotation (R) Matrix
        H = zeros(2);

        for i = 1:n
            H = H + P(:, i) * Q(:, i)';
        end

        [U, ~, V] = svd(H);
        R = V * U';

        % Finding Translation (t) Matrix
        t = mean(Q - R * P, 2);

        % Construct the transformation matrix
        T_increment = eye(2, 3);
        T_increment(1:2, 1:2) = R;
        T_increment(1:2, 3) = t;

        % Apply the transformation to P
        P = T_increment(1:2, 1:2) * P + T_increment(1:2, 3);

        % Display the updated transformation matrix
        disp(['Iteration: ', num2str(iter)]);
        disp('Updated Transformation Matrix (T_increment):');
        disp(T_increment);
        

        % Check convergence
        if norm(T_increment - eye(2, 3)) < threshold
            disp(['Converged at iteration ', num2str(iter)]);
            break;
        end
        
    end

    % Plot the original, transformed, and target points
    figure;
    scatter(Q(1, :), Q(2, :), 'r', 'filled', 'DisplayName', 'Q (Target)');
    hold on;
    scatter(P_original(1, :), P_original(2, :), 'b', 'filled', 'DisplayName', 'P (Original)');
    scatter(P(1, :), P(2, :), 'g', 'filled', 'DisplayName', ['P (Transformed) - Iteration ', num2str(iter)]);
    title(['Original, Transformed, and Target Points - Iteration ', num2str(iter)]);
    xlabel('X-axis');
    ylabel('Y-axis');
    legend('Location', 'Best');
    axis equal;
    hold off;
end