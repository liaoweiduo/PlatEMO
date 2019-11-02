%% draw pic of data  need data
clear
N = 100; M = 3; D = 12;
algorithm = 'SMSEMOA_SS2';
problem = 'DTLZ3';
evaluation_index = 100;

figure()
hold on 
view(3)
title([algorithm,' ',problem,...
    ' N',int2str(N),' M',int2str(M),' D',int2str(D)]);
for run = 1:1
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet = result{evaluation_index, 2}.objs;
    Draw(objSet);
end

