clear;
N = 100;
evaluation = 40000;

% problems = {@DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4, @DTLZ5, @DTLZ6, @DTLZ7, @DTLZ8, @DTLZ9,...
%     @C1_DTLZ1, @C2_DTLZ2, @C3_DTLZ4, @CDTLZ2, @IDTLZ1, @IDTLZ2, @SDTLZ1,...
%     @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
%     @MaF1, @MaF2, @MaF3, @MaF4, @MaF5, @MaF6, @MaF7, @MaF8, @MaF9, @MaF10,...
%     @MaF11, @MaF12, @MaF13, @MaF14, @MaF15};

problems = {@C1_DTLZ1};

parameters = {};

M = [3,5,8,10];  
algorithms = {@HypE};

for m = M
for algorithm = algorithms
for problem = problems
for run = 1:20
    parameters{size(parameters,2)+1} = {m,problem,algorithm,run};
end
end
end
end

total = size(parameters,2);
for i = 1:total
    m = parameters{i}{1};
    problem = parameters{i}{2}{1};
    algorithm = parameters{i}{3}{1};
    run = parameters{i}{4};
    
    fprintf('start %d of %d...\n', i, total);
    
    if strcmp(func2str(problem), 'MaF1')
        d = m + 9;
    else
        d = m + 4;
    end
    if exist(['Data/',func2str(algorithm),'/',func2str(algorithm),...
            '_',func2str(problem),'_N100_M',int2str(m),'_D',...
            int2str(d),'_',int2str(run),'.mat'],'file') == 2
        fprintf('file: %s exist, continue\n', [func2str(algorithm),'_',...
            func2str(problem),'_N100_M',int2str(m),'_D',int2str(d),'_',int2str(run),'.mat']);
        continue
    end
    
    main('-algorithm', algorithm,'-problem', problem,... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', 100, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end