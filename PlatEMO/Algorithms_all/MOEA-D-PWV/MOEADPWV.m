function MOEADPWV(Global)
% <algorithm> <M>
% Multiobjective evolutionary algorithm based on decomposition
% refObj --- 1 --- discrete on which objective
% start  --- 0 --- reference point from
% stop   --- 1 --- reference point to
% theta  --- 5 --- PBI theta

%------------------------------- Reference --------------------------------
% Q. Zhang and H. Li, MOEA/D: A multiobjective evolutionary algorithm based
% on decomposition, IEEE Transactions on Evolutionary Computation, 2007,
% 11(6): 712-731.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    [refObj,start,stop,theta] = Global.ParameterSet(1,0,1,5);    % 1 or 2
    N = Global.N;
    T = ceil(N/10);  % neighborhood size
    
    %% Generate the parallel weight vectors based on the choosen objective     
    % ref is N*2 vector representing reference point of each weight vector.
    % WV is [0;1] or [1;0] respectively for refObj: 1, 2

    %% generate reference point
    ref = start:(stop-start)/(N-1):stop; ref = ref';
    ref(:,refObj) = ref;
    ref(:,(3-refObj)) = zeros(N,1);
%         WV = [1;1]; WV(refObj,1) = 0;

    %% Detect the neighbours of each solution
    B = pdist2(ref,ref);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    
    %% Generate random population
    Population = Global.Initialization();

    %% Optimization
    while Global.NotTermination(Population)
%         % Generate the parallel weight vectors based on the choosen objective     
%         % ref is N*2 vector representing reference point of each weight vector.
%         % WV is [0;1] or [1;0] respectively for refObj: 1, 2
%         
%         % get ideal point and nadir point on this refObj.
%         objValue = Population.objs;
%         ideal = min(objValue(:,refObj),[],1);
%         nadir = max(objValue(:,refObj),[],1);
%         
%         % generate reference point
%         ref = ideal:(0.9 * nadir-ideal)/(N-1):0.9 * nadir; ref = ref';
%         ref(:,refObj) = ref;
%         ref(:,(3-refObj)) = zeros(N,1);
% %         WV = [1;1]; WV(refObj,1) = 0;
% 
%         % Detect the neighbours of each solution
%         B = pdist2(ref,ref);
%         [~,B] = sort(B,2);
%         B = B(:,1:T);
%     
        
        % For each solution (each WV)
        for i = 1 : N 
            % Choose the parents
            P = B(i,randperm(size(B,2)));   %所有的neighborhood T*1

            % Generate an offspring
            Offspring = GAhalf(Population(P(1:2)));   % 最近的2个parents

%             % Update the ideal point
%             Z = min(Z,Offspring.obj);

            % Update the neighbours
            bias = [1,1]; bias(refObj) = theta;
            p = Population(P).objs-ref(P,:);
            p(:,refObj) = abs(p(:,refObj));
            g_old = sum(p .* bias, 2);
            p = repmat(Offspring.obj,T,1) - ref(P,:);
            p(:,refObj) = abs(p(:,refObj));
            g_new = sum(p .* bias, 2);
            Population(P(g_old>=g_new)) = Offspring;
        end
    end
end