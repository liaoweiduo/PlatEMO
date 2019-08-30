function SMSEMOA_SS2(Global)
% <algorithm> <A>
% S metric selection based evolutionary multiobjective optimization
% algorithm
% half evaluations using scaling method before calculating HV.
% r --- 1.1 --- r of reference point

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
    r = Global.ParameterSet(1.1);
    
    %% Generate random population
    Population = Global.Initialization();
    FrontNo    = NDSort(Population.objs,inf);

    %% Optimization
    while Global.NotTermination(Population)
        for i = 1 : Global.N
            drawnow();
            Offspring = GAhalf(Population(randperm(end,2)));
            if Global.evaluated <= Global.evaluation / 3 * 2
                [Population,FrontNo] = Reduce([Population,Offspring],FrontNo,r);
            else
                [Population,FrontNo] = Reduce_scaling([Population,Offspring],FrontNo,r);
            end
        end
    end
end