%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'FVEMOA'};
Problems = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5', 'DTLZ6', 'DTLZ7', 'DTLZ8', 'DTLZ9',...
    'C1_DTLZ1', 'C2_DTLZ2', 'C3_DTLZ4', 'CDTLZ2', 'IDTLZ1', 'IDTLZ2', 'SDTLZ1',...
    'WFG1', 'WFG2', 'WFG3', 'WFG4', 'WFG5', 'WFG6', 'WFG7', 'WFG8', 'WFG9',...
    'MaF1', 'MaF2', 'MaF3', 'MaF4', 'MaF5', 'MaF6', 'MaF7', 'MaF8', 'MaF9', 'MaF10',...
    'MaF11', 'MaF12', 'MaF13', 'MaF14', 'MaF15'};
Ms = {'3','5','8','10'};
errorLogs = {};
errorLogsName = 'errorLogs_drawPic.mat';

%% load data
for i = 1:size(Algorithms,2)
    Algorithm = Algorithms{i};
    fileName=[rootPath, Algorithm, '.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'=metrics;']);
    
    fileName=[rootPath, Algorithm, '_DR.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_DR=metrics;']);
end

%% draw picture
for indexA = 1:size(Algorithms,2)  % draw picture for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics_1=metrics_',Algorithm,';']);
    eval(['metrics_2=metrics_',Algorithm,'_DR;']);
    for indexP = 1:size(Problems,2)   % draw picture for specific problem
        %% draw picture
        fig = figure('Visible', 'on');
        Problem = Problems{indexP};
        for indexM = 1:size(Ms,2)
            M = Ms{indexM};
            for i = 1:length(metrics_1)     % origin metrics
                if strcmp(metrics_1(i).Problem, Problem) && strcmp(metrics_1(i).M, M)
                    break
                end
            end
            hvSetStrut_1 = metrics_1(i).hvSetStrut;
            
            for i = 1:length(metrics_2)     % dr metrics
                if strcmp(metrics_2(i).Problem, Problem) && strcmp(metrics_2(i).M, M)
                    break
                end
            end
            hvSetStrut_2 = metrics_2(i).hvSetStrut;
            
            subplot(2,2,indexM);
            try
                % e1 = errorbar(hvSetStrut(1).indexSet, hvSetStrut(1).aver, hvSetStrut(1).var);
                p0=plot(hvSetStrut_1(1).indexSet, hvSetStrut_1(1).aver);
                hold on
                p1=plot(hvSetStrut_2(1).indexSet, hvSetStrut_2(1).aver);
                hold on
                p2=plot(hvSetStrut_2(2).indexSet, hvSetStrut_2(2).aver);
                hold on
                p3=plot(hvSetStrut_2(3).indexSet, hvSetStrut_2(3).aver);
                hold on
                p4=plot(hvSetStrut_2(4).indexSet, hvSetStrut_2(4).aver);
                hold on
                p5=plot(hvSetStrut_2(5).indexSet, hvSetStrut_2(5).aver);
                hold on
            catch exception
                errorLogs{length(errorLogs)+1} = [Algorithm,'_',Problem,'_',M];
            end
            try
                legend([p0,p1,p2,p3,p4,p5],'origin','-1','-0.5','0','0.5','1');
            catch exception
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
        
        
        
