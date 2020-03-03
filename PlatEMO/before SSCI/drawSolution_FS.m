
clear
N = 180; M = 3; D = 19;
problem = 'vehicle_k';
evaluation_index = 100;
runs = 2;

figure() 
hold on 
view(3)
title([problem,...
    ' N',int2str(N),' evaluation',int2str(evaluation_index * 1000)]);

algorithm = 'MOEAD';
N=171;
objSet = zeros(N*runs,M);
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
scatter3(objChoose(:,1),objChoose(:,2),objChoose(:,3),100,'g^');


algorithm = 'MOEADFS';
N=180;
objSet = zeros(N*runs,M);
for run = 1:2
    readPath = fullfile('Data',algorithm,[algorithm,'_',problem,...
        '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
    load(readPath);
    objSet((run-1)*N+1:run*N,:) = result{evaluation_index, 2}.objs;
end
objSet = unique(objSet, 'rows');
objSet_2 = unique(objSet(:,2));
objChoose = [];
for i = 1:size(objSet_2,1)
    xValue = objSet_2(i);
    objSet2 = objSet(objSet(:,2) == xValue,:);
    FrontNo    = NDSort(objSet2,inf);
    choose = objSet2(FrontNo==1,:);
    objChoose(end+1:end+size(choose,1),:) = choose;
end
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
scatter3(objChoose(:,1),objChoose(:,2),objChoose(:,3),100,'c*');


algorithm = 'NSGAII';
objSet = zeros(N*runs,M);
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
scatter3(objChoose(:,1),objChoose(:,2),objChoose(:,3),100,'mx');


algorithm = 'SPEA2';
objSet = zeros(N*runs,M);
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
scatter3(objChoose(:,1),objChoose(:,2),objChoose(:,3),100,'b+');

legend('MOEA/D','MOEA/D-FS','NSGAII','SPEA2')
xlabel('fRatio');
ylabel('kRatio');
zlabel('eRate');