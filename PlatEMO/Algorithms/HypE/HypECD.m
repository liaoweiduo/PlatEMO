function HypECD(Global)
% <algorithm> <HypE>
% Hypervolume estimation algorithm
% nSample --- 10000 --- Number of sampled points for HV estimation
% Rinit --- 2 --- The initial value of r
% window --- 4000 --- The window size of evaluated
% threshold --- 0.00001 --- threshold for |b|

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    [nSample, Rinit, window, threshold] = Global.ParameterSet(10000, 2, 4000, 0.00001);
    
    %% Calculation of paremeter calculating reference point position Rfinal
    H = getH(Global.M, Global.N);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();

    %% Optimization
    nadir_list = [];        % store nadir value
    evaluate_num = [];      % nadir calculate at which evaluated num
    r_list = [];
    saving = 0;
    while Global.NotTermination(Population)
        % Reference point for hypervolume calculation
        
        FrontNo    = NDSort(Population.objs,inf);
        firstFront = find(FrontNo==min(FrontNo));
        PopObj    = Population(firstFront).objs;
        
        nadir = max(PopObj);
        nadir_list(end + 1,:) = nadir;
        evaluate_num(end + 1) = Global.evaluated;
        r = CalR(Rinit,Rfinal,window,threshold,evaluate_num,nadir_list,Global.N);
        r_list(end + 1) = r;
        PopObj = Population.objs;
        RefPoint = r*(max(PopObj,[],1)-min(PopObj,[],1))+min(PopObj,[],1);
        MatingPool = TournamentSelection(2,Global.N,-CalHV(Population.objs,RefPoint,Global.N,nSample));
        Offspring  = GA(Population(MatingPool));    
        Population = EnvironmentalSelection([Population,Offspring],Global.N,RefPoint,nSample);
        
        if r == Rfinal && ~saving
            % save nadir_list and evaluate_num and r_list
%             save(fullfile('Analysis',sprintf('%s_%s_N%d_M%d_D%d_%d_.mat',func2str(Global.algorithm),class(Global.problem),Global.N,Global.M,Global.D,Global.run)),'evaluate_num','nadir_list','r_list');
            fprintf('r change to final at %d evaluation\n', Global.evaluated);
            saving = 1;
        end
    end
   
end