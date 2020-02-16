function R2HCAEMOALD(Global)
% <algorithm> <R2HCAEMOA>
% A New Hypervolume-based Evolutionary Algorithm for Many-objective Optimization
% numVec --- 100 --- Direction vector number
% Rinit --- 1.1 --- r of reference point

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
    [num_vec, Rinit] = Global.ParameterSet(100, 2);

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
            
        for i = 1 : Global.N
            Offspring = GAhalf(Population(randperm(end,2)));
            if worst == 1
                Population1 = [Offspring,Population];
            elseif worst == Global.N+1
                Population1 = [Population,Offspring];
            else
                Population1 = [Population(1:worst-1),Offspring,Population(worst:end)];
            end
            [Population,worst,tensor] = Reduce(Global,Population1,W,worst,tensor,R,num_vec);
        end
    end
end