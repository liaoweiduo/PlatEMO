clear;
Algorithm = 'FVEMOA_DR2';
fileName=['Analysis/', Algorithm, '.mat'];
load(fileName);
for index = 1:length(Data)
    if ~strcmp(Data(index).Algorithm, Algorithm)
        continue
    end
    Problem = Data(index).Problem;
    N = Data(index).N;
    M = Data(index).M;
    % find set in metrics
    
    if index == 1
        metrics = struct('Problem',Problem,'N',N,'M',M,'igdSetStrut',struct('indexSet',Data(1).indexSet,'igdSets',[]));
    end
    
    i = 1;
    while i <= length(metrics)
        if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).N, N) && strcmp(metrics(i).M, M)
            break
        end
        i = i + 1;
    end
    
    if i > length(metrics) % first set
        metrics(i) = struct('Problem',Problem,'N',N,'M',M,'igdSetStrut',struct('indexSet',Data(1).indexSet,'igdSets',[]));
    end
    
    metrics(i).igdSetStrut.igdSets(:,size(metrics(i).igdSetStrut.igdSets,2)+1) = Data(index).igdSet;

end

for index = 1:length(metrics)
    metrics(index).igdSetStrut.aver = mean(metrics(index).igdSetStrut.igdSets, 2);
    metrics(index).igdSetStrut.var = std(metrics(index).igdSetStrut.igdSets, 0, 2);
end

save(['Analysis/',Algorithm,'.mat'],'Data','metrics');
