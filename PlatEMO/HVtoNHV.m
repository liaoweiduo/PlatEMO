clear
% first load FVEMOA.mat
filename = 'Analysis/FVEMOA_optimal.mat';
load(filename);
for i = 1:size(Data,2)
    hvList = Data(i).hvSet;
    nhvList = [];
    maxValue = max(hvList);
    minValue = min(hvList);
    nhvList = (hvList - minValue) / (maxValue - minValue);
    Data(i).nhvSet = nhvList;
end
save(filename,'Data','metrics');