clear;
evaluation = 40000;

problems = {
    @DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    @MinusDTLZ1, @MinusDTLZ2, @MinusDTLZ3, @MinusDTLZ4,...
    @MinusWFG1, @MinusWFG2, @MinusWFG3, @MinusWFG4, @MinusWFG5,...
    @MinusWFG6, @MinusWFG7, @MinusWFG8, @MinusWFG9,...
    };

algorithms = {@R2HCAEMOA2_uniform,@R2HCAEMOA5_uniform};

M = [3,5,8,10]; 

parameters = {};
for m = M
    for algorithm = algorithms
        for problem = problems
            for run = 1:5
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
    
    if m == 3
        N = 91;
    elseif m == 5
        N = 70;
    elseif m == 8
        N = 36;
    elseif m == 10
        N = 30;
    end
    
    fprintf('start %d of %d...\n', i, total);
    main('-algorithm', {algorithm},'-problem', {problem},... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', 100, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end