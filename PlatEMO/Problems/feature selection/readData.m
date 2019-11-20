clear
obj.Global.D = 649;

% fid = fopen('mfeat-fac','rt');
% FormatString='';
% for i = 1:obj.Global.D
%     FormatString = [FormatString, '%f '];
% end
% FormatString = [FormatString, '%f'];
% n=2000;%读取数据的行数
% data_all=textscan(fid,FormatString,n); %以逗号为数据的分隔符 ,'delimiter',','
% fclose(fid);
% data = cell2mat([ data_all(end),data_all(1:end-1)]);
% 
% 
% file = fullfile(fileparts(mfilename('fullpath')),'vehicle.mat');
% save(file,'data');

load mfeat-fac
load mfeat-fou
load mfeat-kar
load mfeat-mor
load mfeat-pix
load mfeat-zer

class = [zeros(200,1);ones(200,1);ones(200,1).*2;ones(200,1).*3;
ones(200,1).*4;ones(200,1).*5;ones(200,1).*6;ones(200,1).*7;
ones(200,1).*8;ones(200,1).*9];
data = [class,mfeat_fac,mfeat_fou,mfeat_kar,mfeat_mor,mfeat_pix,mfeat_zer];