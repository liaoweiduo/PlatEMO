clear
obj.Global.D = 14;

fid = fopen('australian.dat','rt');
FormatString='';
for i = 1:obj.Global.D
    FormatString = [FormatString, '%f '];
end
FormatString = [FormatString, '%f'];
n=690;%读取数据的行数
data_all=textscan(fid,FormatString,n); %以逗号为数据的分隔符
fclose(fid);
data = cell2mat([ data_all(end),data_all(1:end-1)]);


file = fullfile(fileparts(mfilename('fullpath')),'vehicle.mat');
save(file,'data');