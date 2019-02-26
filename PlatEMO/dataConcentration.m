%% parameter sets
rootPath = 'Analysis/';
Algorithms = {'FVEMOA'};
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
end

%% concentrate data
for indexA = 1:size(Algorithms,2)  % concentrate data for specific algorithm
    Algorithm = Algorithms{indexA};
    eval(['metrics_1=metrics_',Algorithm,';']);
    eval(['metrics_2=metrics_',Algorithm,'_DR;']);
    T = table('Size',[160,8],'VariableTypes',{'string','string','double','double','double','double','double','double'},...
        'VariableNames',{'Problem','M',Algorithm,[Algorithm,'_DR_minus1'],[Algorithm,'_DR_minuspoint5'],[Algorithm,'_DR_0'],[Algorithm,'_DR_point5'],[Algorithm,'_DR_1']});
    tIndex = 1;
    for indexP = 1:size(Problems,2)   % concentrate data for specific problem
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
            try
                T(tIndex,:) = {Problem, M, hvSetStrut_1(1).aver(end), ...
                    hvSetStrut_2(1).aver(end), hvSetStrut_2(2).aver(end), ...
                    hvSetStrut_2(3).aver(end), hvSetStrut_2(4).aver(end), ...
                    hvSetStrut_2(5).aver(end)};
            catch exception
                T(tIndex,:) = {Problem, M, hvSetStrut_1(1).aver(end), -1, -1, -1, -1, -1};
            end
            tIndex = tIndex + 1;
        end
    end
    
    %% save table of hv results
    save([rootPath, 'finalHvTable_', Algorithm, '.mat'],'T');
end
        
        
