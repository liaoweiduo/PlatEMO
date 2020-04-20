clear;

problems = {@DTLZ1};
algorithms = {@HypEr13_12s1,@HypEr13_12s3,@HypEr13_12s5;...
              @HypEr2s1,@HypEr2s3,@HypEr2s5;...
              @HypEr5s1,@HypEr5s3,@HypEr5s5};
M = [3];  

Means = [];
Stds = [];
resultIndex = [10000, 30000, 50000];

figure()
hold on

m = M(1);
problem = problems{1};
for i = 1:size(algorithms,1)
    for j = 1:size(algorithms,2)
        algorithm = algorithms{i,j};

        fprintf('start %d of %d... %s\n', i, size(algorithms,2), [func2str(algorithm),'_',func2str(problem),'_M',num2str(m)]);

        files = dir(fullfile('Data',func2str(algorithm),...
            [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));

        Metrics = [];
        for fileIndex = 1:size(files,1)
            file = files(fileIndex);
            filename = fullfile(file.folder, file.name);
            load(filename,"metric");
            Metrics(fileIndex) = metric.runtime;
        end

        Means(i,j) = mean(Metrics);
        Stds(i,j) = std(Metrics); 
    end
end
plot(resultIndex,Means','LineWidth',3);
legend('r=13/12','r=2','r=5')