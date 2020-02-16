clear;

problems = {@DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
%     @MinusDTLZ1, @MinusDTLZ2, @MinusDTLZ3, @MinusDTLZ4,...
%     @MinusWFG1, @MinusWFG2, @MinusWFG3, @MinusWFG4, @MinusWFG5,...
%     @MinusWFG6, @MinusWFG7, @MinusWFG8, @MinusWFG9,...
    };

M = [5];  
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
for i = 1:total
    m = parameters{i}{1};
    problem = parameters{i}{2}{1};
    algorithm = parameters{i}{3}{1};
    run = parameters{i}{4};
    
   
    fprintf('start %d of %d...\n', i, total);
    
    file = dir(fullfile('Data',func2str(algorithm),...
        [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));
    filename = fullfile(file.folder, file.name);
    load(filename);
    PopObjs = result{end,end}.objs;
    
    varargin = {'-algorithm', algorithm, '-problem', problem, '-M', m};
    Global = GLOBAL(varargin{:});
    PF = Global.problem.PF(10000);
    
    figure();
    Draw(PopObjs);
    if m == 3
        minValues = min(PF);
        maxValues = max(PF);
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