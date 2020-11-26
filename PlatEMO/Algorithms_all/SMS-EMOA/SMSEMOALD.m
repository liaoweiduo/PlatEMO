function SMSEMOALD(Global)
% <algorithm> <SMSEMOA>
% S metric selection based evolutionary multiobjective optimization
% algorithm
% linearly decrease
% Rinit --- 2 --- The initial value of r

%------------------------------- Reference --------------------------------
% M. Emmerich, N. Beume, and B. Naujoks, An EMO algorithm using the
% hypervolume measure as selection criterion, Proceedings of the
% International Conference on Evolutionary Multi-Criterion Optimization,
% 2005, 62-76.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    Rinit = Global.ParameterSet(2);
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();
    FrontNo    = NDSort(Population.objs,inf);

    %% Optimization
    while Global.NotTermination(Population)
        
%         if Global.evaluated <= Global.evaluation / 3
%             R = Rinit;
%         elseif Global.evaluated > Global.evaluation * 2 / 3
%             R = Rfinal;
%         else
%             T = Global.evaluation / 3;
%             t = Global.evaluated - Global.evaluation / 3 ;
%             R = Rinit * (T - t) / T + Rfinal * t / T;
%         end
        
        T = Global.evaluation; 
        t = Global.evaluated; 
        R = Rinit * (T - t) / T + Rfinal * t / T; 
            
        for i = 1 : Global.N
            drawnow();
            Offspring = GAhalf(Population(randperm(end,2)));
    % evaluated starts from N+1, first N evaluated was used to initialize N generations; 
            [Population,FrontNo] = Reduce([Population,Offspring],FrontNo,R);
            
        end
    end
end