function MOEADSTAT(Global)
% <algorithm> <M>
% Multiobjective evolutionary algorithm based on decomposition for feature
% selection 

%------------------------------- Reference --------------------------------
% Nguyen, B. H., Xue, B., Andreae, P., Ishibuchi, H., & Zhang, M. (2019). 
% Multiple Reference Points based Decomposition for Multi-objective Feature
% Selection in Classification: Static and Dynamic Mechanisms. 
% IEEE Transactions on Evolutionary Computation.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    N = min(Global.D,200);
    Global.N = N;
    T = ceil(N/10);  % neighborhood size
    if T < 4
        T = 4;
    end
    
    %% generate reference point
    ref = 0+1/N:1/N:1; ref = ref';
    ref(:,1) = ref;
    ref(:,2) = zeros(N,1);

    %% Detect the neighbours of each solution
    B = pdist2(ref,ref);
    [~,B] = sort(B,2);
    B = B(:,1:T);
    
    %% Generate random population
    Population = Global.Initialization();

    %% Optimization
    while Global.NotTermination(Population)
        
        % For each solution (each WV)
        for i = 1 : N 
            % Choose the parents 
            P = B(i,randperm(size(B,2)));  % neighborhoods index
            if rand() < 0.85    % 85% from neighbor, 15% from whole Popu. 
                Parents = Population(P(1:3));
            else
                Ptemp = randperm(size(Population,2));
                Parents = Population(Ptemp(1:3));
            end
            
            % 1) Generate an offspring through DE corssover and polynomial mutation; 
            [Offspring, calObj] = DE_FS(Parents(1),Parents(2),Parents(3),{0.6,0.7,1,20});  
            
            % 2) Repair offspring if it selects more than nref features. 
            % The feature is chosen if the entry’s value is greater than a threshold theta = 0.6
            nref = ceil(ref(i,1) * Global.D); 
            [nsf, ~] = Global.problem.getSelectedFeatures(Offspring);
            if nsf > nref
                Offspring = Global.problem.reduceFeature(Offspring, nsf-nref);
            elseif nsf == 0
                Offspring = Global.problem.addFeature(Offspring, unidrnd(nref));
            end
            [nsf, ~] = Global.problem.getSelectedFeatures(Offspring);

            % 3) Generate Offspring indicidual, calculating fitness function
            if calObj
                Offspring = INDIVIDUAL(Offspring); 
            end
            
            % Update the neighbours
            % fitness function: f2 + 100*max(nsf-nref,0) + 0.01*f1
            bias = [0.01,1];
            pobjs = Population(P).objs; pdecs = Population(P).decs;
            [nsfs, selectedFeaturess] = Global.problem.getSelectedFeatures(pdecs);
            nrefs = ceil(ref(P,1) * Global.D);
            g_old = sum(pobjs .* bias, 2)+100*max(nsfs-nrefs,0);
            p = repmat(Offspring.obj,T,1); 
            g_new = sum(p .* bias, 2)+100*max(nsf-nrefs,0);
            
            for ii = 1:T
            % paper里用的是随机，只更新找到的第一个，后面用neighbor自己的
                if g_old(ii)>=g_new(ii)
                    Population(P(ii)) = Offspring;
                    break
                end
            end
%            Population(P(g_old>=g_new)) = Offspring;                    
            
        end
        % Repair duplicated feature subsets
        [nsfs, selectedFeaturess] = Global.problem.getSelectedFeatures(Population.decs);
        for i = 1:N
            if ismember(selectedFeaturess(i,:), selectedFeaturess(1:i-1,:), 'rows')
                nref = ceil(ref(i,1) * Global.D); 
                if nref > nsfs(i)
                    Population(i) = INDIVIDUAL(Global.problem.addFeature(Population(i).dec, nref-nsfs(i)));
                end
            end
        end
        
    end
end
