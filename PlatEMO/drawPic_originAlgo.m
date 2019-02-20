%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'FVEMOA'};
Problems = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5', 'DTLZ6', 'DTLZ7', 'DTLZ8', 'DTLZ9',...
    'C1_DTLZ1', 'C2_DTLZ2', 'C3_DTLZ4', 'CDTLZ2', 'IDTLZ1', 'IDTLZ2', 'SDTLZ1',...
    'WFG1', 'WFG2', 'WFG3', 'WFG4', 'WFG5', 'WFG6', 'WFG7', 'WFG8', 'WFG9',...
    'MaF1', 'MaF2', 'MaF3', 'MaF4', 'MaF5', 'MaF6', 'MaF7', 'MaF8', 'MaF9', 'MaF10',...
    'MaF11', 'MaF12', 'MaF13', 'MaF14', 'MaF1'};
Ms = {'3','5','8','10'};
errorLogs = {};
errorLogsName = 'errorLogs_originAlgo.mat';

%% load data
for i = 1:size(Algorithms,2)
    Algorithm = Algorithms{i};
    fileName=[rootPath, Algorithm, '.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'=metrics;']);
end

%% draw picture
for indexA = 1:size(Algorithms,2)  % draw picture for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics=metrics_',Algorithm,';']);
    for indexP = 1:size(Problems,2)   % draq picture for specific problem
        %% draw picture
        fig = figure('Visible', 'off');
        Problem = Problems{indexP};
        for indexM = 1:size(Ms,2)
            M = Ms{indexM};
            for i = 1:length(metrics)
                if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
                    break
                end
            end
            hvSetStrut = metrics(i).hvSetStrut;

            subplot(2,2,indexM);
            try
                % e1 = errorbar(hvSetStrut(1).indexSet, hvSetStrut(1).aver, hvSetStrut(1).var);
                plot(hvSetStrut(1).indexSet, hvSetStrut(1).aver);
            catch exception
                errorLogs{length(errorLogs)+1} = [Algorithm,'_',Problem,'_',M];
            end
            title([Algorithm,', ',Problem,', M', M]);
            xlabel('Time');
            ylabel('HV');
        end
        %% save pic
        saveas(fig, [rootPath, Algorithm, '_', Problem, '.fig']);
        close(fig);
    end
end
%% save errorLogs
save([rootPath, errorLogsName], 'errorLogs');

% % %% save errorLogs
% % for i = 1:length(errorLogs)
% %     result = [errorLogs{i}{1},'_',errorLogs{i}{2},'_',errorLogs{i}{3}];
% %     errorLogs{i} = result;
% % end
        
        
        
