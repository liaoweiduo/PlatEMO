%% draw pic of data  need data
clear
N = 100; M = 3; D = 12;
problem = 'DTLZ2';
totalrun = 10;

figure()
hold on 
title(['IGD: ', problem,...
    ' N',int2str(N),' M',int2str(M),' D',int2str(D)]);

IGDSets = [];

algorithm = 'SMSEMOA';
for run = 1:totalrun
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run) = cell2mat(result(:,4));
end

algorithm = 'SMSEMOA_SS2_c1';
for run = 1:totalrun
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run+totalrun) = cell2mat(result(:,4));
end


algorithm = 'SMSEMOA_SS2';
for run = 1:totalrun
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run+2*totalrun) = cell2mat(result(:,4));
end


plot(indexSet, mean(IGDSets(:,1:totalrun),2),'r');
plot(indexSet, mean(IGDSets(:,totalrun+1:2*totalrun),2),'b');
plot(indexSet, mean(IGDSets(:,2*totalrun+1:3*totalrun),2),'k');
set(gca,'yscale','log')
grid on
legend('SMSEMOA','SMSEMOA_SS2 without c','SMSEMOA_SS2 with c')
