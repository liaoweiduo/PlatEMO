data = Arrhythmia;
filename='Data/Arrhythmia.dat';
fid = fopen(filename, 'w');
dataFormat = '%d';
for i = 2:size(data,1)
    dataFormat = [dataFormat,',%d'];
end

fprintf(fid, [dataFormat,'\n'],data(:,1));



