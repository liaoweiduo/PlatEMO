clear;
Algorithm = 'HypE_optimal';
PathRoot=['Data_processed/', Algorithm, '/'];
list=dir(fullfile(PathRoot));
fileNum=size(list,1)-2; 
Dataindex = 1;
for k=3:fileNum+2
    filename = list(k).name;
    
    clc;disp(['Data Struct collection: ', filename ', file index ', int2str(floor((k-2)/fileNum*100)), '%, ',...
            int2str(k-2), 'file']);
    
    load(strcat(PathRoot, filename));
    
    filename_temp = filename(length(Algorithm)+2:length(filename));
    Problem = filename_temp(1:strfind(filename_temp,'_N')-1);
    filename_temp = filename_temp(length(Problem)+3:length(filename_temp));
    N = filename_temp(1:strfind(filename_temp,'_M')-1);
    filename_temp = filename_temp(length(N)+3:length(filename_temp));
    M = filename_temp(1:strfind(filename_temp,'_D')-1);
    filename_temp = filename_temp(length(M)+3:length(filename_temp));
    run = filename_temp(strfind(filename_temp,'_')+1:strfind(filename_temp,'.mat')-1);
    
    runtime = metric.runtime;
    indexSet = cell2mat(result(:,1));
    hvSet = cell2mat(result(:,3));
    
    Data(Dataindex).Algorithm = Algorithm;
    Data(Dataindex).Problem = Problem;
    Data(Dataindex).N = N;
    Data(Dataindex).M = M;
    Data(Dataindex).run = run;
    Data(Dataindex).runtime = runtime;
    Data(Dataindex).indexSet = indexSet;
    Data(Dataindex).hvSet = hvSet;
    Data(Dataindex).finalHv = hvSet(end);
    Dataindex = Dataindex + 1;
end
[~,~]  = mkdir('Analysis');
save(['Analysis/',Algorithm,'.mat'],'Data');
