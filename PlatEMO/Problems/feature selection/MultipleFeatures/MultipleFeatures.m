classdef MultipleFeatures < PROBLEM
% <problem> <feature selection>
% The bi-objective feature selection problem
% 2000 instances;2 classes;649 attributes


%------------------------------- Reference --------------------------------
% http://archive.ics.uci.edu/ml/machine-learning-databases/mfeat/
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    properties(Access = private)
        train;
        test;
        accuracy;	% accuracy of each feature;
    end
    methods
        %% Initialization
        function obj = MultipleFeatures()
            % Parameter setting
            obj.Global.M = 2;
            obj.Global.D = 649;
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D);
            obj.Global.encoding = 'real';    
            % load data and calculate accuracy for each feature. 
            file = fullfile(fileparts(mfilename('fullpath')),'MultipleFeatures.mat');
            if exist(file,'file') == 2
                load(file,'train','test','accuracy');
            else
                load('mfeat-fac','mfeat_fac');
                load('mfeat-fou','mfeat_fou');
                load('mfeat-kar','mfeat_kar');
                load('mfeat-mor','mfeat_mor');
                load('mfeat-pix','mfeat_pix');
                load('mfeat-zer','mfeat_zer');

                class = [zeros(200,1);ones(200,1);ones(200,1).*2;ones(200,1).*3;
                ones(200,1).*4;ones(200,1).*5;ones(200,1).*6;ones(200,1).*7;
                ones(200,1).*8;ones(200,1).*9];
                data = [class,mfeat_fac,mfeat_fou,mfeat_kar,mfeat_mor,mfeat_pix,mfeat_zer];

                % calculate accuracy for each feature. 
                n = size(data,1);
                ran = randperm(n);
                train = data(ran(1:floor(0.7*n)),:);
                test = data(ran(floor(0.7*n)+1:end),:);
                accuracy = zeros(1,obj.Global.D);
                for feature = 1:obj.Global.D
                    Mdl = fitcknn(train(:,feature+1),train(:,1),'NumNeighbors',5,'Standardize',1);
                    [label,~,~] = predict(Mdl, test(:,feature+1));
                    accuracy(feature) = sum(label == test(:,1),1) / size(test,1);
                end
                save(file,'train','test','accuracy'); 
            end
            obj.train = train;
            obj.test = test;
            obj.accuracy = accuracy;
        end
        %% Repair infeasible solutions
%         function PopDec = CalDec(obj,PopDec)
%             C = sum(obj.W,2)/2;
%             [~,rank] = sort(max(obj.P./obj.W));
%             for i = 1 : size(PopDec,1)
%                 while any(obj.W*PopDec(i,:)'>C)
%                     k = find(PopDec(i,rank),1);
%                     PopDec(i,rank(k)) = 0;
%                 end
%             end
%         end
        function PopDec = reduceFeature(obj,PopDec, num)
            unselectedFeatures = PopDec <= 0.6;
            selectedFeatures = PopDec > 0.6;
            acc = obj.accuracy .* selectedFeatures;
            acc(unselectedFeatures) = ones(1,sum(unselectedFeatures,2));
            [~,index] = sort(acc); 
            PopDec(index(1:num)) = rand(1,num)*0.6;    % smallest num accuracies
        end
        function PopDec = addFeature(obj,PopDec, num)
            % randomly add unselected features to the duplicated subsets.
            unselectedFeatures = PopDec <= 0.6;
            index = 1:size(PopDec,2);
            index = index(unselectedFeatures);
            R = randperm(sum(unselectedFeatures,2)); 
            PopDec(index(R(1:num))) = rand(1,num)*0.4+0.6;
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            [N,D] = size(PopDec);
            [nsfs, selectedFeaturess] = obj.getSelectedFeatures(PopDec); 
            erates = zeros(1,N)';
            for DecIndex = 1:N
                if nsfs(DecIndex) ~= 0
                    selectedFeatureList = 1:D;
                    selectedFeatureList = selectedFeatureList(selectedFeaturess(DecIndex,:)); 
                    Mdl = fitcknn(obj.train(:,selectedFeatureList+1),obj.train(:,1),'NumNeighbors',5);
                    [label,~,~] = predict(Mdl, obj.test(:,selectedFeatureList+1)); 
                    erates(DecIndex) = 1- sum(label == obj.test(:,1),1) / size(obj.test,1); 
                else
                    erates(DecIndex) = 1;
                end
            end
            PopObj = [nsfs./D,erates]; 
        end
        %% A reference point for hypervolume calculation
        function P = PF(obj,N)
            P = [(0:1/(N-1):1)',(1:-1/(N-1):0)'];
            
        end
        %% Calculate nsf and selectedFeatures
        function [nsf, selectedFeatures] = getSelectedFeatures(obj,PopDec)
            selectedFeatures = PopDec > 0.6;
            nsf = sum(selectedFeatures,2);
        end
    end
end