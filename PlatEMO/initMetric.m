%% parameter sets
rootPath = 'Data/';
Algorithms = {'FVEMOA_DR','FVEMOA_optimal','FVEMOA_DR2'};

%% load data
for algorithm_index = 1:length(Algorithms)
    algorithm = Algorithms{algorithm_index};
    list=dir(fullfile(rootPath,algorithm));
    fileNum=size(list,1)-2; 
    Dataindex = 1;
    for k=3:fileNum+2
        filename = list(k).name;
        fileName = fullfile(rootPath,algorithm,filename);
        load(fileName);
        metric_t.runtime = metric.runtime;
        metric = metric_t;
        save(fileName,'result','metric');
    end
end