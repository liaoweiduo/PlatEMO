function R2HCAEMOAo(Global)
% <algorithm> <R2HCAEMOA>
% R2HCA-EMOA the origin version
% numVec --- 100 --- Direction vector number
% r --- 1.1 --- r of reference point
% mode --- 1 --- 1 random; 2 uniform; 3 mixed

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
%% Paremeter settings
    [num_vec, r, mode] = Global.ParameterSet(100, 1.1, 1);

    %% Generate direction vectors
    if mode == 1
        [W,num_vec] = UniformVector(num_vec, Global.M);
    elseif mode == 2
        [W,num_vec] = UniformPoint(num_vec, Global.M);
        W = W./repmat(sqrt(sum(W.^2,2)),1,Global.M);
    else
        [W,~] = UniformVector(num_vec-Global.M, Global.M);
        W = [W;eye(Global.M)];
    end
    
    %% Generate random population
    Population = Global.Initialization();
    FrontNo    = NDSort(Population.objs,inf);

    %% Optimization
    while Global.NotTermination(Population)
        for i = 1 : Global.N
            %% Re generate direction vectors
%             if mode == 1
%                 [W,num_vec] = UniformVector(num_vec, Global.M);
%             elseif mode == 2
%                 [W,num_vec] = UniformPoint(num_vec, Global.M);
%                 W = W./repmat(sqrt(sum(W.^2,2)),1,Global.M);
%             else
%                 [W,~] = UniformVector(num_vec-Global.M, Global.M);
%                 W = [W;eye(Global.M)];
%             end
    
            drawnow();
            Offspring = GAhalf(Population(randperm(end,2)));
            [Population,FrontNo] = Reduce([Population,Offspring],FrontNo,r,W,num_vec);
        end
    end
end