function [Population,FrontNo,CrowdDis] = EnvironmentalSelection(Population,N,a)
% The environmental selection of NSGA-II

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    %% pre rotation of population
    points = Population.objs;
    [~,m] = size(points);
    rv = ones(1,m) .* (1/sqrt(m));
    pointsLength = sqrt(sum(points .^ 2,2));
    normalPoints = points ./ pointsLength;
    pdash = normalPoints + a .* rv;
    pdash = pdash ./ sqrt(sum(pdash .^ 2,2)) .* pointsLength;
    
    %% Non-dominated sorting
    [FrontNo,MaxFNo] = NDSort(pdash,Population.cons,N);
    Next = FrontNo < MaxFNo;
    
    %% Calculate the crowding distance of each solution
    CrowdDis = CrowdingDistance(pdash,FrontNo);   % using rotated objective space
    
    %% Select the solutions in the last front based on their crowding distances
    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(CrowdDis(Last),'descend');
    Next(Last(Rank(1:N-sum(Next)))) = true;
    
    %% Population for next generation
    Population = Population(Next);
    FrontNo    = FrontNo(Next);
    CrowdDis   = CrowdDis(Next);
end