data = [train;test];
cvmdlloss = zeros(1,100);
time = zeros(1,100);
for k = 1:100
    tic
    Mdl = fitcknn(data(:,2:10),data(:,1),'NumNeighbors',k);
    time(k) = toc;
    cvmodel = crossval(Mdl);
    cvmdlloss(k) = kfoldLoss(cvmodel);
end

figure()
plot(cvmdlloss);
title('isolet');