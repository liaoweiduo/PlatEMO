N = 100;
evaluation = 100000;

M = [3, 5, 8, 10];
algorithm = @SMSEMOA_DR;
problems = {@DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4, @DTLZ5, @DTLZ6, @DTLZ7, @DTLZ8, @DTLZ9,...
    @C1_DTLZ1, @C2_DTLZ2, @C3_DTLZ4, @CDTLZ2, @IDTLZ1, @IDTLZ2, @SDTLZ1,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    @MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9, @MaF10,...
    @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};

parameters = {};
for m = M
for problem = problems
for run = 1:25
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

parfor i = 1:size(parameters,2)
    m = parameters{i}{1};
    problem = parameters{i}{2};
    algorithm = parameters{i}{3};
    run = parameters{i}{4};
    
    Rinit = 2;
    level = -1;
    if     1<=run && run<=5
        level = -1;
    elseif 6<=run && run<=10
        level = -0.5;
    elseif 11<=run && run<=15
        level = 0;
    elseif 16<=run && run<=20
        level = 0.5;
    elseif 21<=run && run<=25
        level = 1;
    end
    main('-algorithm', {algorithm,Rinit,level}, '-problem', problem,... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', evaluation, '-run', run);
end