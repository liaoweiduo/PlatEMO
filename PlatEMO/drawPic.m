%% load data
Algorithm = 'FVEMOA_DR';
Problem = 'C1_DTLZ1';
M = '3';
rootPath = 'Analysis/';
fileName=[rootPath, Algorithm, '.mat'];
load(fileName);
for i = 1:length(metrics)
    if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
        break
    end
end
hvSetStrut = metrics(i).hvSetStrut;

%% draw picture
figure(1);
subplot(2,2,1);
% e1 = errorbar(hvSetStrut(1).indexSet, hvSetStrut(1).aver, hvSetStrut(1).var);
plot(hvSetStrut(1).indexSet, hvSetStrut(1).aver);
hold on
% e2 = errorbar(hvSetStrut(2).indexSet, hvSetStrut(2).aver, hvSetStrut(2).var);
plot(hvSetStrut(2).indexSet, hvSetStrut(2).aver);
hold on
% e3 = errorbar(hvSetStrut(3).indexSet, hvSetStrut(3).aver, hvSetStrut(3).var);
plot(hvSetStrut(3).indexSet, hvSetStrut(3).aver);
hold on
% e4 = errorbar(hvSetStrut(4).indexSet, hvSetStrut(4).aver, hvSetStrut(4).var);
plot(hvSetStrut(4).indexSet, hvSetStrut(4).aver);
hold on
% e5 = errorbar(hvSetStrut(5).indexSet, hvSetStrut(5).aver, hvSetStrut(5).var);
plot(hvSetStrut(5).indexSet, hvSetStrut(5).aver);
hold on
legend('-1','-0.5','0','0.5','1');
title([Algorithm,', ',Problem,', M', M]);
xlabel('Time');
ylabel('HV');

 %% load data
M = '5';
for i = 1:length(metrics)
    if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
        break
    end
end
hvSetStrut = metrics(i).hvSetStrut;

%% draw picture
subplot(2,2,2);
% e1 = errorbar(hvSetStrut(1).indexSet, hvSetStrut(1).aver, hvSetStrut(1).var);
plot(hvSetStrut(1).indexSet, hvSetStrut(1).aver);
hold on
% e2 = errorbar(hvSetStrut(2).indexSet, hvSetStrut(2).aver, hvSetStrut(2).var);
plot(hvSetStrut(2).indexSet, hvSetStrut(2).aver);
hold on
% e3 = errorbar(hvSetStrut(3).indexSet, hvSetStrut(3).aver, hvSetStrut(3).var);
plot(hvSetStrut(3).indexSet, hvSetStrut(3).aver);
hold on
% e4 = errorbar(hvSetStrut(4).indexSet, hvSetStrut(4).aver, hvSetStrut(4).var);
plot(hvSetStrut(4).indexSet, hvSetStrut(4).aver);
hold on
% e5 = errorbar(hvSetStrut(5).indexSet, hvSetStrut(5).aver, hvSetStrut(5).var);
plot(hvSetStrut(5).indexSet, hvSetStrut(5).aver);
hold on
legend('-1','-0.5','0','0.5','1');
title([Algorithm,', ',Problem,', M', M]);
xlabel('Time');
ylabel('HV');


 %% load data
M = '8';
for i = 1:length(metrics)
    if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
        break
    end
end
hvSetStrut = metrics(i).hvSetStrut;

%% draw picture
subplot(2,2,3);
% e1 = errorbar(hvSetStrut(1).indexSet, hvSetStrut(1).aver, hvSetStrut(1).var);
plot(hvSetStrut(1).indexSet, hvSetStrut(1).aver);
hold on
% e2 = errorbar(hvSetStrut(2).indexSet, hvSetStrut(2).aver, hvSetStrut(2).var);
plot(hvSetStrut(2).indexSet, hvSetStrut(2).aver);
hold on
% e3 = errorbar(hvSetStrut(3).indexSet, hvSetStrut(3).aver, hvSetStrut(3).var);
plot(hvSetStrut(3).indexSet, hvSetStrut(3).aver);
hold on
% e4 = errorbar(hvSetStrut(4).indexSet, hvSetStrut(4).aver, hvSetStrut(4).var);
plot(hvSetStrut(4).indexSet, hvSetStrut(4).aver);
hold on
% e5 = errorbar(hvSetStrut(5).indexSet, hvSetStrut(5).aver, hvSetStrut(5).var);
plot(hvSetStrut(5).indexSet, hvSetStrut(5).aver);
hold on
legend('-1','-0.5','0','0.5','1');
title([Algorithm,', ',Problem,', M', M]);
xlabel('Time');
ylabel('HV');


 %% load data
M = '10';
for i = 1:length(metrics)
    if strcmp(metrics(i).Problem, Problem) && strcmp(metrics(i).M, M)
        break
    end
end
hvSetStrut = metrics(i).hvSetStrut;

%% draw picture
subplot(2,2,4);
% e1 = errorbar(hvSetStrut(1).indexSet, hvSetStrut(1).aver, hvSetStrut(1).var);
plot(hvSetStrut(1).indexSet, hvSetStrut(1).aver);
hold on
% e2 = errorbar(hvSetStrut(2).indexSet, hvSetStrut(2).aver, hvSetStrut(2).var);
plot(hvSetStrut(2).indexSet, hvSetStrut(2).aver);
hold on
% e3 = errorbar(hvSetStrut(3).indexSet, hvSetStrut(3).aver, hvSetStrut(3).var);
plot(hvSetStrut(3).indexSet, hvSetStrut(3).aver);
hold on
% e4 = errorbar(hvSetStrut(4).indexSet, hvSetStrut(4).aver, hvSetStrut(4).var);
plot(hvSetStrut(4).indexSet, hvSetStrut(4).aver);
hold on
% e5 = errorbar(hvSetStrut(5).indexSet, hvSetStrut(5).aver, hvSetStrut(5).var);
plot(hvSetStrut(5).indexSet, hvSetStrut(5).aver);
hold on
legend('-1','-0.5','0','0.5','1');
title([Algorithm,', ',Problem,', M', M]);
xlabel('Time');
ylabel('HV');

%% save pic
savefig([rootPath, Algorithm, '_Problem.fig']);