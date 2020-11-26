function [Population,FrontNo] = Reduce4v3(Population,FrontNo,r)
% more than one front, random solution front non-last front is removed
% only one front, standard SMS-EMOA is used

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
    
    if max(FrontNo) ~= 1
        % more than one front, random solution from non-first front 
        % is removed
        Front               = find(FrontNo ~= 1);
        rmi                 = randi([1, size(Front,2)],1,1);
        FrontNo(Front(rmi)) = [];
        Population(Front(rmi)) = [];
    else
        % all non-dominated, standard SMS-EMOA
        % Calculate the contribution of hypervolume of each solution
        deltaS = inf(1,N);
        ref = r*(max(PopObj,[],1)-min(PopObj,[],1))+min(PopObj,[],1);
        if N > 1
            deltaS = CalHVC(PopObj,ref,N);
        end

        % Delete the worst solution from the last front
        [~,worst] = min(deltaS);
        FrontNo   = UpdateFront(Population.objs,FrontNo,worst);
        Population(worst) = [];
    end
end