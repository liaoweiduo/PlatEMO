
clear
N = 200; M = 2; D = 500;
problem = 'madelon';
evaluation_index = 20;
runs = 2;
objSet = zeros(N*runs,M);

figure()
hold on 
view(2)
title([problem,...
    ' N',int2str(N),' evaluation',int2str(evaluation_index * 1000)]);

algorithm = 'MOEAD';
for run = 1:2
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet((run-1)*N+1:run*N,:) = result{evaluation_index, 2}.objs;
end
FrontNo    = NDSort(objSet,inf);
objChoose = objSet(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'g-^','LineWidth',2,'MarkerSize',10);


algorithm = 'MOEADSTAT';
for run = 1:2
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet((run-1)*N+1:run*N,:) = result{evaluation_index, 2}.objs;
end
FrontNo    = NDSort(objSet,inf);
objChoose = objSet(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'c-*','LineWidth',2,'MarkerSize',10);


algorithm = 'NSGAII';
for run = 1:2
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet((run-1)*N+1:run*N,:) = result{evaluation_index, 2}.objs;
end
FrontNo    = NDSort(objSet,inf);
objChoose = objSet(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'m-x','LineWidth',2,'MarkerSize',10);


algorithm = 'SPEA2';
for run = 1:2
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet((run-1)*N+1:run*N,:) = result{evaluation_index, 2}.objs;
end
FrontNo    = NDSort(objSet,inf);
objChoose = objSet(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'b-+','LineWidth',2,'MarkerSize',10);

legend('MOEA/D','MOEA/D-STAT','NSGAII','SPEA2')