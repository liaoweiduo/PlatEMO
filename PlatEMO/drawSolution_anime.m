figure

for i = 1:100
    objSet = result{i,2}.objs;
    clf
    title(['evaluation:',num2str(i*500)])
    Draw(objSet);
    xrag = xlim;
    yrag = ylim;
    if yrag(1) < 1 
        ylim([0,yrag(2)]);
    end
    if xrag(1) <1
        xlim([0,xrag(2)]);
    end
    pause(0.05)
end