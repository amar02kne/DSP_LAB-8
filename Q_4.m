%%%%%%%%% 4
% Define the parameters
R0 = 1.15;
K = 1e6;
n = 100;

% Initialize arrays to store results
y = zeros(n+1, 1);
x = zeros(n+1, 1);

% Initial condition
y(1) = 1;

% Calculate y[n] for the first-order model
for i = 2:n+1
    y(i) = 1 + R0 * y(i - 1);
end

% Calculate x[n] for the logistic model
for i = 1:n+1
    x(i) = K / (1 + (K * (R0 - 1) - R0) * R0^(-i));
end

% Plot the results
figure;
plot(0:n, y, 'b', 'LineWidth', 2, 'DisplayName', 'First-order Model');
hold on;
plot(0:n, x, 'r', 'LineWidth', 2, 'DisplayName', 'Logistic Model');
xlabel('Days');
ylabel('Total Infections');
title('Epidemic Model Comparison');
legend('Location', 'Northwest');

% Find the point of inflection using the first derivative
dy = diff(x);
[~, inflection_day] = max(dy);
inflection_infections = x(inflection_day);

% Find the point of inflection using the second derivative (zero-crossing)
d2y = diff(dy);
zero_crossing_day = find(d2y > 0, 1);

fprintf('Point of Inflection (First Derivative): Day %d, Total Infections %f\n', inflection_day, inflection_infections);
fprintf('Point of Inflection (Zero-Crossing Second Derivative): Day %d, Total Infections %f\n', zero_crossing_day, x(zero_crossing_day));