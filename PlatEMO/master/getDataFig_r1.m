clear;

problems = {@MinusDTLZ1};

algorithms = {@SMSEMOAn1,@SMSEMOAn3,@SMSEMOAn5,...
              @FVMOEAn1,@FVMOEAn3,@FVMOEAn5,...
              @HypEn1,@HypEn3,@HypEn5,...
              @R2HCAEMOAn1,@R2HCAEMOAn3,@R2HCAEMOAn5};
algorithms = {@HypEn1,@HypEn3,@HypEn5};
M = [3];  

Means = [];
Stds = [];
resultIndex = [];

figure()
hold on
for i = 1:size(algorithms,2)
    m = M(1);
    problem = problems{1};
    algorithm = algorithms{i};
    
    varargin = {'-algorithm', algorithm, '-problem', problem, '-M', m};
    Global = GLOBAL(varargin{:});
    PF = Global.problem.PF(10000);
   
    fprintf('start %d of %d... %s\n', i, size(algorithms,2), [func2str(algorithm),'_',func2str(problem),'_M',num2str(m)]);
    
    files = dir(fullfile('Data',func2str(algorithm),...
        [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));
    
    Metrics = [];
    for fileIndex = 1:size(files,1)
        file = files(fileIndex);
        filename = fullfile(file.folder, file.name);
        load(filename); 
        
        resultIndex = cell2mat(result(:,1));
        if ~isfield(metric,'NIGDPlus') || size(metric.NIGDPlus,1) == 1
            metric_NIGDPlus = zeros(1,size(files,1));
            for ii = 1:size(result,1)
                objectiveSet = result{ii,2}.objs;
                metric_NIGDPlus(1,ii) = NIGDPlus(objectiveSet, PF);
            end
            metric.NIGDPlus = metric_NIGDPlus;
            save(filename,'result','metric');
        end
        Metrics(fileIndex,:) = metric.NIGDPlus;
    end
    
    Means(i,:) = mean(Metrics);
    Stds(i,:) = std(Metrics); 
    
    %% NPD part
    plot(resultIndex,Means(i,:),'LineWidth',3);

    %% median front part
%     [~,indexs] = sort(Metrics(:,end));
%     index = indexs(ceil((size(files,1)+1)/2));
%     
%     file = files(index);
%     filename = fullfile(file.folder, file.name);
%     load(filename);
%     PopObjs = result{end,2}.objs;
%     
%     figure();
%     Draw(PopObjs);
%     if m == 3
%         minValues = min([PF;PopObjs]);
%         maxValues = max([PF;PopObjs]);
%         xlim([minValues(1),maxValues(1)])
%         ylim([minValues(2),maxValues(2)])
%         zlim([minValues(3),maxValues(3)])
%     else
%         minValue = min(min(PF));
%         maxValue = max(max(PF));
%         ylim([minValue,maxValue])
%     end
%     if exist(fullfile('Analysis','master','distribution',func2str(algorithm)),'dir') == 0
%         mkdir (fullfile('Analysis','master','distribution',func2str(algorithm)));
%     end
%     saveas(gca,fullfile('Analysis','master','distribution',func2str(algorithm),...
%         [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'.eps']),'eps');
%     close(figure(gcf))
    
    %% finish
    fprintf('finish %d of %d...\n', i, size(algorithms,2));
end
algorithmStr = cellfun(@func2str, algorithms,'UniformOutput',false);
legend(algorithmStr);
xlabel('FEs');
ylabel('Normalized IGDPlus');
set(gca,'FontSize',20);
% set(gca, 'YScale', 'log');
grid on
