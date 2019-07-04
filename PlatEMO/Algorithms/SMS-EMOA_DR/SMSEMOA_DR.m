function SMSEMOA_DR(Global)
% <algorithm> <A>
% S metric selection based evolutionary multiobjective optimization
% algorithm
% y = ax2 + bx + c 
% Rfinal - Rinit = deltR 
% n = evaluation; a; b = deltR / n - na; c = Rinit; 
% deltR / n2 <= a <= - deltR / n2; 
%      tu      linear         ao;
% Rinit --- 10 --- The initial value of r
% level --- 0 --- level => [-1 : 1] map to a => [ao : tu]

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
    [Rinit, level] = Global.ParameterSet(10, 1);
    if level > 1
        level = 1;
    elseif level < -1
        level = -1;
    end
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
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
    FrontNo    = NDSort(Population.objs,inf);

    %% Optimization
    while Global.NotTermination(Population)
        for i = 1 : Global.N
            drawnow();
            Offspring = GAhalf(Population(randperm(end,2)));
            r = CalR(a,b,c,Global.evaluated - Global.N - 1);
    % evaluated starts from N+1, first N evaluated was used to initialize N generations; 
            [Population,FrontNo] = Reduce([Population,Offspring],FrontNo,r);
        end
    end
end