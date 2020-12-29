data = [test;train];
filename='data.dat';
fid = fopen(filename, 'w');
dataFormat = '%d';
for i = 1:617
    dataFormat = [dataFormat,',%d'];
end
for row = 1:size(data,1)
    fprintf(fid, [dataFormat,'\n'],data(row,:));
end