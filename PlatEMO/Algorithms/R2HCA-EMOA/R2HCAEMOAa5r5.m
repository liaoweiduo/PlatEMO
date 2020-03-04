function R2HCAEMOAa5r5(Global)
% <algorithm> <R2HCAEMOA>
% A New Hypervolume-based Evolutionary Algorithm for Many-objective Optimization
% numVec --- 100 --- Direction vector number
% r --- 1.1 --- r of reference point
% mode --- 1 --- 1 random; 2 uniform with shift; 3 mixed 
% a --- 0 --- used in mode 2 only

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
    [num_vec, r, mode, a] = Global.ParameterSet(100, 2, 1, 0);

    %% Generate initial population
    Population = Global.Initialization();
    
    %% Generate direction vectors
    if mode == 1
        [W,num_vec] = UniformVector(num_vec, Global.M);
    elseif mode == 2
        [W,num_vec] = UniformPoint(num_vec, Global.M);
        W = W./repmat(sqrt(sum(W.^2, 2)),1,Global.M);
        W = (1 - a) .* W + a .* (1/sqrt(Global.M)) .* ones(1,Global.M);
        W = W./ sqrt(sum(W.^2,2));
    elseif mode == 3
        [W,~] = UniformVector(num_vec-Global.M, Global.M); 
        W = [W;eye(Global.M)];
    end
     
    %% Initialize tensor
    PopObj = Population.objs;
    fmax   = max(PopObj,[],1);
    fmin   = min(PopObj,[],1);
    PopObj  = (PopObj-repmat(fmin,size(PopObj,1),1))./repmat(fmax-fmin,size(PopObj,1),1);
    PopObj = [PopObj;zeros(1,Global.M)];
    tensor = InitializeUtilityTensor(Global,PopObj,W,r,num_vec);
    worst = Global.N+1;  
    
    %% Optimization
    while Global.NotTermination(Population)                  
        for i = 1 : Global.N
            Offspring = GAhalf(Population(randperm(end,2)));
            if worst == 1
                Population1 = [Offspring,Population];
            elseif worst == Global.N+1
                Population1 = [Population,Offspring];
            else
                Population1 = [Population(1:worst-1),Offspring,Population(worst:end)];
            end
            [Population,worst,tensor] = Reduce(Global,Population1,W,worst,tensor,r,num_vec);
        end
    end
end