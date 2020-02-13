AlgorithmName = 'Hillvalley';
load(['/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Data/',AlgorithmName,'_evaluationTime.mat']);
Algorithm = Hillvalley;

figure()
hold on
plot(1:size(Algorithm,1),Algorithm(:,1))
xlabel('number of features')
ylabel('average computation time')