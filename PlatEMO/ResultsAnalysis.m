Algorithm = 'FVEMOA';
PathRoot=['/media/liao/Seagate BUP/hisao lab/Data/', Algorithm, '/'];
list=dir(fullfile(PathRoot));
fileNum=size(list,1)-2; 
% for k=3:fileNum
k = 3;
	filename = list(k).name;
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
    
    load(strcat(PathRoot, filename));
    runtime = metric.runtime;
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    parfor index = 1:length(generationSet)
        clc;disp(['HV calculation:', int2str(floor(index/length(generationSet)*100)), '%, ',...
            int2str(index), 'generations']);
        populationSet = generationSet{index};
        objectiveSet = populationSet.objs;
        
        varargin = {'-algorithm', algorithmHold, '-problem', problemHold, '-N', str2num(N), '-M', str2num(M), '-run', str2num(run)};

        Global = GLOBAL(varargin{:});
        PF = Global.problem.PF(10000);
        result(index,3) = {HV(objectiveSet, PF)};
    end
% end