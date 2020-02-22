clear;
evaluation = 50000;

problems = {@MinusDTLZ1};

algorithms = {@SMSEMOAn1,@SMSEMOAn3,@SMSEMOAn5,...
              @FVMOEAn1,@FVMOEAn3,@FVMOEAn5,...
              @HypEn1,@HypEn3,@HypEn5,...
              @R2HCAEMOAn1,@R2HCAEMOAn3,@R2HCAEMOAn5};

M = [3];  

parameters = {};
for m = M
    for algorithm = algorithms
        for problem = problems
            for run = 1:11
                parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
            end
        end
    end
end

total = size(parameters,2);
parfor i = 1:total
    m = parameters{i}{1};
    problem = parameters{i}{2}{1};
    algorithm = parameters{i}{3}{1};
    run = parameters{i}{4};
    
    algorithmStr = func2str(algorithm);
    if contains(algorithmStr,'n1')
        N = 100;
    elseif contains(algorithmStr,'n3')
        N = 300;
    elseif contains(algorithmStr,'n5')
        N = 500;
    end
    
    fprintf('start %d of %d...\n', i, total);
    main('-algorithm', {algorithm},'-problem', {problem},... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', 100, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end