function [Population,FrontNo] = EnvironmentalSelection(Population,N)
% The environmental selection of NSGA-II

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Non-dominated sorting
    [FrontNo,MaxFNo] = NDSort(Population.objs,Population.cons,N);
    Next = FrontNo < MaxFNo;
    
    %% Calculate the crowding distance of each solution
    Last     = FrontNo==MaxFNo;
    LastPopulation = CalHVC(Population(Last),2,N-sum(Next));   % 10 origin
    LastFrontNo = MaxFNo*ones(1,N-sum(Next)); 
    
    %% Population for next generation
    Population = [Population(Next),LastPopulation];
    FrontNo    = [FrontNo(Next),LastFrontNo];

end