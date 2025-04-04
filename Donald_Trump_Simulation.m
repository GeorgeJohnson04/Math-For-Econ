%% Parameters
GDP_current = 27.36; 
population = 0.3349; 
wealth_top10_current = 60; 

% GDP Elasticity Parameters
beta_C = 0.6817; 
beta_I = 0.207;  
beta_G = 0.207;  

% Policy Changes
tax_rate = 0.22;  
tariff_increase = 0.75;  
policy_shift_max = tax_rate + tariff_increase; % Total policy shift

% Elasticity
GDP_elasticity = beta_C + beta_I + beta_G;  
wealth_elasticity = 0.4 + 0.1;  

%% Define General Equations
GDP_func = @(theta) GDP_current * (1 + GDP_elasticity * theta);
Wealth_func = @(theta) wealth_top10_current * (1 + wealth_elasticity * theta);
GDP_pc_func = @(theta) GDP_func(theta) / population; 

%% Generate Data for Graphs
policy_shift = linspace(0, policy_shift_max, 100); % Varying policy shift values
GDP_values = GDP_func(policy_shift); 
GDP_pc_values = GDP_pc_func(policy_shift);
Wealth_values = Wealth_func(policy_shift);

%% Change in GDP
figure;
plot(policy_shift, GDP_values - GDP_current, 'k', 'LineWidth', 2); % Black line
title('\bf Change in GDP with Policy Shifts', 'FontSize', 14);
xlabel('Policy Shift (\theta = \Delta T + \Delta Tariff)', 'FontSize', 12, 'Interpreter', 'tex');
ylabel('Change in GDP (\Delta GDP in trillion USD)', 'FontSize', 12, 'Interpreter', 'tex');
grid on;
xline(0.22, '--k', 'Avg Income Tax Rate', 'FontSize', 10, 'LabelHorizontalAlignment', 'left');
xline(0.75, '--k', 'Full Tariff Increase', 'FontSize', 10, 'LabelHorizontalAlignment', 'left');

%% Change in GDP Per Capita 
figure;
plot(policy_shift, GDP_pc_values, '--k', 'LineWidth', 2); % Black dashed line
title('\bf Change in GDP Per Capita with Policy Shifts', 'FontSize', 14);
xlabel('Policy Shift (\theta = \Delta T + \Delta Tariff)', 'FontSize', 12, 'Interpreter', 'tex');
ylabel('GDP Per Capita (thousand USD/person)', 'FontSize', 12, 'Interpreter', 'tex');
grid on;
xline(0.22, '--k', 'Avg Income Tax Rate', 'FontSize', 10, 'LabelHorizontalAlignment', 'left');
xline(0.75, '--k', 'Full Tariff Increase', 'FontSize', 10, 'LabelHorizontalAlignment', 'left');

%% Change in Wealth Disparity
figure;
plot(policy_shift, Wealth_values - wealth_top10_current, '-.k', 'LineWidth', 2); % Black dash-dot line
title('\bf Change in Wealth Disparity with Policy Shifts', 'FontSize', 14);
xlabel('Policy Shift (\theta = \Delta T + \Delta Tariff)', 'FontSize', 12, 'Interpreter', 'tex');
ylabel('Change in Wealth Disparity (\Delta G in %)', 'FontSize', 12, 'Interpreter', 'tex');
grid on;
xline(0.22, '--k', 'Avg Income Tax Rate', 'FontSize', 10, 'LabelHorizontalAlignment', 'left');
xline(0.75, '--k', 'Full Tariff Increase', 'FontSize', 10, 'LabelHorizontalAlignment', 'left');

% After GDP plot
saveas(gcf, 'GDP_change.png');

% After GDP per capita plot
saveas(gcf, 'GDP_per_capita.png');

% After Wealth disparity plot
saveas(gcf, 'Wealth_disparity.png');
