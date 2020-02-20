clear;
evaluation = 40000;

problems = {@DTLZ1};

M = [3];  
N = 91;

parameters = {};
for m = M

    algorithms = {@HypEr13_12s1,@HypEr13_12s3,@HypEr13_12s5,...
                  @HypEr2s1,@HypEr2s3,@HypEr2s5,...
                  @HypEr5s1,@HypEr5s3,@HypEr5s5,...
                  @HypEr10s1,@HypEr10s3,@HypEr10s5};

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
    
    fprintf('start %d of %d...\n', i, total);
    main('-algorithm', {algorithm},'-problem', {problem},... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', 100, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end