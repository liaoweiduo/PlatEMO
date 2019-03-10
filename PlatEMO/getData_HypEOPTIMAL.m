N = 100;
evaluation = 100000;

% problems = {@DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4, @DTLZ5, @DTLZ6, @DTLZ7, @DTLZ8, @DTLZ9,...
%     @C1_DTLZ1, @C2_DTLZ2, @C3_DTLZ4, @CDTLZ2, @IDTLZ1, @IDTLZ2, @SDTLZ1,...
%     @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
%     @MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9, @MaF10,...
%     @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};

parameters = {};

M = [3,5,8];
algorithms = {@HypE_DR};
problems = {@IDTLZ1, @IDTLZ2, @MaF1, @MaF4, @MaF8, @MaF15,...
    @DTLZ1, @MaF3, @WFG1};
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
    problem = parameters{i}{2};
    algorithm = parameters{i}{3};
    run = parameters{i}{4};
    
    fprintf('start %d of %d...\n', i, total);
    main('-algorithm', {algorithm{1},10000},'-problem', problem,... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', evaluation, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end