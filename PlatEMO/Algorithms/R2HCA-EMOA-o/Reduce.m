function [Population,FrontNo] = Reduce(Population,FrontNo,r,W,num_vec)
% Delete one solution from the population

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    
    %% normalization
    PopObj_t = Population.objs;
    fmax     = max(PopObj_t,[],1);
    fmin     = min(PopObj_t,[],1);
    PopObj_t   = (PopObj_t-repmat(fmin,size(PopObj_t,1),1))./repmat(fmax-fmin,size(PopObj_t,1),1);
    
    %% Identify the solutions in the last front
    FrontNo   = UpdateFront(PopObj_t,FrontNo);
    LastFront = find(FrontNo==max(FrontNo));
    PopObj    = PopObj_t(LastFront,:);
    [N,M]     = size(PopObj);
    
    %% Calculate the contribution of hypervolume of each solution
    deltaS = inf(1,N);
    if N > 1
        deltaS = CalR22(PopObj,W,r);
    end
    
    %% Delete the worst solution from the last front
    [~,worst] = min(deltaS);
    FrontNo   = UpdateFront(Population.objs,FrontNo,LastFront(worst));
    Population(LastFront(worst)) = [];
end