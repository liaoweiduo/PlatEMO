function FVEMOA(Global)
% <algorithm> <A>
% Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II
% r --- 2 --- r of reference point

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    r = Global.ParameterSet(2);
    
    %% Generate random population
    Population = Global.Initialization();

    %Vectors used in R2 for HVC approximation
    [~,FrontNo] = EnvironmentalSelection(Population,Global.N,r);
    
    %% related HV calculated 
%     evaluate_num = [];
%     rhv = [];
%     saving = 0;
%     objectiveSet = Population.objs;
%     evaluate_num(length(rhv)+1) = Global.evaluated;
%     rhv(length(rhv)+1) = HV(objectiveSet,objectiveSet);
    
    %% Optimization
    while Global.NotTermination(Population)
        
%         objectiveSet = Population.objs;
%         evaluate_num(length(rhv)+1) = Global.evaluated;
%         rhv(length(rhv)+1) = HV(objectiveSet,objectiveSet);
    
        MatingPool = TournamentSelection(2,Global.N,FrontNo);
        %Offspring  = Global.Variation(Population(MatingPool),Global.N);
        Offspring  = GA(Population(MatingPool));
        [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],Global.N,r);
        
%         if Global.evaluated > 20000 && ~saving
%             save(fullfile('Analysis','rhv.mat'),'evaluate_num','rhv');
%             saving = 1;
%         end
    end     
end