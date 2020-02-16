clear;
evaluation = 40000;

problems = {@DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    };

M = [5];  
N = 70;
algorithms = {@SMSEMOA1,@SMSEMOA5_4,@SMSEMOA2,@SMSEMOA5};

parameters = {};
for m = M
for algorithm = algorithms
for problem = problems
for run = 1:1
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