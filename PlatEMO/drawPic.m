%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'HypE'};
Problems = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5', 'DTLZ6', 'DTLZ7', 'DTLZ8', 'DTLZ9',...
    'C1_DTLZ1', 'C2_DTLZ2', 'C3_DTLZ4', 'CDTLZ2', 'IDTLZ1', 'IDTLZ2', 'SDTLZ1',...
    'WFG1', 'WFG2', 'WFG3', 'WFG4', 'WFG5', 'WFG6', 'WFG7', 'WFG8', 'WFG9',...
    'MaF1', 'MaF2', 'MaF3', 'MaF4', 'MaF5', 'MaF6', 'MaF7', 'MaF8', 'MaF9', 'MaF10',...
    'MaF11', 'MaF12', 'MaF13', 'MaF14', 'MaF15'};
Ms = {'3','5','8','10'};

%% load data
for i = 1:size(Algorithms,2)
    Algorithm = Algorithms{i};
    fileName=[rootPath, Algorithm, '.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'=metrics;']);
    
    fileName=[rootPath, Algorithm, '_DR.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_DR=metrics;']);
    
    fileName=[rootPath, Algorithm, '_optimal.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_optimal=metrics;']);
end

%% draw picture
for indexA = 1:size(Algorithms,2)  % draw picture for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics_1=metrics_',Algorithm,';']);
    eval(['metrics_2=metrics_',Algorithm,'_DR;']);
    eval(['metrics_3=metrics_',Algorithm,'_optimal;']);
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
                    p1=plot(hvSetStrut(1).indexSet, hvSetStrut(1).aver);
                    p2=plot(hvSetStrut(2).indexSet, hvSetStrut(2).aver);
                    p3=plot(hvSetStrut(3).indexSet, hvSetStrut(3).aver);
                    p4=plot(hvSetStrut(4).indexSet, hvSetStrut(4).aver);
                    p5=plot(hvSetStrut(5).indexSet, hvSetStrut(5).aver);
                    break
                end
            end
            
            for i = 1:length(metrics_3)     % optimal metrics
                if strcmp(metrics_3(i).Problem, Problem) && strcmp(metrics_3(i).M, M)
                    hvSetStrut = metrics_3(i).hvSetStrut;
                    p6=plot(hvSetStrut.indexSet, hvSetStrut.aver);
                    break
                end
            end
            
            try
                legend([p0,p1,p2,p3,p4,p5,p6],'origin','-1','-0.5','0','0.5','1','optimal');
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