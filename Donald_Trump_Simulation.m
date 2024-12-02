%% Parameters
    % Economic Data (2023)
        GDP_current = 27.36; 
        population = 0.3349; 
        GDP_pc_current = 81.695; % Per Capita
        wealth_top10_current = 60; % Wealth held by top 10% 

    % GDP Parameters (2023)
        beta_C = 0.6817; % Consumption
        beta_I = 0.207;  % Investment 
        beta_G = 0.207;  % Government spending 

    % Policy Changes
        tax_rate = 0.22; % Average income tax rate 
        tariff_increase = 0.75; % Tariff increase from 25% to 100% (This is Trumps most extreme plan)

    % Elasticity Parameters
        GDP_elasticity = beta_C + beta_I + beta_G; % GDP elasticity
        wealth_elasticity = 0.4 + 0.1; % Wealth disparity elasticity

%% Calculations

    % Change in GDP
        Delta_GDP = GDP_elasticity * (tax_rate + tariff_increase) * GDP_current;
        GDP_new = GDP_current + Delta_GDP;

    % GDP Per Capita 
        GDP_pc_new = GDP_new / population;

% Change in Wealth Disparity 
        Delta_G = wealth_elasticity * (tax_rate + tariff_increase) * wealth_top10_current;
        wealth_top10_new = wealth_top10_current + Delta_G;

%% Display Results
    fprintf('Change in GDP: %.2f trillion USD\n', Delta_GDP);
    fprintf('New GDP: %.2f trillion USD\n', GDP_new);
    fprintf('New GDP Per Capita: %.2f thousand USD/person\n', GDP_pc_new);
    fprintf('Change in Wealth Disparity: %.2f%%\n', Delta_G);
    fprintf('New Wealth Disparity: %.2f%% (Wealth held by top 10%%)\n', wealth_top10_new);

%% Visualization

    % Change in GDP, GDP Per Capita, and Wealth Disparity over policy shifts
        policy_shift = linspace(0, tax_rate + tariff_increase, 100); % Range of combined policy shifts
        Delta_GDP_values = GDP_elasticity * policy_shift * GDP_current;
        GDP_pc_values = (GDP_current + Delta_GDP_values) / population; % GDP per capita for each shift
        Delta_G_values = wealth_elasticity * policy_shift * wealth_top10_current;

%results
    figure;

    %Change in GDP
        subplot(3, 1, 1);
        plot(policy_shift, Delta_GDP_values, 'b', 'LineWidth', 2);
        title('Change in GDP with Policy Shifts');
        xlabel('Policy Shift (\Delta T + \Delta Tariff)', 'Interpreter', 'tex');
        ylabel('Change in GDP (\Delta GDP in trillion USD)', 'Interpreter', 'tex');
        grid on;

    %Change in GDP Per Capita 
        subplot(3, 1, 2);
        plot(policy_shift, GDP_pc_values, 'g', 'LineWidth', 2);
        title('Change in GDP Per Capita with Policy Shifts');
        xlabel('Policy Shift (\Delta T + \Delta Tariff)', 'Interpreter', 'tex');
        ylabel('GDP Per Capita (thousand USD/person)', 'Interpreter', 'tex'); 
        grid on;

    %Change in Wealth Disparity
        subplot(3, 1, 3);
        plot(policy_shift, Delta_G_values, 'r', 'LineWidth', 2);
        title('Change in Wealth Disparity with Policy Shifts');
        xlabel('Policy Shift (\Delta T + \Delta Tariff)', 'Interpreter', 'tex');
        ylabel('Change in Wealth Disparity (\Delta G in %)', 'Interpreter', 'tex');
        grid on;
