classdef Cp
    %Cp: stores constants and outputs Cp constants for all gases 
    %   calls look like: Cp.get("HCl")
    % OUTPUTS ARE IN J/mol-K
    % sources:
    %       https://booksite.elsevier.com/9780750683661/Appendix_C.pdf
    %       Elliott and Lira introductory chemical engineering
    %           thermodynamics
    
    properties (Constant)
        constants = containers.Map({ 'HCl' 'O2' 'H2O_v' 'H2O_l' 'CO2' 'Cl2' 'CH4' 'CO' 'H2'}, ...
            {
              [30.67 -0.0072 1.246E-05 -3.898E-09], ...                     % Elliott and Lira, eqn0
              [28.11 -3.7E-06 1.746E-05 -1.065E-08], ...                    % Elliott and Lira, eqn0
              [32.24 0.001924 1.055E-05 -3.596E-09], ...                    % Elliott and Lira, eqn0
              [72.43 0.01039 -1.497E-06 0], ...
              [19.8 0.07344 -5.602E-05 1.715E-08], ...                      % Elliott and Lira, eqn0
              [26.93 0.03384 -3.869E-05 1.547E-08], ...                     % Elliott and Lira, eqn0
              [19.25 0.05213 1.197E-05 -1.132E-08], ...
              [30.87 -0.01285 2.789E-05 -1.272E-08], ...
              [27.14 0.009274 -1.381E-05 7.645E-09]});                       % Elliott and Lira, eqn0
        formula0_names = {'HCl', 'O2', 'H2O_l', 'H2O_v', 'CO2', 'Cl2', 'CH4', 'CO', 'H2'};
        formula1_names = {'cellulose', 'lignin', 'ash'};
    end
    
    methods
        
        function calc_cp = formula0(self, consts, T)
            a = consts(1);
            b = consts(2);
            c = consts(3);
            d = consts(4);
            calc_cp = a + b*T + c*T^2 + d*T^3; % J/mol-K
        end
        
        function calc_cp = formula1(self, name, T)
           if name == "cellulose"
               fun = @(x) -0.011704 + 0.00067207.*x;
               calc_cp = fun(T) * 1000;
           elseif name == "lignin"
               fun = @(x) 0.03143 + 0.0003944.*x;
               calc_cp = fun(T) * 1000;
           elseif name == "ash"
               calc_cp = 705/1000*60.086;
           end
        end
        
        function output_cp = get(self, name, T)
            %outputs the Cp of the given gas at the specified temperature 
            if any(strcmp(self.formula0_names,name))
                consts = self.constants(name);
                output_cp = self.formula0(consts, T);
            elseif any(strcmp(self.formula1_names,name))
                output_cp = self.formula1(name, T);
            else
                output_cp = "error"; 
            end
        end
        
        function int_cp = integrate_cp(self, name, Ti, Tf)
            % integrates cp, results are in J/mol
            n = 200;
            inc = (Tf-Ti)/n;
            temps = [Ti:inc:Tf];
            Cps = zeros(1, n+1);
            for i = [1:n+1]
                temp = temps(i);
                Cps(i) = self.get(name, temp);
            end
            int_cp = trapz(temps, Cps);
        end
    end
end

