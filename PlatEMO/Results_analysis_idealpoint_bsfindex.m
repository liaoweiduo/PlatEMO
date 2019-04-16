clear;
Algorithm = 'HypE';
Problem = 'DTLZ1';
N = '100';
M = '3';
D = '7';
run = '1';
Path = ['Data/', Algorithm, '/', Algorithm, '_', Problem, '_N', N, '_M', M, '_D', D, '_', run, '.mat'];
load(Path);

eval(['algorithmHold=', '@', Algorithm, ';']);
eval(['problemHold=', '@', Problem, ';']);

varargin = {'-algorithm', algorithmHold, '-problem', problemHold, '-N', str2num(N), '-M', str2num(M), '-run', str2num(run)};
Global = GLOBAL(varargin{:});

% ideal point; bsf ideal point - current ideal point; 
% bsf index; current evaluated number - bsf index
ideal = [];
bsf_ideal = [];
bsf_index = [];
indexSet = cell2mat(result(:,1));
generationSet = result(:,2);
hvSet = result(:,3);
for index = 1:length(generationSet)
    populationSet = generationSet{index};
    objectiveSet = populationSet.objs;
    result(index,3) = {HV(objectiveSet, PF)};
end
