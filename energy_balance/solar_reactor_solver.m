% Part B sollution
clear 
clc
clear figure
%% Initial Calculations on flow rate and volume
tau = 1.0; % sec
R = 8.314462618; % L*kP/K/mol, J/K/mol
P_T = 3500; % kPa 35bar -> constant throughout 
%% X Domain: Length of a single tube
L_F = 10; % length of tubes, in meters
L_domain = [0 L_F]; 
n = 1000; % number of tubes
D =  0.5; % diameter of a single tube, m
T0 = 298.15; % initial temperature (K)
T_c = 298.15; %K
T_w = 1450; %K
%% Initial conditions
F_C = 2039.166/n; %kmol/hr 
F_H2O = 2529.721/n; %kmol/hr 
F_CO = 211.9349/n; %kmol/hr 
F_CO2 = 0.095593/n; %kmol/hr 
F_H2 = 34950.35/n; %kmol/hr 
F_CH4 = 1838.185/n; %kmol/hr 
F_ash = 79.83018/n; %kmol/hr 
F_S = 0.170378/n; %kmol/hr 
F_H2S = 0/n; %kmol/hr 
F_Cl2 = 4.622897/n; %kmol/hr 
F_HCl = 0/n; %kmol/hr 
F_CH4OH = 396.9281/n; %kmol/hr
F_N2 = 227.9021/n; %kmol/hr
P_T = P_T;             %kPa
T_g = T0;              %K
tube_diameter = D;     % m

IC =   [F_C ...
        F_H2O ...
        F_CO ...
        F_CO2 ...
        F_H2 ...
        F_CH4 ...
        F_ash ...
        F_S ...
        F_H2S ...
        F_Cl2 ...
        F_HCl ...
        F_CH4OH ...
        F_N2 ...
        P_T ...
        T_g ...
        tube_diameter ...
        F_C ...
        F_CH4 ...
        T_c ...
        T_w ...
        L_F];
%% Solve ODE
opts = odeset ('AbsTol', 0.0001, 'RelTol', 0.0001); 
[L, Ysol] = ode45('ode', L_domain, IC, opts);
%% Data handling 
F_C = Ysol(:,1); 
F_H2O = Ysol(:,2); 
F_CO = Ysol(:,3);  
F_CO2 = Ysol(:,4); 
F_H2 = Ysol(:,5); 
F_CH4 = Ysol(:,6); 
F_ash = Ysol(:,7); 
F_S = Ysol(:,8); 
F_H2S = Ysol(:,9); 
F_Cl2 = Ysol(:,10); 
F_HCl = Ysol(:,11); 
F_CH4OH = Ysol(:,12); 
F_N2 = Ysol(:,13); 
P_T = Ysol(:,14); 
T_g = Ysol(:,15); 
tube_diameter = Ysol(:,16); 
F_C = Ysol(:,17); 
F_CH4 = Ysol(:,18);
T_c = Ysol(:,19); 
T_w = Ysol(:,20); 
L_F = Ysol(:,21); 
%% Plotting 
fig1 = figure(1);
hold on
grid on
set(fig1, 'Name', '');
width = 1;
plot(L, F_C,'LineWidth',width );
plot(L, F_CH4,'LineWidth',width );
plot(L, F_H2O,'LineWidth',width );
plot(L, F_CO,'LineWidth',width );
plot(L, F_H2,'LineWidth',width );
plot(L, F_CO2,'LineWidth',width );
hold off
legend('C', 'CH4', 'H2O', 'CO', 'H2', 'CO2');
xlabel('Reactor Tube length (m)');
ylabel('Flow Rate (kmol/hr)');

fig2 = figure(2);
hold on
grid on
set(fig2, 'Name', '');
width = 1;
plot(L, T_g,'LineWidth',width );
plot(L, T_c,'LineWidth',width );
plot(L, T_w,'LineWidth',width );
hold off
legend('gas T', 'particle T', 'wall T');
xlabel('Reactor Tube length (m)');
ylabel('Temperature (K)');