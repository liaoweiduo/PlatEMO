clear;
Algorithm = 'HypE';
Problem = 'DTLZ1';
N = '100';
M = '3';
D = '7';
run = '1';
Path = ['Data/', Algorithm, '/', Algorithm, '_', Problem, '_N', N, '_M', ...
    M, '_D', D, '_', run, '.mat'];
load(Path);
% 
% eval(['algorithmHold=', '@', Algorithm, ';']);
% eval(['problemHold=', '@', Problem, ';']);
% 
% varargin = {'-algorithm', algorithmHold, '-problem', problemHold, '-N', ...
%     str2num(N), '-M', str2num(M), '-run', str2num(run)};
% Global = GLOBAL(varargin{:});

% ideal point; bsf ideal point - current ideal point; 
% bsf index; current evaluated number - bsf index;
indexSet = cell2mat(result(:,1));
len = length(indexSet);

ideal = zeros(len, str2double(M));
bsf_ideal = zeros(len, str2double(M));
bsf_ideal_point = zeros(1,str2double(M)) + 1000000;

nadir = zeros(len, str2double(M));
bsf_nadir = zeros(len, str2double(M));
bsf_nadir_point = zeros(1,str2double(M)) + 1000000;

% bsf_index = [];    % used in hv
generationSet = result(:,2);
for index = 1:length(generationSet)
    populationSet = generationSet{index};
    objectiveSet = populationSet.objs;
    % calculate ideal point index of each objective
    ideal(index,:) = min(objectiveSet);
    if sum(ideal(index,:)) < sum(bsf_ideal_point)
        bsf_ideal_point = ideal(index,:);
    end
    bsf_ideal(index,:) = bsf_ideal_point;
    
    % calculate nadir point index of each objective
    nadir(index,:) = max(objectiveSet);
    if sum(nadir(index,:)) < sum(bsf_nadir_point)
        bsf_nadir_point = nadir(index,:);
    end
    bsf_nadir(index,:) = bsf_nadir_point;
end

figure();
hold on
plot(indexSet, sum(bsf_ideal,2), 'LineWidth',2);
plot(indexSet, sum(bsf_nadir,2), 'LineWidth',2);
plot(indexSet, sum(nadir,2) - sum(bsf_nadir,2), 'LineWidth',5);
legend('bsf ideal', 'bsf nadir', 'nadir - bsf nadir');
