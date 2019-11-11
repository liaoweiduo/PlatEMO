classdef OMZMConcave < PROBLEM
% <problem> <Combinatorial MOP>
% The round one-max zero-max problem
% G1 --- 1 --- round on first objective
% G2 --- 1 --- round on second objective

%------------------------------- Reference --------------------------------
% E. Zitzler and L. Thiele, Multiobjective evolutionary algorithms: A
% comparative case study and the strength Pareto approach, IEEE
% Transactions on Evolutionary Computation, 1999, 3(4): 257-271.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
properties(Access = private)
        G1 = 1;
        G2 = 1;
    end
    methods
        %% Initialization
        function obj = OMZMConcave()
            % Parameter setting
            [obj.G1, obj.G2] = obj.Global.ParameterSet(1, 1);
            obj.Global.M = 2;
            
            if isempty(obj.Global.D)
                obj.Global.D = 500;
            end
            obj.Global.encoding = 'binary';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            f = [sum(PopDec,2)./obj.Global.D,(obj.Global.D-sum(PopDec,2))./obj.Global.D];
            PopObj = ceil(f.^2 .* obj.Global.D ./ [obj.G1,obj.G2]) .* [obj.G1,obj.G2]./obj.Global.D;
        end
        %% A reference point for hypervolume calculation
        function P = PF(obj,N)
            P = [(0:1/(N-1):1)',(1:-1/(N-1):0)'];
        end
    end
end