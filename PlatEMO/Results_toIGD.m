clear
Algorithm = 'MOEADPWV';
PathRoot=['Data/', Algorithm, '/'];
for run = 1:20
    filename = [Algorithm,'_ZDT1_N200_M2_D30_',num2str(run),'.mat'];

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

    clc;disp(['IGD calculation: ', filename]);

    load(strcat(PathRoot, filename));
    indexSet = cell2mat(result(:,1));
    generationSet = result(:,2);
    for index = 1:length(generationSet)
        populationSet = generationSet{index};
        objectiveSet = populationSet.objs;
        result(index,4) = {IGD(objectiveSet, PF)};
    end
    save([PathRoot,filename],'result','metric');
end