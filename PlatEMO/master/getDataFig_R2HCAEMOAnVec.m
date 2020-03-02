clear;

problems = {@DTLZ2, @DTLZ3, @DTLZ4};

algorithms = {@R2HCAEMOA13_12_nVec1_mixed,@R2HCAEMOA13_12_nVec3_mixed,...
    @R2HCAEMOA13_12_nVec5_mixed,@R2HCAEMOA13_12_nVec10_mixed};

M = [3];  

total = size(problems,2)*size(M,2);
for i = 1:size(problems,2)
    for m = M
        problem = problems{i};
        for algorithmIndex = 1:size(algorithms,2)
            algorithm = algorithms{algorithmIndex};

            fprintf('start %d of %d... %s\n', i, total, [func2str(algorithm),'_',func2str(problem),'_M',num2str(m)]);

            files = dir(fullfile('Data',func2str(algorithm),...
                [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));

            Metrics = [];
            for fileIndex = 1:size(files,1)
                file = files(fileIndex);
                filename = fullfile(file.folder, file.name);
                load(filename,'metric');
                Metrics(fileIndex) = metric.NIGDPlus;
            end
%             [~,indexs] = sort(Metrics);
%             index = indexs(ceil((size(files,1)+1)/2));    %median front
            [~,index] = min(Metrics);   %best front

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
            if exist(fullfile('Analysis','master','distribution',func2str(algorithm)),'dir') == 0
                mkdir (fullfile('Analysis','master','distribution',func2str(algorithm)));
            end
            saveas(gca,fullfile('Analysis','master','distribution',func2str(algorithm),...
                [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'.eps']),'eps');
            close(figure(gcf))

            fprintf('finish %d of %d...\n', i, total);
        end
    end
end