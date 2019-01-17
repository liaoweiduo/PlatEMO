function FVEMOA_DR(Global)
% <algorithm> <A>
% Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II
% y = ax2 + bx + c 
% Rfinal - Rinit = deltR 
% n = evaluation; a; b = deltR / n - na; c = Rinit; 
% deltR / n2 <= a <= - deltR / n2; 
%      tu      linear         ao;
% Rinit --- 2 --- The initial value of r
% level --- 0 --- level => [-1 : 1] map to a => [ao : tu]

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    [Rinit, level] = Global.ParameterSet(2, 1);
    if level > 1
        level = 1;
    elseif level < -1
        level = -1;
    end
        
    %% Calculation of paremeter calculating reference point position r
    H = CalH(Global.N, Global.M);
    Rfinal = 1 + 1./H;
    deltR = Rfinal - Rinit;
    n = Global.evaluation - Global.N - 1;
    % evaluated starts from N+1, first N evaluated was used to initialize N generations; 
    % total evaluation-N
    a = -1 .* level .* deltR ./ (n .* n);
    b = deltR ./ n - n .* a;
    c = Rinit;
    
    %% Generate random population
    Population = Global.Initialization();
    %Vectors used in R2 for HVC approximation
    r = CalR(a,b,c,0);
    [~,FrontNo] = EnvironmentalSelection(Population,Global.N,r);
    
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,FrontNo);
        %Offspring  = Global.Variation(Population(MatingPool),Global.N);
        Offspring  = GA(Population(MatingPool));
        r = CalR(a,b,c,Global.evaluated - Global.N - 1);
        [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],Global.N,r);
    end
end