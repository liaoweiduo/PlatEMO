Problem = 'C1_DTLZ1';
M = '3';
run = '1';
window = 10;

for i = 1:length(Data)
    data = Data(i);
    if strcmp(data.Problem,Problem) && strcmp(data.M,M) && strcmp(data.run,run)
        indexSet = data.indexSet;
        len = length(indexSet);
        hvSet = data.hvSet;
        nadirSet = data.nadirSet;
        nadirSet_y = mean(log(nadirSet),2);
        nadirSet_y_bsf = zeros(len,1);
        bsf = 100;
        for index = 1:len
            bsf = min(bsf, nadirSet_y(index));
            nadirSet_y_bsf(index) = bsf;
        end
        
        ab = zeros(len,2);
        for index = window:len
            xi = indexSet(index - window + 1:index);
            yi = nadirSet_y_bsf(index - window + 1:index);
            tmp = [xi'*xi, sum(xi); sum(xi), window] \ [xi'*yi;sum(yi)]; %[b;a] 
            ab(index,:)=[tmp(2),tmp(1)];
        end
    
        
        figure()
        [AX,H1,H2] = plotyy(indexSet,[nadirSet_y,nadirSet_y_bsf],indexSet,hvSet,'plot');
        set(get(AX(1),'Ylabel'),'String','ln(nadir) mean')
        set(get(AX(2),'Ylabel'),'String','hv')
        title([Problem, ' M', M, ' run', run])
        
        figure()
        hold on
%         plot(indexSet, nadirSet_y)
        scatter(indexSet, ab(:,2))
        ylabel('b')
        title([Problem, ' M', M, ' run', run])
        
    end
end