Algorithm = 'FVEMOA_DR';
fileName=['Analysis/', Algorithm, '.mat'];
load(fileName);

Problem = 'C1_DTLZ1';
N = '100';
M = '3';

find([Data.Problem]==Problem&[Data.N]==N&[Data.M]==M)

    metrics(find([metrics.Problem] == Problem && [metrics.N] == N && [metrics.M] == M))

    hvSetStrut = struct('level',{-1,-0.5,0,0.5,1},'Rinit',2,'indexSet',Data(1).indexSet,'hvSets',[]);

for index = 1:length(Data)
    if (Data(index).run <= '5')
        hvSetStrut(1).hvSets(:,size(hvSetStrut(1).hvSets,2)+1) = Data(index).hvSet;
    elseif (Data(index).run > '5' && Data(index).run <= '10')
        hvSetStrut(2).hvSets(:,size(hvSetStrut(2).hvSets,2)+1) = Data(index).hvSet;
    elseif (Data(index).run > '10' && Data(index).run <= '15')
        hvSetStrut(3).hvSets(:,size(hvSetStrut(3).hvSets,2)+1) = Data(index).hvSet;
    elseif (Data(index).run > '15' && Data(index).run <= '20')
        hvSetStrut(4).hvSets(:,size(hvSetStrut(4).hvSets,2)+1) = Data(index).hvSet;
    elseif (Data(index).run > '20' && Data(index).run <= '25')
        hvSetStrut(5).hvSets(:,size(hvSetStrut(5).hvSets,2)+1) = Data(index).hvSet;
    end
end

% aver = mean(hvSets, 2);
% var = std(hvSets, 0, 2);
% errorbar(indexSet, aver, var);