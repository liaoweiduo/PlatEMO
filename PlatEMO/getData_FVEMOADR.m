N = 100;
evaluation = 100000;

% problems = {@DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4, @DTLZ5, @DTLZ6, @DTLZ7, @DTLZ8, @DTLZ9,...
%     @C1_DTLZ1, @C2_DTLZ2, @C3_DTLZ4, @CDTLZ2, @IDTLZ1, @IDTLZ2, @SDTLZ1,...
%     @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
%     @MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9, @MaF10,...
%     @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};

parameters = {};
M = [10];
algorithm = @FVEMOA_DR;

problems = {@DTLZ2,@C2_DTLZ2,@C3_DTLZ4,@SDTLZ1,@WFG4,@WFG9,@MaF12,@MaF15};
for m = M
for problem = problems
for run = 1:5:25
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

problems = {@CDTLZ2,@WFG1,@WFG2,@WFG5,@MaF4,@MaF6,@MaF11,@MaF13};
for m = M
for problem = problems
for run = 1:1
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

problems = {@WFG1,@WFG2,@WFG5,@WFG6,@WFG7,@MaF4,@MaF6,@MaF13,@MaF14};
for m = M
for problem = problems
for run = 6:6
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

problems = {@CDTLZ2,@WFG1,@WFG2,@WFG6,@WFG7,@MaF9,@MaF10,@MaF11,@MaF13};
for m = M
for problem = problems
for run = 11:11
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

problems = {@CDTLZ2,@IDTLZ2,@WFG2,@WFG5,@WFG6,@WFG7,@MaF3,@MaF5,@MaF9,@MaF10,@MaF13,@MaF14};
for m = M
for problem = problems
for run = 16:16
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

problems = {@DTLZ1,@C1_DTLZ1,@IDTLZ2,@WFG1,@WFG3,@WFG5,@WFG8,@MaF3,@MaF5,@MaF9,@MaF10,@MaF11,@MaF14};
for m = M
for problem = problems
for run = 21:21
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end

total = size(parameters,2);
parfor i = 1:total
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
    
    fprintf('start %d of %d...\n', i, total);
    main('-algorithm', {algorithm,Rinit,level}, '-problem', problem,... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', evaluation, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end