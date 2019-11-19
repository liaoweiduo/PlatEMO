clear
obj.Global.D = 500;

fid = fopen('madelon_train.data','rt');
FormatString='';
for i = 1:obj.Global.D
    FormatString = [FormatString, '%f '];
end
% FormatString = [FormatString, '%s'];
n=2000;%读取数据的行数
data_all=textscan(fid,FormatString,n,'delimiter',' '); %以逗号为数据的分隔符
fclose(fid);
fid = fopen('madelon_train.labels','rt');
FormatString='%f';
class=textscan(fid,FormatString,n,'delimiter',' '); %以逗号为数据的分隔符
fclose(fid);
data = cell2mat([class,data_all]);

fid = fopen('madelon_valid.data','rt');
FormatString='';
for i = 1:obj.Global.D
    FormatString = [FormatString, '%f '];
end
% FormatString = [FormatString, '%s'];
n=600;%读取数据的行数
data_all=textscan(fid,FormatString,n,'delimiter',' '); %以逗号为数据的分隔符
fclose(fid);
fid = fopen('madelon_valid.labels','rt');
FormatString='%f';
class=textscan(fid,FormatString,n,'delimiter',' '); %以逗号为数据的分隔符
fclose(fid);
data = [data;cell2mat([class,data_all])];


file = fullfile(fileparts(mfilename('fullpath')),'vehicle.mat');
save(file,'data');