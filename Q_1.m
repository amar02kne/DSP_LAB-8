%%%%% 1.1
% Define the system transfer function
R0 = 0.5; 
numerator = 1;
denominator = [1, -R0];

% Create a system object
sys = tf(numerator, denominator, 1);

% Plot the pole-zero plot
pzmap(sys);
grid on

%%%%% 1.2
% Parameters
R0 = 2.5; % Change this value as needed
n = 20;  % Number of days

% Initialize an array to store the number of newly infected people
new_infections = zeros(1, n);

% Initial condition (one infected person on day 0)
new_infections(1) = 1;

% Calculate the number of newly infected people for each day
for day = 2:n
    new_infections(day) = R0 * new_infections(day - 1);
end

% Plot the number of newly infected people over time
figure;
plot(0:n-1, new_infections, 'b-o');
title('Number of Newly Infected People Over Time');
xlabel('Day');
ylabel('Number of New Infections');
grid on

% Display the final number of newly infected people
final_infections = new_infections(end);
fprintf('Number of newly infected people after %d days: %d\n', n, final_infections);


%%%% 1.3
% Parameters
R0 = 2.5;
target_infections = 1e6; % 1 million

% Initialize the number of newly infected people and day counter
new_infections = 1; % Initial condition
n = 0;

% Calculate the number of days required to reach the target infections
while new_infections < target_infections
    n = n + 1;
    new_infections = R0 * new_infections;
end

fprintf('It will take %d days to reach 1 million new daily infections with R0 = %.1f.\n', n, R0);


%%%%%% 1.4
syms y(n) z R0(n)  % define system and variables
assume(n>=0 & in(n,"integer"))
f1 = y(n) - R0(n)*y(n-1) - kroneckerDelta(n) % define eqn
days = 50;
syms r
f1 =  subs(f1,R0(n),r); 
r = solve(f1,r);
Y = [2, 4, 5, 6, 10, 19, 65, 78, 114, 137, 140, 144, 173, 204, 225, 245, 254, 287, 307, 341, 368, 373,387, 404, 423, 460, 506, 571, 596, 614, 658, 688, 755, 807, 835, 855, 1007, 1143, 1245, 1391,1607, 1806, 1907, 2111, 2191, 2340, 2528, 2710, 2772, 2865] ;% find data for first 50 days frm covid website
rT = zeros(1,days); % put days here
for i =1:length(Y)-1
    r1 = subs(r,n,i);
    rT(i) = subs(r1,[y(i-1) y(i)],[Y(i) Y(i+1)]);
end
R_avg = sum(rT)/length(rT)


%%%%%%%%%% 1.5
% Parameters
R0 = 2.5;
n = 20;  % Number of days

% Initialize arrays to store new daily infections and total infections
new_infections = zeros(1, n);
total_infections = zeros(1, n);

% Initial infection (one infected person on day 0)
new_infections(1) = 1;
total_infections(1) = new_infections(1);

% Calculate new daily infections and total infections
for day = 2:n
    new_infections(day) = R0 * new_infections(day - 1);
    total_infections(day) = total_infections(day - 1) + new_infections(day);
end

% Plot new daily infections
figure;
subplot(2, 1, 1);
plot(0:n-1, new_infections, 'b-o');
title('New Daily Infections (R0 = 2.5)');
xlabel('Day');
ylabel('New Infections');
grid on

% Plot total infections
subplot(2, 1, 2);
plot(0:n-1, total_infections, 'r-o');
title('Total Infections (R0 = 2.5)');
xlabel('Day');
ylabel('Total Infections');
grid on

% Display the final total infections
final_total_infections = total_infections(end);
fprintf('Total infections after %d days: %d\n', n, final_total_infections);