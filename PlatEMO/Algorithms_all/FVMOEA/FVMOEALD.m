function FVMOEALD(Global)
% <algorithm> <FVMOEA>
% Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II
% Rfinal = 1 + 1 / H
% one third linearly decrease to 1+1/H at two third
% Rinit --- 2 --- The initial value of r

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    Rinit = Global.ParameterSet(2);
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    disp(['H is ', num2str(H)]);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();
    %Vectors used in R2 for HVC approximation
    [~,FrontNo] = EnvironmentalSelection(Population,Global.N,Rinit);
    
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
            
        MatingPool = TournamentSelection(2,Global.N,FrontNo);
        %Offspring  = Global.Variation(Population(MatingPool),Global.N);
        Offspring  = GA(Population(MatingPool));
        [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],Global.N,R);
    end
end