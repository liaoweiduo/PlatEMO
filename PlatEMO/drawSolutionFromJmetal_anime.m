
figure

for i = 0:19
    
    data = load(['~/jMetal/Data/FUN_',num2str(i),'.tsv']);
%     data = load(['~/jMetal/Experiments/GetData/data/aspMOEAD-FS-2/Vehicle/RS0/FUN',num2str(i),'.tsv']);
    
    FrontNo    = NDSort(data,inf);
    objChoose = data(FrontNo==1,:);
    objChoose = unique(objChoose, 'rows');
    if objChoose(1,1) == 0
        objChoose = objChoose(2:end,:);
    end
    
    objSet = data;   % or objChoose
    clf
    title(['iteration:',num2str(i*10)])
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

data = load('~/jMetal/Data/FUN.tsv');
% data = load(['~/jMetal/Experiments/GetData/data/aspMOEAD-FS-2/Vehicle/FUN0.tsv']);
objSet = data;   % or objChoose
clf
title(['iteration:',num2str((i+1)*10)])
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
