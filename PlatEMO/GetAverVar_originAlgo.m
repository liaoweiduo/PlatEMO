Algorithm = 'SMSEMOA';
fileName=['Analysis/', Algorithm, '.mat'];
load(fileName);
for index = 1:length(Data)
    Problem = Data(index).Problem;
    N = Data(index).N;
    M = Data(index).M;
    % find set in metrics
    
    if index == 1
        metrics = struct('Problem',Problem,'N',N,'M',M,'hvSetStrut',struct('indexSet',Data(1).indexSet,'hvSets',[]));
    end
    
    i = 1;
    while i <= length(metrics)
        if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).N, N) && strcmp(metrics(i).M, M)
            break
        end
        i = i + 1;
    end
    
    if i > length(metrics) % first set
        metrics(i) = struct('Problem',Problem,'N',N,'M',M,'hvSetStrut',struct('indexSet',Data(1).indexSet,'hvSets',[]));
    end
    
    metrics(i).hvSetStrut.hvSets(:,size(metrics(i).hvSetStrut.hvSets,2)+1) = Data(index).hvSet;

end

for index = 1:length(metrics)
    metrics(index).hvSetStrut.aver = mean(metrics(index).hvSetStrut.hvSets, 2);
    metrics(index).hvSetStrut.var = std(metrics(index).hvSetStrut.hvSets, 0, 2);
end

save(['Analysis/',Algorithm,'.mat'],'Data','metrics');
