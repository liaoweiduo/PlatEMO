clear;

problems = {
    @DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    @MinusDTLZ1, @MinusDTLZ2, @MinusDTLZ3, @MinusDTLZ4,...
    @MinusWFG1, @MinusWFG2, @MinusWFG3, @MinusWFG4, @MinusWFG5,...
    @MinusWFG6, @MinusWFG7, @MinusWFG8, @MinusWFG9,...
    };

% problems = {@WFG3};

M = [10];  

parameters = {};
for m = M
    
    if m == 3 
        algorithms = {@FVMOEA1,@FVMOEA13_12,@FVMOEA2,@FVMOEA5,@HypE1,@HypE13_12,@HypE2,@HypE5,@SMSEMOA1,@SMSEMOA13_12,@SMSEMOA2,@SMSEMOA5,@R2HCAEMOA1,@R2HCAEMOA13_12,@R2HCAEMOA2,@R2HCAEMOA5};
    elseif m == 5
        algorithms = {@FVMOEA1,@FVMOEA5_4,  @FVMOEA2,@FVMOEA5,@HypE1,@HypE5_4,  @HypE2,@HypE5,@SMSEMOA1,@SMSEMOA5_4,  @SMSEMOA2,@SMSEMOA5,@R2HCAEMOA1,@R2HCAEMOA5_4,@R2HCAEMOA2,@R2HCAEMOA5};
    elseif m == 8
        algorithms = {@FVMOEA1,@FVMOEA3_2,  @FVMOEA5,@FVMOEA10,@HypE1,@HypE3_2, @HypE5,@HypE10,@SMSEMOA1,@SMSEMOA3_2, @SMSEMOA5,@SMSEMOA10,@R2HCAEMOA1,@R2HCAEMOA3_2,@R2HCAEMOA5,@R2HCAEMOA10};
    else 
        algorithms = {@FVMOEA1,@FVMOEA2,    @FVMOEA5,@FVMOEA10,@HypE1,@HypE2,   @HypE5,@HypE10,@SMSEMOA1,@SMSEMOA2,   @SMSEMOA5,@SMSEMOA10,@R2HCAEMOA1,@R2HCAEMOA2,@R2HCAEMOA5,@R2HCAEMOA10};
    end
    
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
        load(filename,'metric');
        Metrics(fileIndex) = metric.NHV;
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
        if strcmp(problem,'WFG3')
            xlim([0,3])
            ylim([0,2])
            zlim([0,6])
        else
            minValues = min([PF;PopObjs]);
            maxValues = max([PF;PopObjs]);
            xlim([minValues(1),maxValues(1)])
            ylim([minValues(2),maxValues(2)])
            zlim([minValues(3),maxValues(3)])
        end
    else
        minValue = min(min(PF));
        maxValue = max(max(PF));
        ylim([minValue,maxValue])
    end
    xlabel('') 
    ylabel('')
    zlabel('')
    set(gca,'FontSize',40);
    if exist(fullfile('Analysis','master','distribution',func2str(algorithm)),'dir') == 0
        mkdir (fullfile('Analysis','master','distribution',func2str(algorithm)));
    end
    saveas(gca,fullfile('Analysis','master','distribution',func2str(algorithm),...
        [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'.eps']),'eps');
    close(figure(gcf))
    
    fprintf('finish %d of %d...\n', i, total);
end