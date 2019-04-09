%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'HypE','FVEMOA'};
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

%% concentrate data
for indexA = 1:size(Algorithms,2)  % concentrate data for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics_1=metrics_',Algorithm,';']);
    eval(['metrics_2=metrics_',Algorithm,'_DR;']);
    eval(['metrics_3=metrics_',Algorithm,'_optimal;']);
    T = table('Size',[160,9],'VariableTypes',{'string','string','double','double','double','double','double','double','double'},...
        'VariableNames',{'Problem','M',Algorithm,[Algorithm,'_DR_minus1'],[Algorithm,'_DR_minuspoint5'],[Algorithm,'_DR_0'],[Algorithm,'_DR_point5'],[Algorithm,'_DR_1'],[Algorithm,'_optimal']});
    tIndex = 1;
    for indexP = 1:size(Problems,2)   % concentrate data for specific problem
        Problem = Problems{indexP};
        for indexM = 1:size(Ms,2)
            M = Ms{indexM};
            aver_origin = -1;
            aver_dr = [-1,-1,-1,-1,-1];
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
                    
                    if ~isempty(hvSetStrut(1).aver)
                        aver_dr(1) = hvSetStrut(1).aver(end);
                    end
                    if ~isempty(hvSetStrut(2).aver)
                        aver_dr(2) = hvSetStrut(2).aver(end);
                    end
                    if ~isempty(hvSetStrut(3).aver)
                        aver_dr(3) = hvSetStrut(3).aver(end);
                    end
                    if ~isempty(hvSetStrut(4).aver)
                        aver_dr(4) = hvSetStrut(4).aver(end);
                    end
                    if ~isempty(hvSetStrut(5).aver)
                        aver_dr(5) = hvSetStrut(5).aver(end);
                    end
                    break
                end
            end
            
            for i = 1:length(metrics_3)     % optimal metrics
                if strcmp(metrics_3(i).Problem, Problem) && strcmp(metrics_3(i).M, M)
                    hvSetStrut = metrics_3(i).hvSetStrut;
                    if ~isempty(hvSetStrut.aver)
                        aver_optimal = hvSetStrut.aver(end);
                    end
                    break
                end
            end
            
            T(tIndex,:) = {Problem, M, aver_origin, ...
                aver_dr(1), aver_dr(2), ...
                aver_dr(3), aver_dr(4), ...
                aver_dr(5), aver_optimal};
            
            tIndex = tIndex + 1;
        end
    end
    
    %% save table of hv results
    save([rootPath, 'finalHvTable_', Algorithm, '.mat'],'T');
    writetable(T,[rootPath, 'finalHvTable_', Algorithm, '.xlsx'],'Sheet',1,'Range','A1');
end
        
        
