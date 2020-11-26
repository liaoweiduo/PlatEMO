function R2HCAEMOACD(Global)
% <algorithm> <R2HCAEMOA>
% A New Hypervolume-based Evolutionary Algorithm for Many-objective Optimization
% numVec --- 100 --- Direction vector number
% Rinit --- 1.1 --- r of reference point
% window --- 4000 --- The window size of evaluated
% threshold --- 0.00001 --- threshold for |b|

%--------------------------------------------------------------------------
% Author: Ke Shang
% Version: 0.1
% The paper has been submitted to TEVC.
% The code uses PlatEMO published in "Ye Tian, Ran Cheng, Xingyi Zhang, 
% and Yaochu Jin, PlatEMO: A MATLAB Platform for Evolutionary 
% Multi-Objective Optimization [Educational Forum], IEEE Computational 
% Intelligence Magazine, 2017, 12(4): 73-87".
%-------------------------------------------------------------------------- 

    %% Paremeter settings
    [num_vec, Rinit, window, threshold] = Global.ParameterSet(100, 2, 4000, 0.00001);

    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    Rfinal = 1 + 1./H;
    
    %% Generate initial population
    Population = Global.Initialization();
    
    %% Generate direction vectors
    [W,num_vec] = UniformVector(num_vec, Global.M);
    
    %% Initialize tensor
    PopObj = Population.objs;
    fmax   = max(PopObj,[],1);
    fmin   = min(PopObj,[],1);
    PopObj  = (PopObj-repmat(fmin,size(PopObj,1),1))./repmat(fmax-fmin,size(PopObj,1),1);
    PopObj = [PopObj;zeros(1,Global.M)];
    tensor = InitializeUtilityTensor(Global,PopObj,W,Rinit,num_vec);
    worst = Global.N+1;  
    
    %% Optimization
    nadir_list = [];        % store nadir value
    evaluate_num = [];      % nadir calculate at which evaluated num
    r_list = [];
    saving = 0;
    while Global.NotTermination(Population)           
        
        FrontNo    = NDSort(Population.objs,inf);
        firstFront = find(FrontNo==min(FrontNo));
        PopObj    = Population(firstFront).objs;
        
        nadir = max(PopObj);
        nadir_list(end + 1,:) = nadir;
        evaluate_num(end + 1) = Global.evaluated;
        if ~saving
            r = CalR(Rinit,Rfinal,window,threshold,evaluate_num,nadir_list,Global.N);
        end
        r_list(end + 1) = r;
            
        for i = 1 : Global.N
            Offspring = GAhalf(Population(randperm(end,2)));
            if worst == 1
                Population1 = [Offspring,Population];
            elseif worst == Global.N+1
                Population1 = [Population,Offspring];
            else
                Population1 = [Population(1:worst-1),Offspring,Population(worst:end)];
            end
            [Population,worst,tensor] = Reduce(Global,Population1,W,worst,tensor, r, num_vec);
        end
        
        if r == Rfinal && ~saving
            % save nadir_list and evaluate_num and r_list
%             save(fullfile('Analysis',sprintf('%s_%s_N%d_M%d_D%d_%d_.mat',func2str(Global.algorithm),class(Global.problem),Global.N,Global.M,Global.D,Global.run)),'evaluate_num','nadir_list','r_list');
            fprintf('r change to final at %d evaluation\n', Global.evaluated);
            saving = 1;
        end
    end
end