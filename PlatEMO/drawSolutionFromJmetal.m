clear

figure()
hold on 
view(2)

% load("~/jMetal/FUN.tsv");

FUN = load('~/jMetal/Experiments/FeatureSelectionReImplementation/data/MOEAD/Musk1/FUN0.tsv');
FrontNo    = NDSort(FUN,inf);
objChoose = FUN(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'-^','LineWidth',2,'MarkerSize',10);

FUN = load('~/jMetal/Experiments/FeatureSelectionReImplementation/data/NSGAII/Musk1/FUN0.tsv');
FrontNo    = NDSort(FUN,inf);
objChoose = FUN(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'-x','LineWidth',2,'MarkerSize',10);

FUN = load('~/jMetal/Experiments/FeatureSelectionReImplementation/data/SPEA2/Musk1/FUN0.tsv');
FrontNo    = NDSort(FUN,inf);
objChoose = FUN(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'-+','LineWidth',2,'MarkerSize',10);

FUN = load('~/jMetal/Experiments/FeatureSelectionReImplementation/data/MOEAD-STAT/Musk1/FUN1.tsv');
FrontNo    = NDSort(FUN,inf);
objChoose = FUN(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
plot(objChoose(:,1),objChoose(:,2),'-*','LineWidth',2,'MarkerSize',10);


legend('MOEA/D','NSGAII','SPEA2','MOEA/D-STAT');