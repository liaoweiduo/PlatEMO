clear;

problems = {@DTLZ1};
algorithms = {@HypEr13_12s1,@HypEr13_12s3,@HypEr13_12s5,...
                  @HypEr2s1,@HypEr2s3,@HypEr2s5,...
                  @HypEr5s1,@HypEr5s3,@HypEr5s5,...
                  @HypEr10s1,@HypEr10s3,@HypEr10s5};
M = [3];  

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
for i = 1:total
    m = parameters{i}{1};
    problem = parameters{i}{2}{1};
    algorithm = parameters{i}{3}{1};
    run = parameters{i}{4};
    
   
    fprintf('start %d of %d... %s\n', i, total, [func2str(algorithm),'_',func2str(problem),'_M',num2str(m)]);
    
    files = dir(fullfile('Data',func2str(algorithm),...
        [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));
    
    Metrics = [];
    for fileIndex = 1:size(files,1)
        file = files(fileIndex);
        filename = fullfile(file.folder, file.name);
        load(filename,"metric");
        Metrics(fileIndex) = metric.NPD;
    end
    [~,indexs] = sort(Metrics);
    index = indexs(ceil((size(files,1)+1)/2));
%     [~,index] = max(Metrics);
    
    file = files(index);
    filename = fullfile(file.folder, file.name);
    load(filename);
    PopObjs = result{end,end}.objs;
    
    varargin = {'-algorithm', algorithm, '-problem', problem, '-M', m};
    Global = GLOBAL(varargin{:});
    PF = Global.problem.PF(10000);
    
    figure();
    Draw(PopObjs);
    if m == 3
        minValues = min([PF;PopObjs]);
        maxValues = max([PF;PopObjs]);
        xlim([minValues(1),maxValues(1)])
        ylim([minValues(2),maxValues(2)])
        zlim([minValues(3),maxValues(3)])
    else
        minValue = min(min(PF));
        maxValue = max(max(PF)); 
        ylim([minValue,maxValue])
    end
    if exist(fullfile('Analysis','master','distribution',func2str(algorithm)),'dir') == 0
        mkdir (fullfile('Analysis','master','distribution',func2str(algorithm)));
    end
    saveas(gca,fullfile('Analysis','master','distribution',func2str(algorithm),...
        [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'.eps']),'eps');
    close(figure(gcf))
    
    fprintf('finish %d of %d...\n', i, total);
end