clear;
N = 200;
evaluation = 50000;

problems = {@OMZM};

parameters = {};

M = [2];  
algorithms = {{@MOEAD,1},{@MOEADPWV}};

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
parfor i = 1:total
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
    if exist(['Data/',func2str(algorithm{1}),'/',func2str(algorithm{1}),...
            '_',func2str(problem),'_N',int2str(N),'_M',int2str(m),'_D',...
            int2str(d),'_',int2str(run),'.mat'],'file') == 2
        fprintf('file: %s exist, continue\n', [func2str(algorithm{1}),'_',...
            func2str(problem),'_N',int2str(N),'_M',int2str(m),'_D',int2str(d),'_',int2str(run),'.mat']);
        continue
    end
    
    main('-algorithm', algorithm,'-problem', problem,... 
    '-N', N, '-M', m, '-evaluation', evaluation,...
    '-save', 100, '-run', run);
    fprintf('finish %d of %d...\n', i, total);
end