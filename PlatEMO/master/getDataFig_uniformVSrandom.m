clear;

problems = {
    @DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    @MinusDTLZ1, @MinusDTLZ2, @MinusDTLZ3, @MinusDTLZ4,...
    @MinusWFG1, @MinusWFG2, @MinusWFG3, @MinusWFG4, @MinusWFG5,...
    @MinusWFG6, @MinusWFG7, @MinusWFG8, @MinusWFG9,...
    };

algorithms = {@R2HCAEMOA5_mixed};
M = [3,5,8,10];  

total = size(problems,2)*size(M,2);
for i = 1:size(problems,2)
    for m = M
        problem = problems{i};
        algorithm = algorithms{1};

        files = dir(fullfile('Data',func2str(algorithm),...
            [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));

        Metrics = [];
        for fileIndex = 1:size(files,1)
            file = files(fileIndex);
            filename = fullfile(file.folder, file.name);
            load(filename,'metric');
            Metrics(fileIndex) = metric.NIGDPlus;
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
end