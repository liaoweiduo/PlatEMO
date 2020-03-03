data = [train;test];
cvmdlloss = zeros(1,100);
time = zeros(1,100);
for k = 1:100
    disp(k);
    tic
    Mdl = fitcknn(data(:,2:18),data(:,1),'NumNeighbors',k);
    time(k) = toc;
    cvmodel = crossval(Mdl);
    cvmdlloss(k) = kfoldLoss(cvmodel);
end

figure()
plot(cvmdlloss);
title('vehicle');
