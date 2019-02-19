Algorithm = 'FVEMOA_DR';
fileName=['Analysis/', Algorithm, '.mat'];
load(fileName);
for index = 1:length(Data)
    Problem = Data(index).Problem;
    N = Data(index).N;
    M = Data(index).M;
    % find set in metrics
    
    if index == 1
        metrics = struct('Problem',Problem,'N',N,'M',M,'hvSetStrut',struct('level',{-1,-0.5,0,0.5,1},'Rinit',2,'indexSet',Data(1).indexSet,'hvSets',[]));
    end
    
    i = 1;
    while i <= length(metrics)
        if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).N, N) && strcmp(metrics(i).M, M)
            break
        end
        i = i + 1;
    end
    
    if i > length(metrics) % first set
        metrics(i) = struct('Problem',Problem,'N',N,'M',M,'hvSetStrut',struct('level',{-1,-0.5,0,0.5,1},'Rinit',2,'indexSet',Data(1).indexSet,'hvSets',[]));
    end
    
    run = str2double(Data(index).run);
    if (run <= str2double('5'))
        metrics(i).hvSetStrut(1).hvSets(:,size(metrics(i).hvSetStrut(1).hvSets,2)+1) = Data(index).hvSet;
    elseif (run > str2double('5') && run <= str2double('10'))
        metrics(i).hvSetStrut(2).hvSets(:,size(metrics(i).hvSetStrut(2).hvSets,2)+1) = Data(index).hvSet;
    elseif (run > str2double('10') && run <= str2double('15'))
        metrics(i).hvSetStrut(3).hvSets(:,size(metrics(i).hvSetStrut(3).hvSets,2)+1) = Data(index).hvSet;
    elseif (run > str2double('15') && run <= str2double('20'))
        metrics(i).hvSetStrut(4).hvSets(:,size(metrics(i).hvSetStrut(4).hvSets,2)+1) = Data(index).hvSet;
    elseif (run > str2double('20') && run <= str2double('25'))
        metrics(i).hvSetStrut(5).hvSets(:,size(metrics(i).hvSetStrut(5).hvSets,2)+1) = Data(index).hvSet;
    end
end

for index = 1:length(metrics)
    metrics(index).hvSetStrut(1).aver = mean(metrics(index).hvSetStrut(1).hvSets, 2);
    metrics(index).hvSetStrut(2).aver = mean(metrics(index).hvSetStrut(2).hvSets, 2);
    metrics(index).hvSetStrut(3).aver = mean(metrics(index).hvSetStrut(3).hvSets, 2);
    metrics(index).hvSetStrut(4).aver = mean(metrics(index).hvSetStrut(4).hvSets, 2);
    metrics(index).hvSetStrut(5).aver = mean(metrics(index).hvSetStrut(5).hvSets, 2);
    
    metrics(index).hvSetStrut(1).var = std(metrics(index).hvSetStrut(1).hvSets, 0, 2);
    metrics(index).hvSetStrut(2).var = std(metrics(index).hvSetStrut(2).hvSets, 0, 2);
    metrics(index).hvSetStrut(3).var = std(metrics(index).hvSetStrut(3).hvSets, 0, 2);
    metrics(index).hvSetStrut(4).var = std(metrics(index).hvSetStrut(4).hvSets, 0, 2);
    metrics(index).hvSetStrut(5).var = std(metrics(index).hvSetStrut(5).hvSets, 0, 2);
end

save(['Analysis/',Algorithm,'.mat'],'Data','metrics');