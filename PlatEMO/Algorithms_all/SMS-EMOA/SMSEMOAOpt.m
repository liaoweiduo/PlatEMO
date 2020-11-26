function SMSEMOAOpt(Global)
% <algorithm> <SMSEMOA>
% S metric selection based evolutionary multiobjective optimization
% algorithm
% Rfinal = Rinit = 1 + 1 / H 

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
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    disp(['H is ', num2str(H)]);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();
    FrontNo    = NDSort(Population.objs,inf);

    %% Optimization
    while Global.NotTermination(Population)
        for i = 1 : Global.N
            drawnow();
            Offspring = GAhalf(Population(randperm(end,2)));
    % evaluated starts from N+1, first N evaluated was used to initialize N generations; 
            [Population,FrontNo] = Reduce([Population,Offspring],FrontNo,Rfinal);
        end
    end
end