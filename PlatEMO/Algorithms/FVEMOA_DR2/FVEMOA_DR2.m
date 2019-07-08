function FVEMOA_DR2(Global)
% <algorithm> <A>
% Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II
% Rinit --- 2 --- The initial value of r
% window --- 4000 --- The window size of evaluated
% threshold --- 0.00001 --- threshold for |b|

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    [Rinit, window, threshold] = Global.ParameterSet(2, 4000, 0.00001);
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();
    %Vectors used in R2 for HVC approximation
    nadir_list = [];        % store nadir value
    evaluate_num = [];      % nadir calculate at which evaluated num
    r_list = [];
    saving = 0;
    
    nadir = max(Population.objs);   % change to non-dominant front
    nadir_list(end + 1,:) = nadir;
    evaluate_num(end + 1) = Global.evaluated;
    r = CalR(Rinit,Rfinal,window,threshold,evaluate_num,nadir_list,Global.N);
    r_list(end + 1) = r;
    [~,FrontNo] = EnvironmentalSelection(Population,Global.N,r);
    
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,FrontNo);
        %Offspring  = Global.Variation(Population(MatingPool),Global.N);
        Offspring  = GA(Population(MatingPool));
        
        nadir = max(Population.objs);
        nadir_list(end + 1,:) = nadir;
        evaluate_num(end + 1) = Global.evaluated;
        if ~saving
            r = CalR(Rinit,Rfinal,window,threshold,evaluate_num,nadir_list,Global.N);
        end
        r_list(end + 1) = r;
        [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],Global.N,r);
        
        if r == Rfinal && ~saving
            % save nadir_list and evaluate_num and r_list
%             save(fullfile('Analysis',sprintf('%s_%s_N%d_M%d_D%d_%d_.mat',func2str(Global.algorithm),class(Global.problem),Global.N,Global.M,Global.D,Global.run)),'evaluate_num','nadir_list','r_list');
            fprintf('r change to final at %d evaluation\n', Global.evaluated);
            saving = 1;
        end
        
    end
end