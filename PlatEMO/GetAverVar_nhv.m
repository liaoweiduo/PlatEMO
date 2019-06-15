clear;
Algorithm = 'FVEMOA';
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
        metrics = struct('Problem',Problem,'N',N,'M',M,'nhvSetStrut',struct('indexSet',Data(1).indexSet,'nhvSets',[]));
    end
    
    i = 1;
    while i <= length(metrics)
        if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).N, N) && strcmp(metrics(i).M, M)
            break
        end
        i = i + 1;
    end
    
    if i > length(metrics) % first set
        metrics(i) = struct('Problem',Problem,'N',N,'M',M,'nhvSetStrut',struct('indexSet',Data(1).indexSet,'nhvSets',[]));
    end
    
    metrics(i).nhvSetStrut.nhvSets(:,size(metrics(i).nhvSetStrut.nhvSets,2)+1) = Data(index).nhvSet;

end

for index = 1:length(metrics)
    metrics(index).nhvSetStrut.aver = mean(metrics(index).nhvSetStrut.nhvSets, 2);
    metrics(index).nhvSetStrut.var = std(metrics(index).nhvSetStrut.nhvSets, 0, 2);
end

save(['Analysis/',Algorithm,'.mat'],'Data','metrics');
