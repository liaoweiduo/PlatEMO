clear;
Problem = 'MaF1';
N = '100';
M = '10';
load('Analysis/FVEMOA.mat');
for i = 1:size(metrics,2)
    if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
        indexSet = metrics(i).hvSetStrut.indexSet;
        hvList = metrics(i).hvSetStrut.aver;
        nhvSet_2 = [];
        maxValue = max(hvList);
        minValue = min(hvList);
        nhvSet_2 = (hvList - minValue) / (maxValue - minValue);
        break
    end
end

load('Analysis/FVEMOA_optimal.mat');
for i = 1:size(metrics,2)
    if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
        indexSet = metrics(i).hvSetStrut.indexSet;
        hvList = metrics(i).hvSetStrut.aver;
        nhvSet_optimal = [];
        maxValue = max(hvList);
        minValue = min(hvList);
        nhvSet_optimal = (hvList - minValue) / (maxValue - minValue);
        break
    end
end

fig = figure('Visible', 'on');
hold on
p0=plot(indexSet, nhvSet_2);
p1=plot(indexSet, nhvSet_optimal);
legend([p0,p1],'2','optimal');
title([Problem,', M', M]);
xlabel('evaluation');
ylabel('NHV');