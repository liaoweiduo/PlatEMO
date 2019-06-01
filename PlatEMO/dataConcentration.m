clear;
%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'HypE'};
% Problems = {'DTLZ1', 'DTLZ2', 'DTLZ3', 'DTLZ4', 'DTLZ5', 'DTLZ6', 'DTLZ7', 'DTLZ8', 'DTLZ9',...
%     'C1_DTLZ1', 'C2_DTLZ2', 'C3_DTLZ4', 'CDTLZ2', 'IDTLZ1', 'IDTLZ2', 'SDTLZ1',...
%     'WFG1', 'WFG2', 'WFG3', 'WFG4', 'WFG5', 'WFG6', 'WFG7', 'WFG8', 'WFG9',...
%     'MaF1', 'MaF2', 'MaF3', 'MaF4', 'MaF5', 'MaF6', 'MaF7', 'MaF8', 'MaF9', 'MaF10',...
%     'MaF11', 'MaF12', 'MaF13', 'MaF14', 'MaF15'};
Problems ={'DTLZ1', 'C1_DTLZ1', 'MaF1', 'IDTLZ1'};
Ms = {'3','5','8','10'};

%% load data
for i = 1:size(Algorithms,2)
    Algorithm = Algorithms{i};
    fileName=[rootPath, Algorithm, '_2.mat'];
    load(fileName);
    eval(['metrics_',Algorithm,'_2=metrics;']);
    
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

%% concentrate data
for indexA = 1:size(Algorithms,2)  % concentrate data for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics_1=metrics_',Algorithm,';']);
    eval(['metrics_2=metrics_',Algorithm,'_DR;']);
    eval(['metrics_3=metrics_',Algorithm,'_DR2;']);
    eval(['metrics_4=metrics_',Algorithm,'_optimal;']);
    T = table('Size',[160,6],'VariableTypes',{'string','string','double','double','double','double'},...
        'VariableNames',{'Problem','M',Algorithm,[Algorithm,'_DR'],[Algorithm,'_DR2'],[Algorithm,'_optimal']});
    tIndex = 1;
    for indexP = 1:size(Problems,2)   % concentrate data for specific problem
        Problem = Problems{indexP};
        for indexM = 1:size(Ms,2)
            M = Ms{indexM};
            aver_origin = -1;
            aver_dr = -1;
            aver_dr2 = -1;
            aver_optimal = -1;
            for i = 1:length(metrics_1)     % origin metrics
                if strcmp(metrics_1(i).Problem, Problem) && strcmp(metrics_1(i).M, M)
                    hvSetStrut = metrics_1(i).hvSetStrut;
                    if ~isempty(hvSetStrut.aver)
                        aver_origin = hvSetStrut.aver(end);
                    end
                    break
                end
            end
                
            for i = 1:length(metrics_2)     % dr metrics
                if strcmp(metrics_2(i).Problem, Problem) && strcmp(metrics_2(i).M, M)
                    hvSetStrut = metrics_2(i).hvSetStrut;
                    
                    if ~isempty(hvSetStrut.aver)
                        aver_dr = hvSetStrut.aver(end);
                    end
                    break
                end
            end
            
            for i = 1:length(metrics_3)     % dr2 metrics
                if strcmp(metrics_3(i).Problem, Problem) && strcmp(metrics_3(i).M, M)
                    hvSetStrut = metrics_3(i).hvSetStrut;
                    
                    if ~isempty(hvSetStrut.aver)
                        aver_dr2 = hvSetStrut.aver(end);
                    end
                    break
                end
            end
            
            for i = 1:length(metrics_4)     % optimal metrics
                if strcmp(metrics_4(i).Problem, Problem) && strcmp(metrics_4(i).M, M)
                    hvSetStrut = metrics_4(i).hvSetStrut;
                    if ~isempty(hvSetStrut.aver)
                        aver_optimal = hvSetStrut.aver(end);
                    end
                    break
                end
            end
            
            T(tIndex,:) = {Problem, M, aver_origin, aver_dr, aver_dr2, aver_optimal};
            
            tIndex = tIndex + 1;
        end
    end
    
    %% save table of hv results
    save([rootPath, 'finalHvTable_', Algorithm, '.mat'],'T');
    writetable(T,[rootPath, 'finalHvTable_', Algorithm, '.xlsx'],'Sheet',1,'Range','A1');
end
        
        
