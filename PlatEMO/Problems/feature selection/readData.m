clear
obj.Global.D = 617;

fid = fopen('isolet1+2+3+4.data','rt');
FormatString='';
for i = 1:obj.Global.D
    FormatString = [FormatString, '%f '];
end
FormatString = [FormatString, '%f'];
n=6238;%读取数据的行数
data_all=textscan(fid,FormatString,n,'delimiter',','); %以逗号为数据的分隔符
fclose(fid);
data = cell2mat([data_all(end),data_all(1:end-1)]);
fid = fopen('isolet5.data','rt');
FormatString='';
for i = 1:obj.Global.D
    FormatString = [FormatString, '%f '];
end
FormatString = [FormatString, '%f'];
n=1559;%读取数据的行数
data_all=textscan(fid,FormatString,n,'delimiter',','); %以逗号为数据的分隔符
fclose(fid);
data = [data;cell2mat([data_all(end),data_all(1:end-1)])];


file = fullfile(fileparts(mfilename('fullpath')),'vehicle.mat');
save(file,'data');