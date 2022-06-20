%%------------------------------------------------------------------------%
% Conversion Loss of Buck Converter Calculations
% By Nicholas Hobar
%
% Reference Document:
% https://docs.google.com/document/d/17nrdAeukGtVMc0SeCMdbwDUFumVB_zqZIU7SjN4xiOA/edit?usp=sharing
%%------------------------------------------------------------------------%

clc
clear
close all

% Variable Definitions
R_on_H_3V3 = 0.17; % High-side MOSFET on-resistance [Ohms], assuming max R
R_on_L_3V3 = 0.07; % Low-side MOSFET on-resistance [Ohms]
R_on_H_12V = 0.145; % High-side MOSFET on-resistance [Ohms], assuming max R
R_on_L_12V = 0.095; % Low-side MOSFET on-resistance [Ohms]
R_on_SP = 0.23; % High-side MOSFET on-resistance [Ohms], assuming max R
V_in = 16.3; % Input Voltage [V]
V_in_SP = 24; % SP Buck Input Voltage [V]
V_out_3V3 = 3.3; % Output Voltage [V]
V_out_12V = 12; % Output Voltage [V]
V_out_SP = 16.3; % Solar Panel Buck Output Voltage [V]
F_sw = 2.5e6; % Switching frequency [Hz]
t_r_H_3V3 = 4e-9; % High-side MOSFET rise time [s]
t_f_H_3V3 = 4e-9; % High-side MOSFET fall time [s]
t_r_L_3V3 = t_r_H_3V3; % Low-side MOSFET rise time [s]
t_f_L_3V3 = t_f_H_3V3; % Low-side MOSFET fall time [s]
t_r_H_12V = 2e-9; % High-side MOSFET rise time [s]
t_f_H_12V = 2e-9; % High-side MOSFET fall time [s]
t_r_L_12V = t_r_H_12V; % Low-side MOSFET rise time [s]
t_f_L_12V = t_f_H_12V; % Low-side MOSFET fall time [s]
V_d = 0.5; % Forward direction voltage of low-side MOSFET body diode [V]
I_cc_3V3 = 2.5; % IC current consumption [A] (I don't think these are right)
I_cc_12V = 1;
DCR_3V3 = 0.046; % Inductor direct current resistance [Ohms]
DCR_12V = 0.092;

%% Power Loss and Pre-Allocation
I_out_Vec = 0:0.01:3; % Output Current [A]
P_con_H_3V3 = zeros(size(I_out_Vec)); % Conduction loss High-side MOSFET
P_con_L_3V3 = zeros(size(I_out_Vec)); % Conduction loss Low-side MOSFET
P_sw_H_3V3 = zeros(size(I_out_Vec)); % Switching loss High-side MOSFET
P_sw_L_3V3 = zeros(size(I_out_Vec)); % Switching loss Low-side MOSFET
P_con_H_12V = zeros(size(I_out_Vec)); % Conduction loss High-side MOSFET
P_con_L_12V = zeros(size(I_out_Vec)); % Conduction loss Low-side MOSFET
P_sw_H_12V = zeros(size(I_out_Vec)); % Switching loss High-side MOSFET
P_sw_L_12V = zeros(size(I_out_Vec)); % Switching loss Low-side MOSFET
P_ic_3V3 = zeros(size(I_out_Vec)); % Operation Loss from IC Control Circuit
P_ic_12V = zeros(size(I_out_Vec));
P_l_dcr_3V3 = zeros(size(I_out_Vec)); % Conduction loss in Inductor
P_l_dcr_12V = zeros(size(I_out_Vec));
P_con_SP = zeros(size(I_out_Vec)); % Conduction loss in Solar Panels
P_sw_SP = zeros(size(I_out_Vec)); % Switching loss in Solar Panels
P_q_SP = zeros(size(I_out_Vec)); % Quiescent Current loss in Solar Panels
P_3V3 = zeros(size(I_out_Vec)); % Total Power loss in 3V3 Buck
P_12V = zeros(size(I_out_Vec)); % Total Power loss in 12V Buck
P_SP = zeros(size(I_out_Vec)); % Total Power loss in Solar Panel Buck
Eff_3V3 = zeros(size(I_out_Vec)); % Efficiency 3V3 Buck
Eff_12V = zeros(size(I_out_Vec)); % Efficiency 12V Buck
Eff_SP = zeros(size(I_out_Vec)); % Efficiency Solar Panel Buck
Eff = zeros(size(I_out_Vec)); % Total Efficiency
P = zeros(size(I_out_Vec)); % Total Power Loss

for k = 1 : length(I_out_Vec)
    I_out = I_out_Vec(k);
    
    % 3V3 Buck Converter
    P_con_H_3V3(k) = I_out.^2 * R_on_H_3V3 * (V_out_3V3/V_in); % [W]
    P_con_L_3V3(k) = I_out.^2 * R_on_L_3V3 * (1 - V_out_3V3/V_in); % [W]
    
    P_sw_H_3V3(k) = 0.5 * V_in * I_out * (t_r_H_3V3 + t_f_H_3V3) * F_sw; % [W]
    
    P_l_dcr_3V3(k) = I_out^2 * DCR_3V3; % [W]
    
    % 12V Buck Converter
    P_con_H_12V(k) = I_out.^2 * R_on_H_12V * (V_out_12V/V_in); % [W]
    P_con_L_12V(k) = I_out.^2 * R_on_L_12V * (1 - V_out_12V/V_in); % [W]
    
    P_sw_H_12V(k) = 0.5 * V_in * I_out * (t_r_H_12V + t_f_H_12V) * F_sw; % [W]
    
    P_l_dcr_12V(k) = I_out^2 * DCR_12V; % [W]
    
    % Solar Panel Buck Converter
    P_con_SP(k) = I_out.^2 * R_on_SP * (V_out_SP/V_in_SP); % [W]
    
    P_sw_SP(k) = V_in_SP * I_out * 0.01; % [W]
    
    P_q_SP(k) = V_in_SP * 0.01; % [W]
    
    P_SP(k) = P_con_SP(k) + P_sw_SP(k) + P_q_SP(k); % [W]
    
    % Totals
    
    % Conduction loss of the High-side and Low-side MOSFETs as well as the
    % inductor account for ~80% of power loss in a synchronous buck
    % converter. Therefore, a 20% margin will be added to the final power
    % loss to account for the other missing loss calculations.
    
    P_3V3(k) = P_con_H_3V3(k) + P_con_L_3V3(k) + P_sw_H_3V3(k) + P_l_dcr_3V3(k);
    P_3V3(k) = 1.2 * P_3V3(k); % 20% margin added
    P_12V(k) = P_con_H_12V(k) + P_con_L_12V(k) + P_sw_H_12V(k) + P_l_dcr_12V(k);
    P_12V(k) = 1.2 * P_12V(k);
    
    P(k) = P_3V3(k) + P_12V(k) + P_SP(k);
    
    Eff_3V3(k) = (V_out_3V3.*I_out) / (V_out_3V3 .* I_out + P_3V3(k));
    Eff_12V(k) = (V_out_12V.*I_out) / (V_out_12V .* I_out + P_12V(k));
    Eff_SP(k) = (V_out_SP.*I_out) / (V_out_SP .* I_out + P_SP(k));
    Eff(k) = (Eff_3V3(k) + Eff_12V(k) + Eff_SP(k))./3;
end

figure(1)
plot(I_out_Vec, Eff_3V3, '-');
xlabel('Output Current [A]')
ylabel('Efficiency')
title('3V3 Buck Converter Efficiency')

figure(2)
plot(I_out_Vec, Eff_12V, '-');
xlabel('Output Current [A]')
ylabel('Efficiency')
title('12V Buck Converter Efficiency')

figure(3)
plot(I_out_Vec, Eff_SP, '-');
xlabel('Output Current [A]')
ylabel('Efficiency')
title('Solar Panel Buck Converter Efficiency')

figure(4)
plot(I_out_Vec, Eff, '-');
xlabel('Output Current [A]')
ylabel('Efficiency')
title('Total Efficiency for Buck Converters')

figure(5)
plot(I_out_Vec, P);
xlabel('Output Current [A]')
ylabel('Total Power Loss [W]')
title('Output Current vs. Power Loss')
hold on

%% Reverse Recovery Loss in the Body Diode
% 
% P_diode = 0.5 * V_in * I_rr * t_rr * F_sw % [W]
% 
% %% Output Capacitance in the MOSFET
% 
% C_oss_L = C_ds_L + C_gd_L % [F]
% C_oss_H = C_ds_H + C_gd_H % [F]
% P_coss = 0.5 * (C_oss_L + C_oss_H) * V_in^2 * F_sw % [W]
% 
% %% Dead Time Loss
% 
% P_d = V_d * I_out * (t_dr + t_df) * F_sw % [W]
% 
% %% Gate Charge Loss
% 
% P_g = (Q_g_H + Q_g_L) * V_gs * F_sw % [W]
% 
% %% Operation Loss Caused by the IC Control Circuit
% 
% P_ic = V_in * I_cc % [W]
% 
% %% Conduction Loss in the Inductor
% 
% P_l_dcr = I_out^2 * DCR % [W]

%%
    %P_sw_L_3V3(k) = 0.5 * V_d * I_out * (t_r_L_3V3 + t_f_L_3V3) * F_sw; % [W]
    
    %P_ic_3V3(k) = V_in * I_cc_3V3; % [W]
    
    %P_sw_L_12V(k) = 0.5 * V_d * I_out * (t_r_L_12V + t_f_L_12V) * F_sw; % [W]
    
    %P_ic_12V(k) = V_in * I_cc_12V; % [W]
%% Total Power Loss

% P = P_on_H + P_on_L %+ P_sw_H + P_sw_L + P_diode + P_coss + P_d + P_g + P_ic + P_l_dcr
% 
% %% Efficiency
% 
% Eff = (V_out*I_out) / (V_out * I_out + P)