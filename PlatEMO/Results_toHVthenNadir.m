clear;
Algorithm = 'HypE';
PathRoot=['Data_processed/', Algorithm, '/'];
list=dir(fullfile(PathRoot));
fileNum=size(list,1)-2; 
for k=3:fileNum+2
    filename = list(k).name;
    
    clc;disp(['nadir calculation: ', filename ', file index ', int2str(floor((k-2)/fileNum*100)), '%, ',...
        int2str(k-2), 'file']);
    load(strcat(PathRoot, filename));
    
    generationSet = result(:,2);
    for index = 1:length(generationSet)
        populationSet = generationSet{index};
        objectiveSet = populationSet.objs;
        % save the nadir point of each generation
        result(index,4) = {max(objectiveSet)};
    end
    
    save([PathRoot,filename],'result','metric');
end
