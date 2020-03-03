clear

exper = 1;

algorithm = 'npMOEAD-FS-2';
problem = 'Bankruptcy';
RUN = '1';

figure
for i = 0:19
    
    if exper == 1
        data = load(['~/jMetal/Experiments/ParallelMOEADFeatureSelection/data/',algorithm,'/',problem,'/RS',RUN,'/FUN',num2str(i),'.tsv']);
    elseif exper == 0
        data = load(['~/jMetal/Data/FUN_',num2str(i),'.tsv']);
    end
    
    FrontNo    = NDSort(data,inf);
    objChoose = data(FrontNo==1,:);
    objChoose = unique(objChoose, 'rows');
    if objChoose(1,1) == 0
        objChoose = objChoose(2:end,:);
    end
    
    objSet = data;   % or objChoose or data
    clf
    title([algorithm,' ',problem,' ',RUN,' iteration:',num2str(i*10)])
    Draw(objSet);
    xrag = xlim;
    yrag = ylim;
    if yrag(1) < 1 
        ylim([0,yrag(2)]);
    end
%     if xrag(1) <1
%         xlim([0,xrag(2)]);
%     end
    xlim([0,1]);
%     ylim([0,1]);
    pause(0.5)
%     pause(1)
end

if exper == 1
    data = load(['~/jMetal/Experiments/ParallelMOEADFeatureSelection/data/',algorithm,'/',problem,'/FUN',RUN,'.tsv']);
elseif exper == 0
    data = load('~/jMetal/Data/FUN.tsv');
end

FrontNo    = NDSort(data,inf);
objChoose = data(FrontNo==1,:);
objChoose = unique(objChoose, 'rows');
if objChoose(1,1) == 0
    objChoose = objChoose(2:end,:);
end
    
objSet = data;   % or objChoose or data
clf
title([algorithm,' ',problem,' ',RUN,' iteration:',num2str((i+1)*10)])
Draw(objSet);
xrag = xlim;
yrag = ylim;
if yrag(1) < 1 
    ylim([0,yrag(2)]);
end
% if xrag(1) <1
%     xlim([0,xrag(2)]);
% end

xlim([0,1]);
% ylim([0,1]);
