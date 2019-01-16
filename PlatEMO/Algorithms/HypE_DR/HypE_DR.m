function HypE_DR(Global)
% <algorithm> <A>
% Hypervolume estimation algorithm
% y = ax2 + bx + c 
% Rfinal - Rinit = deltR 
% n = evaluation; a; b = deltR / n - na; c = Rinit; 
% deltR / n2 <= a <= - deltR / n2; 
%      tu      linear         ao;
% nSample --- 10000 --- Number of sampled points for HV estimation
% Rinit --- 2 --- The initial value of r
% level --- 0 --- level => [-1 : 1] map to a => [ao : tu]

%------------------------------- Reference --------------------------------
% J. Bader and E. Zitzler, HypE: An algorithm for fast hypervolume-based
% many-objective optimization, Evolutionary Computation, 2011, 19(1):
% 45-76.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    [nSample, Rinit, level] = Global.ParameterSet(10000, 2, 1);
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

    %% Optimization
    while Global.NotTermination(Population)
        % Reference point for hypervolume calculation
        r = CalR(a,b,c,Global.evaluated - Global.N - 1);
        RefPoint = zeros(1,Global.M) + max(Population.objs)*r;
        MatingPool = TournamentSelection(2,Global.N,-CalHV(Population.objs,RefPoint,Global.N,nSample));
        Offspring  = GA(Population(MatingPool));    
        Population = EnvironmentalSelection([Population,Offspring],Global.N,RefPoint,nSample);
    end
end