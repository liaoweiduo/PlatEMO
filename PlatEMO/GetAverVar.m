Algorithm = 'FVEMOA_DR';
Problem = 'C1_DTLZ1';
N = '100';
M = '3';
fileName=['Analysis/', Algorithm, '.mat'];
load(fileName);

hvSetStrut(1).level = -1;
hvSetStrut(1).Rinit = 2;
hvSetStrut(1).indexSet = Data(1).indexSet;
hvSetStrut(1).hvSets = [];
hvSetStrut(2).level = -0.5;
hvSetStrut(2).Rinit = 2;
hvSetStrut(2).indexSet = Data(1).indexSet;
hvSetStrut(2).hvSets = [];
hvSetStrut(3).level = 0;
hvSetStrut(3).Rinit = 2;
hvSetStrut(3).indexSet = Data(1).indexSet;
hvSetStrut(3).hvSets = [];
hvSetStrut(4).level = 0.5;
hvSetStrut(4).Rinit = 2;
hvSetStrut(4).indexSet = Data(1).indexSet;
hvSetStrut(4).hvSets = [];
hvSetStrut(5).level = 1;
hvSetStrut(5).Rinit = 2;
hvSetStrut(5).indexSet = Data(1).indexSet;
hvSetStrut(5).hvSets = [];

for index = 1:length(Data)
    if (strcmp(Data(index).Algorithm, Algorithm) && strcmp(Data(index).Problem, Problem) && strcmp(Data(index).N, N) && strcmp(Data(index).M, M))
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
end

% aver = mean(hvSets, 2);
% var = std(hvSets, 0, 2);
% errorbar(indexSet, aver, var);