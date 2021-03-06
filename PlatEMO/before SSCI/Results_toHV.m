clear;
Algorithm = 'HypE_optimal';
PathRoot=['Data_toprocess/', Algorithm, '/'];
list=dir(fullfile(PathRoot));
fileNum=size(list,1)-2; 
for k=3:fileNum+2
    filename = list(k).name;
    
    clc;disp(['HV calculation: ', filename ', file index ', int2str(floor((k-2)/fileNum*100)), '%, ',...
        int2str(k-2), 'file']);
    load(strcat(PathRoot, filename));
%     if (size(result,2) == 3) 
%         continue;
%     end
    
    filename_temp = filename(length(Algorithm)+2:length(filename));
    Problem = filename_temp(1:strfind(filename_temp,'_N')-1);
    filename_temp = filename_temp(length(Problem)+3:length(filename_temp));
    N = filename_temp(1:strfind(filename_temp,'_M')-1);
    filename_temp = filename_temp(length(N)+3:length(filename_temp));
    M = filename_temp(1:strfind(filename_temp,'_D')-1);
    filename_temp = filename_temp(length(M)+3:length(filename_temp));
    run = filename_temp(strfind(filename_temp,'_')+1:strfind(filename_temp,'.mat')-1);
    eval(['algorithmHold=', '@', Algorithm, ';']);
    eval(['problemHold=', '@', Problem, ';']);

    varargin = {'-algorithm', algorithmHold, '-problem', problemHold, '-N', str2num(N), '-M', str2num(M), '-run', str2num(run)};
    Global = GLOBAL(varargin{:});
    PF = Global.problem.PF(10000);

    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    parfor index = 1:length(generationSet)
        populationSet = generationSet{index};
        objectiveSet = populationSet.objs;
        result(index,3) = {HV(objectiveSet, PF)};
    end
    
    save([PathRoot,filename],'result','metric');
end
