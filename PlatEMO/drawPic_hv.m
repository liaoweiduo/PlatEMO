%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'FVEMOA'};
% Problems = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5', 'DTLZ6', 'DTLZ7', 'DTLZ8', 'DTLZ9',...
%     'C1_DTLZ1', 'C2_DTLZ2', 'C3_DTLZ4', 'CDTLZ2', 'IDTLZ1', 'IDTLZ2', 'SDTLZ1',...
%     'WFG1', 'WFG2', 'WFG3', 'WFG4', 'WFG5', 'WFG6', 'WFG7', 'WFG8', 'WFG9',...
%     'MaF1', 'MaF2', 'MaF3', 'MaF4', 'MaF5', 'MaF6', 'MaF7', 'MaF8', 'MaF9', 'MaF10',...
%     'MaF11', 'MaF12', 'MaF13', 'MaF14', 'MaF15'};
Problems ={'DTLZ1', 'C1_DTLZ1', 'MaF1', 'IDTLZ1'};
Ms = {'3','5'};

%% load data
for i = 1:size(Algorithms,2)
    Algorithm = Algorithms{i};
    fileName=[rootPath, Algorithm, '.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'=metrics;']);
    
    fileName=[rootPath, Algorithm, '_DR.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_DR=metrics;']);
    
    fileName=[rootPath, Algorithm, '_DR2.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_DR2=metrics;']);
    
    fileName=[rootPath, Algorithm, '_optimal.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_optimal=metrics;']);
end

%% draw picture
for indexA = 1:size(Algorithms,2)  % draw picture for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics_1=metrics_',Algorithm,';']);
    eval(['metrics_2=metrics_',Algorithm,'_DR;']);
    eval(['metrics_3=metrics_',Algorithm,'_DR2;']);
    eval(['metrics_4=metrics_',Algorithm,'_optimal;']);
    for indexP = 1:size(Problems,2)   % draw picture for specific problem
        %% draw picture
        fig = figure('Visible', 'on');
        Problem = Problems{indexP};
        for indexM = 1:size(Ms,2)
            M = Ms{indexM};
            
            subplot(2,2,indexM);
            hold on
            for i = 1:length(metrics_1)     % origin metrics
                if strcmp(metrics_1(i).Problem, Problem) && strcmp(metrics_1(i).M, M)
                    hvSetStrut = metrics_1(i).hvSetStrut;
                    p0=plot(hvSetStrut.indexSet, hvSetStrut.aver);
                    break
                end
            end
            
            for i = 1:length(metrics_2)     % dr metrics
                if strcmp(metrics_2(i).Problem, Problem) && strcmp(metrics_2(i).M, M)
                    hvSetStrut = metrics_2(i).hvSetStrut;
                    p1=plot(hvSetStrut.indexSet, hvSetStrut.aver);
                    break
                end
            end
            
            for i = 1:length(metrics_3)     % dr2 metrics
                if strcmp(metrics_3(i).Problem, Problem) && strcmp(metrics_3(i).M, M)
                    hvSetStrut = metrics_3(i).hvSetStrut;
                    p2=plot(hvSetStrut.indexSet, hvSetStrut.aver);
                    break
                end
            end
            
            for i = 1:length(metrics_4)     % optimal metrics
                if strcmp(metrics_4(i).Problem, Problem) && strcmp(metrics_4(i).M, M)
                    hvSetStrut = metrics_4(i).hvSetStrut;
                    p3=plot(hvSetStrut.indexSet, hvSetStrut.aver);
                    break
                end
            end
            
            try
                legend([p0,p1,p2,p3],'origin','DR','DR2','optimal');
            catch exception
            end
            title([Algorithm,', ',Problem,', M', M]);
            xlabel('Time');
            ylabel('HV');
        end
        %% save pic
        saveas(fig, [rootPath, Algorithm, '_', Problem, '_hv.fig']);
        saveas(fig, [rootPath, Algorithm, '_', Problem, '_hv.png']);
        close(fig);
    end
end