function SMSEMOA_DR2(Global)
% <algorithm> <A>
% S metric selection based evolutionary multiobjective optimization
% algorithm
% Rinit --- 10 --- The initial value of r
% window --- 4000 --- The window size of evaluated
% threshold --- 0.00001 --- threshold for |b|

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
    [Rinit, window, threshold] = Global.ParameterSet(10, 4000, 0.00001);
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();
    FrontNo    = NDSort(Population.objs,inf);

    %% Optimization
    nadir_list = [];        % store nadir value
    evaluate_num = [];      % nadir calculate at which evaluated num
    r_list = [];
    saving = 0;
    while Global.NotTermination(Population)
    
        FrontNo    = NDSort(Population.objs,inf);
        firstFront = find(FrontNo==min(FrontNo));
        PopObj    = Population(firstFront).objs;
    
        nadir = max(PopObj.objs);
        nadir_list(end + 1,:) = nadir;
        evaluate_num(end + 1) = Global.evaluated;
        if ~saving
            r = CalR(Rinit,Rfinal,window,threshold,evaluate_num,nadir_list,Global.N);
        end
        r_list(end + 1) = r;
            
        for i = 1 : Global.N
            drawnow();
            Offspring = GAhalf(Population(randperm(end,2)));
    % evaluated starts from N+1, first N evaluated was used to initialize N generations; 
            [Population,FrontNo] = Reduce([Population,Offspring],FrontNo,r);
            
            if r == Rfinal && ~saving
                % save nadir_list and evaluate_num and r_list
%                 save(fullfile('Analysis',sprintf('%s_%s_N%d_M%d_D%d_%d_.mat',func2str(Global.algorithm),class(Global.problem),Global.N,Global.M,Global.D,Global.run)),'evaluate_num','nadir_list','r_list');
                fprintf('r change to final at %d evaluation\n', Global.evaluated);
                saving = 1;
            end

        end
    end
end