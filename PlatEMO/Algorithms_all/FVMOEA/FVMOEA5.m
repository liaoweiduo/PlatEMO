function FVMOEA5(Global)
% <algorithm> <FVMOEA>
% Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II
% Rfinal = Rinit = 1 + 1 / H

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Calculation of paremeter calculating reference point position r
    R = 5;
    
    %% Generate random population
    Population = Global.Initialization();
    %Vectors used in R2 for HVC approximation
    [~,FrontNo] = EnvironmentalSelection(Population,Global.N,R);
    
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,FrontNo);
        %Offspring  = Global.Variation(Population(MatingPool),Global.N);
        Offspring  = GA(Population(MatingPool));
        [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],Global.N,R);
    end
end