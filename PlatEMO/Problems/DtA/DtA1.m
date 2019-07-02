classdef DtA1 < PROBLEM
% <problem> <DtA>
% a difficult-to-approximate (DtA) PF boundaries problem.
% f1(x1, x2) = |x2 −0.5−(x1 − 0.5)cos(20πx1)| + x1, 
% f2(x1, x2) = |x2 −0.5−(x1 − 0.5)cos(20πx1)| + 1 − x1, 
% where x1, x2 ∈ [0, 1].

%------------------------------- Reference --------------------------------
% Wang, Z., Ong, Y. S., Sun, J., Gupta, A., & Zhang, Q. (2018). A generator
% for multiobjective test problems with difficult-to-approximate Pareto 
% front boundaries. IEEE Transactions on Evolutionary Computation.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function obj = DtA1()
            obj.Global.M        = 2;
            obj.Global.D        = 2;
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D);
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            x1     = PopDec(:,1);
            x2     = PopDec(:,2);
            f1 = abs(x2 - 0.5 - (x1 - 0.5) .* cos(20 .* pi .* x1)) + x1;
            f2 = abs(x2 - 0.5 - (x1 - 0.5) .* cos(20 .* pi .* x1)) + 1 - x1;
            PopObj = [f1,f2];
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P = UniformPoint(N,obj.Global.M);
        end
    end
end