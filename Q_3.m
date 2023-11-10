% % Coefficients for the filter
% a = [0.1, 0.15, 0.25, 0.26, 0.34, 0.42, 0.25, 0.2, 0.15, 0.1, 0.1, 0.1];
% 
% % Multiplicative factor
% rho = 0.25;
% 
% % Number of days to simulate
% n = 100;
% 
% % Plot infections with modified coefficients
% plotInfectionsWithMultiplication(a, rho, n);
% 
% 
% function plotInfectionsWithMultiplication(a, rho, n)
%     % a: Coefficients for the filter
%     % rho: Multiplicative factor
%     % n: Number of days to simulate
% 
%     % Apply the multiplication to coefficients
%     a_modified = (1 - rho) * a;
% 
%     % Initialize the filter
%     b = 1;  % Numerator coefficients (1 for integrator)
%     filterOrder = length(a_modified);
% 
%     % Generate Kronecker delta input
%     delta = zeros(1, n);
%     delta(1) = 1;
% 
%     % Initialize output signals
%     newDailyInfections = zeros(1, n);
%     totalInfections = zeros(1, n);
% 
%     % Simulate the response without lsim
%     for t = 1:n
%         % Update new daily infections
%         for k = 1:min(t, filterOrder)
%             newDailyInfections(t) = newDailyInfections(t) + a_modified(k) * delta(t - k + 1);
%         end
% 
%         % Update total infections
%         if t > 1
%             totalInfections(t) = totalInfections(t - 1) + newDailyInfections(t);
%         else
%             totalInfections(t) = newDailyInfections(t);
%         end
%     end
% 
%     % Plot new daily infections
%     figure;
%     subplot(2,1,1);
%     plot(newDailyInfections);
%     title('New Daily Infections (Modified Coefficients) rho=0.25');
%     xlabel('Day');
%     ylabel('Infections');
% 
%     % Plot total infections
%     subplot(2,1,2);
%     plot(totalInfections);
%     title('Total Infections (rho=0.25)');
%     xlabel('Day');
%     ylabel('Total Infections');
% end

% Define the coefficients and parameters
M = 12;
ak = [0.1, 0.15, 0.25, 0.26, 0.34, 0.42, 0.25, 0.2, 0.15, 0.1, 0.1, 0.1];
n_max = 100;
rho_values = [0.25, 0.50, 0.75];
total_infections = zeros(length(rho_values), 1);

% Initialize arrays for the input (Kronecker delta) and output (daily infections)
x = zeros(1, n_max + 1);
y = zeros(1, n_max + 1);

% Loop over different ρ values
for rho_idx = 1:length(rho_values)
    rho = rho_values(rho_idx);
    
    % Set the Kronecker delta at day 0
    x(1) = 1;
    
    % Apply the IIR filter with scaled coefficients
    for n = 1:n_max
        for k = 1:M
            if n - k > 0
                y(n + 1) = y(n + 1) + (1 - rho) * ak(k) * y(n - k + 1);
            end
        end
        y(n + 1) = 1 - y(n + 1);
    end
    
    % Calculate the total number of infections for n = 100 days
    total_infections(rho_idx) = sum(y);
    
    % Plot the daily infections for the current ρ value
    subplot(1, length(rho_values), rho_idx);
    plot(0:n_max, y);
    title(['ρ = ' num2str(rho)]);
    xlabel('Day');
    ylabel('Daily Infections');
    grid on;
end

% Display the total number of infections for each ρ value
disp('Total Infections for Different ρ Values:');
disp(total_infections);