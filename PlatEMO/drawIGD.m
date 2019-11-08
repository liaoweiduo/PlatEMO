%% draw pic of data  need data
clear
N = 200; M = 2; D = 500;
problem = 'OMZM';
totalrun = 20;

figure()
hold on 
title(['IGD: ', problem,...
    ' N',int2str(N),' M',int2str(M),' D',int2str(D)]);

IGDSets = [];

algorithm = 'MOEAD';
for run = 1:totalrun
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run) = cell2mat(result(:,4));
end

algorithm = 'MOEADPWV';
for run = 1:totalrun
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run+totalrun) = cell2mat(result(:,4));
end


plot(indexSet, mean(IGDSets(:,1:totalrun),2),'r');
plot(indexSet, mean(IGDSets(:,totalrun+1:2*totalrun),2),'b');
set(gca,'yscale','log')
grid on
legend('MOEAD','MOEADPWV')

