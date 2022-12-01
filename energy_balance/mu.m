classdef mu
    %mu: stores constants and outputs viscosity for gases
    %   calls look like: viscosity.get("HCl")
    %   OUTPUTS ARE IN micro-Poise 
    % sources:
    %       https://booksite.elsevier.com/9780750683661/Appendix_C.pdf
    
    properties (Constant)
        constants = containers.Map({'HCl' 'O2' 'H2O_v' 'CO2' 'Cl2' 'CH4' 'CO' 'H2'}, ...
            {                
              [-9.118 5.5500E-01 -1.1100E-04], ...    % Apendix C, eqn0                
              [44.224 5.6200E-01 -1.1300E-04], ...    % Apendix C, eqn0 
              [-36.826 4.2900E-01 -1.6200E-05], ...   % Apendix C, eqn0               
              [11.811 4.9838E-01 -1.0851E-04], ...    % Apendix C, eqn0                  
              [-3.571 4.8700E-01 -8.5300E-05], ...
              [3.844 4.0112E-01 -1.4303E-04], ...
              [23.811 5.3944E-01 -1.5411E-04], ...
              [27.758 2.1200E-01 -3.2800E-05] });      

    end
    
    methods
        
        function calc_cp = formula0(self, consts, T)
            a = consts(1);
            b = consts(2);
            c = consts(3);
            calc_cp = a + b*T + c*T^2; % micro-P
        end

        function output_cp = get(self, name, T)
            %outputs the Cp of the given gas at the specified temperature 
            consts = self.constants(name);
            output_cp = self.formula0(consts, T);
        end
    end
end

