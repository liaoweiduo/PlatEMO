data = Bankruptcy(:,1);
featureNum = 64;
filename='Data/Bankruptcy.dat';

% fill in the data 
interval = 10;
datat = [];
for i = 1:featureNum
    l = floor((i-1)/interval) * interval + 1; 
    r = l + interval;
    if r > featureNum
        r = featureNum;
    end
    dl = data(floor(l / interval) + 1);
    dr = data(floor(r / interval) + 1);
    datat(i) = ((i-l) * dr + (r-i) * dl) / (r-l);
end
data = datat';

fid = fopen(filename, 'w');
dataFormat = '%d';
for i = 2:size(data,1)
    dataFormat = [dataFormat,',%d'];
end

fprintf(fid, [dataFormat,'\n'],data);



