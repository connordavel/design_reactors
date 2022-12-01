classdef k
    % OUTPUTS are in W/(m*K)
    % sources:
    %       https://booksite.elsevier.com/9780750683661/Appendix_C.pdf
    
    properties (Constant)
        constants = containers.Map({'HCl' 'O2' 'H2O_v' 'CO2' 'Cl2' 'CH4' 'CO' 'H2'}, ...
            {                
              [0.00119 4.4775E-05 2.0997E-10], ...    % Apendix C, eqn0                
              [0.00121 8.6157E-05 -1.3346E-08], ...    % Apendix C, eqn0 
              [0.00053 4.7093E-05 4.9551E-08], ...   % Apendix C, eqn0               
              [-0.01200 1.0208E-04 -2.2403E-08], ...    % Apendix C, eqn0                  
              [-0.00194 3.8300E-05 -6.3523E-09], ... % Apendix C, eqn0 
              [-0.00935 1.4028E-04 3.3180E-08], ... % Apendix C, eqn0 
              [0.00158 8.2511E-05 -1.9081E-08], ... % Apendix C, eqn0 
              [0.03951 4.5918E-04 -6.4933E-08] });     % Apendix C, eqn0   

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


