N = 100;
evaluation = 100000;

M = [5];
algorithms = {@FVEMOA};
problems = {@DTLZ5, @DTLZ6, @DTLZ7, @DTLZ8, @DTLZ9,...
    @C1_DTLZ1, @C2_DTLZ2, @C3_DTLZ4, @CDTLZ2, @IDTLZ1, @IDTLZ2, @SDTLZ1,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    @MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9, @MaF10,...
    @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};

parameters = {};
for m = M
for problem = problems
for algorithm = algorithms
for run = 1:10
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end
end

parfor i = 1:size(parameters,2)
    m = parameters{i}{1};
    problem = parameters{i}{2};
    algorithm = parameters{i}{3};
    run = parameters{i}{4};
    main('-algorithm', algorithm{1},'-problem', problem,... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', evaluation, '-run', run);
end