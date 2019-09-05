function [Population,FrontNo] = Reduce_scaling(Population,FrontNo,r,c)
% Delete one solution from the population
% first scale the population to f1+f2+...+fm = 1.

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Identify the solutions in the last front
    FrontNo   = UpdateFront(Population.objs,FrontNo);
    LastFront = find(FrontNo==max(FrontNo));
    PopObj    = Population(LastFront).objs; 
    [N,M]     = size(PopObj);
    
    %% first normalize, then translate the PopObj[N,M] along 45 degree to f1+f2+...+fM = 1 
    if N > M   % more than M solutions considered
        maxValues = max(PopObj,[],1); 
        minValues = min(PopObj,[],1); 
        PopObj = (PopObj - minValues) ./ (maxValues - minValues); 
        a = (1 - sum(PopObj,2)) ./ M;
        PopObj = PopObj + c * a; 
%         print(max(sum(PopObj,2)));
    end
    
    %% Calculate the contribution of hypervolume of each solution
    deltaS = inf(1,N);
    ref = r*(max(PopObj,[],1)-min(PopObj,[],1))+min(PopObj,[],1);
%     if M == 2
%         [~,rank] = sortrows(PopObj);
%         deltaS(rank(1)) = (PopObj(rank(2),1)-PopObj(rank(1),1)) * (ref(2)             -PopObj(rank(1),2));
%         deltaS(rank(N)) = (ref(1)           -PopObj(rank(N),1)) * (PopObj(rank(N-1),2)-PopObj(rank(N),2));
%         for i = 2 : N-1
%             deltaS(rank(i)) = (PopObj(rank(i+1),1)-PopObj(rank(i),1)).*(PopObj(rank(i-1),2)-PopObj(rank(i),2));
%         end
    if N > 1
        deltaS = CalHVC(PopObj,ref,N);
    end
    
    %% Delete the worst solution from the last front
    [~,worst] = min(deltaS);
    FrontNo   = UpdateFront(Population.objs,FrontNo,LastFront(worst));
    Population(LastFront(worst)) = [];
end