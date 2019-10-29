%% draw pic of data  need data

N = 100; M = 3; D = 12;
problem = 'DTLZ3';

figure()
hold on 
title(['IGD: ', problem,...
    ' N',int2str(N),' M',int2str(M),' D',int2str(D)]);

IGDSets = [];

algorithm = 'SMSEMOA';
for run = 1:10
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run) = cell2mat(result(:,4));
end

algorithm = 'SMSEMOA_SS2';
for run = 1:10
    readPath = fullfile('Data','SMSEMOA_SS2 without c',[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run+10) = cell2mat(result(:,4));
end


algorithm = 'SMSEMOA_SS2';
for run = 1:10
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    IGDSets(:,run+20) = cell2mat(result(:,4));
end


plot(indexSet, mean(IGDSets(:,1:10),2),'r');
plot(indexSet, mean(IGDSets(:,11:20),2),'b');
plot(indexSet, mean(IGDSets(:,21:30),2),'k');
set(gca,'yscale','log')
grid on
legend('SMSEMOA','SMSEMOA_SS2_withou_c','SMSEMOA_SS2_with_c')

