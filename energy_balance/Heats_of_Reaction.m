%% Heat of reaction for cellulose
% define a basis of 1 mol of cellulose

% reactants
n_cellulose = 1; % mol
n_H2O = 1; % mol
% products
n_CO = 6; % mol
n_H2 = 6; % mol

T = 1450 + 273.15; % K
T_std = 25 + 273.15; %K
T_100C = 100 + 273.15; %K

% enthalpies of reaction 
H_r_cellulose = 601472; %J/mol cellulose
H_cond_H2O = -40650; %J/mol
deltaH = 0; % the running total for the heat of reaction
% 1450 degC -> 25 degC
deltaH = deltaH + n_cellulose*Cp().integrate_cp("cellulose", T, T_std);
deltaH = deltaH + n_H2O*Cp().integrate_cp("H2O_v", T, T_100C);
deltaH = deltaH + n_H2O*H_cond_H2O;
deltaH = deltaH + n_H2O*Cp().integrate_cp("H2O_l", T_100C, T_std);

deltaH = deltaH + n_cellulose*H_r_cellulose;

deltaH = deltaH + n_CO*Cp().integrate_cp("CO", T_std, T);
deltaH = deltaH + n_H2*Cp().integrate_cp("H2", T_std, T);
H_r_cellulose_1450C = deltaH

%% Heat of reaction for lignin
% define a basis of 1 mol of lignin

% reactants
n_lignin = 1; % mol
n_H2O = 7; % mol
% products
n_CO = 10; % mol
n_H2 = 13; % mol

T = 1450 + 273.15; % K
T_std = 25 + 273.15; %K
T_100C = 100 + 273.15; %K

% enthalpies of reaction 
H_r_lignin = 2729333; %J/mol cellulose
H_cond_H2O = -40650; %J/mol
deltaH = 0; % the running total for the heat of reaction
% 1450 degC -> 25 degC
deltaH = deltaH + n_lignin*Cp().integrate_cp("lignin", T, T_std);
deltaH = deltaH + n_H2O*Cp().integrate_cp("H2O_v", T, T_100C);
deltaH = deltaH + n_H2O*H_cond_H2O;
deltaH = deltaH + n_H2O*Cp().integrate_cp("H2O_l", T_100C, T_std);

deltaH = deltaH + n_lignin*H_r_lignin;

deltaH = deltaH + n_CO*Cp().integrate_cp("CO", T_std, T);
deltaH = deltaH + n_H2*Cp().integrate_cp("H2", T_std, T);
H_r_lignin_1450C = deltaH
%% Heat of reaction for methane 
% define a basis of 1 mol of methane

% reactants
n_methane = 1; % mol
n_H2O = 1; % mol
% products
n_CO = 1; % mol
n_H2 = 3; % mol

T = 1450 + 273.15; % K
T_std = 25 + 273.15; %K
T_100C = 100 + 273.15; %K

% enthalpies of reaction 
H_r_methane = 250150; %J/mol cellulose
H_cond_H2O = -40650; %J/mol
deltaH = 0; % the running total for the heat of reaction
% 1450 degC -> 25 degC
deltaH = deltaH + n_methane*Cp().integrate_cp("CH4", T, T_std);
deltaH = deltaH + n_H2O*Cp().integrate_cp("H2O_v", T, T_100C);
deltaH = deltaH + n_H2O*H_cond_H2O;
deltaH = deltaH + n_H2O*Cp().integrate_cp("H2O_l", T_100C, T_std);

deltaH = deltaH + n_methane*H_r_methane;

deltaH = deltaH + n_CO*Cp().integrate_cp("CO", T_std, T);
deltaH = deltaH + n_H2*Cp().integrate_cp("H2", T_std, T);
H_r_methane_1450C = deltaH

%% final mass balances
n_biomass = 1910.4059; % mol/min
n_methane = 4.495 * n_biomass; % mol/min
n_water = 6.186 * n_biomass; % mol/min
n_cellulose = n_biomass * 0.56233792; % mol/min
n_lignin = n_biomass * 0.16124406; % mol/min
n_ash = n_biomass * 0.19521254; % mol/min

deltaH = 0;
% energy required to raise temperature of reactants
deltaH = deltaH + n_ash*Cp().integrate_cp("ash", T_std, T);
deltaH = deltaH + n_methane*Cp().integrate_cp("CH4", T_std, T);
deltaH = deltaH + n_cellulose*Cp().integrate_cp("cellulose", T_std, T);
deltaH = deltaH + n_lignin*Cp().integrate_cp("lignin", T_std, T);
% energy required to support reactions
deltaH = deltaH + n_methane * H_r_methane_1450C;
deltaH = deltaH + n_cellulose * H_r_cellulose_1450C;
deltaH = deltaH + n_lignin * H_r_lignin_1450C;

deltaH;
