% Define constants based on new data
GDP_current = 27.36; % Current GDP in trillion USD (2023)
wealth_top10 = 60;   % Percentage of wealth held by top 10% families

% Updated tax and tariff parameters
avg_tax_rate = 0.22;  % Average effective tax rate (22%)
initial_tariff_rate = 0.02; % Initial tariff rate (2%)

% Updated elasticity parameters for GDP equation (based on FY2023 data)
beta_C = 0.6817; % Consumption elasticity to tax/tariff change
beta_I = 0.207;  % Investment elasticity to tax/tariff change
beta_G = 0.227;  % Government spending elasticity to tax/tariff change

% Elasticity parameters for wealth distribution equation
alpha_Y = 0.4; % Income distribution elasticity to tax/tariff change
alpha_RR = 0.1; % Redistribution elasticity to tax/tariff change

%% Simulation 1: Removal of Income Tax (Decrease Tax Rate to Zero)
% Create a range for Delta T (change in tax from 22% to 0%)
Delta_T = linspace(avg_tax_rate, 0, 100);  % 100 steps from 22% to 0%

% Simulate the effect on GDP (Delta GDP) for each Delta T
Delta_GDP_tax = (beta_C + beta_I + beta_G) .* Delta_T .* GDP_current;

% Simulate the effect on Wealth Distribution (Delta G) for each Delta T
Delta_G_tax = (alpha_Y + alpha_RR) .* Delta_T .* wealth_top10;

%% Simulation 2: Increase in Tariffs (Tariff Increase from 2% to 100%)
% Create a range for Delta Tariff (change in tariff from 2% to 100%)
Delta_Tariff = linspace(initial_tariff_rate, 1.0, 100);  % 100 steps from 2% to 100%

% Simulate the effect on GDP (Delta GDP) for each change in tariff
Delta_GDP_tariff = (beta_C + beta_I + beta_G) .* Delta_Tariff .* GDP_current;

% Simulate the effect on Wealth Distribution (Delta G) for each change in tariff
Delta_G_tariff = (alpha_Y + alpha_RR) .* Delta_Tariff .* wealth_top10;

%% Plot Figure 1: Separate Effects
figure;

% Subplot 1: Effect on GDP (Removal of Income Tax)
subplot(2, 2, 1);
plot(Delta_T, Delta_GDP_tax, 'b', 'LineWidth', 2);
title('Effect on GDP: Removal of Income Tax');
xlabel('Change in Tax Rate (\Delta T)');
ylabel('Change in GDP (\Delta GDP in Trillion USD)');
grid on;

% Subplot 2: Effect on Wealth Distribution (Removal of Income Tax)
subplot(2, 2, 2);
plot(Delta_T, Delta_G_tax, 'r', 'LineWidth', 2);
title('Effect on Wealth Distribution: Removal of Income Tax');
xlabel('Change in Tax Rate (\Delta T)');
ylabel('Change in Wealth Distribution (% of Wealth)');
grid on;

% Subplot 3: Effect on GDP (Increase in Tariffs)
subplot(2, 2, 3);
plot(Delta_Tariff, Delta_GDP_tariff, 'g', 'LineWidth', 2);
title('Effect on GDP: Increase in Tariffs');
xlabel('Change in Tariff Rate (\Delta Tariff)');
ylabel('Change in GDP (\Delta GDP in Trillion USD)');
grid on;

% Subplot 4: Effect on Wealth Distribution (Increase in Tariffs)
subplot(2, 2, 4);
plot(Delta_Tariff, Delta_G_tariff, 'm', 'LineWidth', 2);
title('Effect on Wealth Distribution: Increase in Tariffs');
xlabel('Change in Tariff Rate (\Delta Tariff)');
ylabel('Change in Wealth Distribution (% of Wealth)');
grid on;

%% Simulation 3: Combined Tax and Tariff Changes
% Assume that tax rate and tariff rate change simultaneously
% (i.e., index i represents a simultaneous change in both)
Delta_T_combined = Delta_T; % Tax change (22% to 0%)
Delta_Tariff_combined = linspace(initial_tariff_rate, 1.0, 100); % Tariff change (2% to 100%)

% Simulate combined effect on GDP
Delta_GDP_combined = (beta_C + beta_I + beta_G) .* (Delta_T_combined + Delta_Tariff_combined) .* GDP_current;

% Simulate combined effect on Wealth Distribution
Delta_G_combined = (alpha_Y + alpha_RR) .* (Delta_T_combined + Delta_Tariff_combined) .* wealth_top10;

%% Plot Figure 2: Combined Effects
figure;

% Subplot 1: Combined Effect on GDP
subplot(1, 2, 1);
plot(Delta_T_combined + Delta_Tariff_combined, Delta_GDP_combined, 'b', 'LineWidth', 2);
title('Combined Effect on GDP');
xlabel('Simultaneous Change in Tax and Tariff Rates (\Delta T + \Delta Tariff)');
ylabel('Change in GDP (\Delta GDP in Trillion USD)');
grid on;

% Subplot 2: Combined Effect on Wealth Distribution
subplot(1, 2, 2);
plot(Delta_T_combined + Delta_Tariff_combined, Delta_G_combined, 'r', 'LineWidth', 2);
title('Combined Effect on Wealth Distribution');
xlabel('Simultaneous Change in Tax and Tariff Rates (\Delta T + \Delta Tariff)');
ylabel('Change in Wealth Distribution (% of Wealth)');
grid on;
