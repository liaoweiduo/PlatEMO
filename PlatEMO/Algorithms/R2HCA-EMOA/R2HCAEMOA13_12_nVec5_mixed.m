function R2HCAEMOA13_12_nVec5_mixed(Global)
% <algorithm> <R2HCAEMOA>
% A New Hypervolume-based Evolutionary Algorithm for Many-objective Optimization
% numVec = 500 Direction vector number

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
    num_vec = 500;  
    r = 13/12;

    %% Generate initial population
    Population = Global.Initialization();
    
    %% Generate direction vectors
    [W,~] = UniformVector(num_vec-Global.M, Global.M);
    W = [W;eye(Global.M)];
    
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