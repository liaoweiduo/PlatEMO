function Score = IGDPlus(PopObj,PF)
% <metric> <min>
% Inverted generational distance plus

%------------------------------- Reference --------------------------------
% C. A. Coello Coello and N. C. Cortes, Solving multiobjective optimization
% problems using an artificial immune system, Genetic Programming and
% Evolvable Machines, 2005, 6(2): 163-190.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    
    Score = 0;
    [row,~] = size(PF);
    for i=1:row
       ref = PF(i,:);
       matrix = max(PopObj - ref,0);
       distance = sqrt(sum(matrix.^2,2));
       Score = Score + min(distance);
    end
    Score = Score/row;
    
%         Distance = pdist2(PopObj, PF, @ModifiedDistance);
%         D = min(Distance, [], 1);
%         Score = mean(D);
%         
%         function d = ModifiedDistance(z, a)
%             [M,~] = size(a);
%             d = sqrt(sum(max(a - repmat(z,M,1), 0).^2,2));
%         end
end