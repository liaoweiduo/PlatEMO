%% draw pic of data  need data
clear
N = 200; M = 2; D = 30;
algorithm = 'MOEADPWV';
problem = 'ZDT2';
evaluation_index = 100;

figure()
hold on 
view(2)
title([algorithm,' ',problem,...
    ' N',int2str(N),' M',int2str(M),' D',int2str(D)]);
for run = 1:20
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet = result{evaluation_index, 2}.objs;
    Draw(objSet);
end

