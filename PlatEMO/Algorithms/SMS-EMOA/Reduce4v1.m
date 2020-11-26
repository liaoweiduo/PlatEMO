function [Population,FrontNo,n_del] = Reduce4v1(Population,FrontNo,r)
% Delete all the dominated solutions from the population
% Only solutions on the first front remain
% (if only one solution in first front, the two first fronts remain)
% report the number of deleted solutions as n
% if only one front, use standard SMS-EMOA

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Identify the solutions in the first front
    PopObj    = Population.objs;
    [N,M]     = size(PopObj);
    
    if sum(FrontNo == 1) == 1   
        % only one solution, find 2 front
        FrontNo   = NDSort(PopObj,2);
    elseif max(FrontNo) == 1
        % all non-dominated, standard SMS-EMOA
        % Calculate the contribution of hypervolume of each solution
        deltaS = inf(1,N);
        ref = r*(max(PopObj,[],1)-min(PopObj,[],1))+min(PopObj,[],1);
        if N > 1
            deltaS = CalHVC(PopObj,ref,N);
        end

        % mark the worst solution as inf in FrontNo
        [~,worst] = min(deltaS);
        FrontNo(worst) = inf;
    end
    Population(FrontNo == inf) = [];
    FrontNo = FrontNo(FrontNo ~= inf);
    n_del = N - size(Population.objs, 1);
end