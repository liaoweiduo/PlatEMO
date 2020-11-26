function [Population,FrontNo] = Reduce4v2(Population,FrontNo,r)
% more than one front, random solution front last front is removed
% only one front, standard SMS-EMOA is used

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Identify the solutions in the last front
    LastFront = find(FrontNo==max(FrontNo));
    PopObj    = Population(LastFront).objs;
    [N,M]     = size(PopObj);
    
    if max(FrontNo) ~= 1
        % more than one front, random solution front last front is removed
        rmi = randi([1,N],1,1);
        FrontNo   = UpdateFront(Population.objs,FrontNo,LastFront(rmi));
        Population(LastFront(rmi)) = [];
    else
        % Calculate the contribution of hypervolume of each solution
        deltaS = inf(1,N);
        ref = r*(max(PopObj,[],1)-min(PopObj,[],1))+min(PopObj,[],1);
        if N > 1
            deltaS = CalHVC(PopObj,ref,N);
        end

        % Delete the worst solution from the last front
        [~,worst] = min(deltaS);
        FrontNo   = UpdateFront(Population.objs,FrontNo,LastFront(worst));
        Population(LastFront(worst)) = [];
    end
end