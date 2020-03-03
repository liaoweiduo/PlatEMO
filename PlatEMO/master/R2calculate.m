M = 3;
N = 91;
num_vec = 91;
rR2 = 2;
A = [0.7:0.02:0.8];
rHV = [2,50:50:300];

W = [];
HVCval = [];
R2HCAval = [];

[points,N] = UniformPoint(N, M);
points = 1-points;

for i = 1:size(A,2)
    a = A(i);
    [w,num_vec] = UniformPoint(num_vec, M);
    w = w./repmat(sqrt(sum(w.^2, 2)),1,M);
    w = (1 - a) .* w + a .* (1/sqrt(M)) .* ones(1,M);
    w = w./ sqrt(sum(w.^2,2));
    
    W(:,:,i) = w;
end

rmpath('/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Algorithms/FVMOEA');
for i = 1:size(rHV,2)
    r = rHV(i);
    ref = r*(max(points,[],1)-min(points,[],1))+min(points,[],1);
    HVCval(i,:) = CalHVC(points,ref,N);
end
addpath('/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Algorithms/FVMOEA');

for i = 1:size(A,2)
    R2HCAval(i,:) = CalR22(points,W(:,:,i),rR2);
end

HVCval = sort(HVCval,2);
R2HCAval = sort(R2HCAval,2);

figure()
hold on
plot(1:91,R2HCAval,'LineWidth',3);
legStr = cellfun(@num2str, num2cell(A),'UniformOutput',false);
for i = 1:size(legStr,2)
    legStr{i} = ['a = ',legStr{i}];
end
legend(legStr);
title(['R2HCA, r = ', num2str(rR2)]);

xlabel('Point index');
ylabel('Value');
set(gca,'FontSize',20);
set(gca, 'YScale', 'log');
grid on


figure()
hold on
plot(1:91,HVCval,'LineWidth',3);
legStr = cellfun(@num2str, num2cell(rHV),'UniformOutput',false);
for i = 1:size(legStr,2)
    legStr{i} = ['r = ',legStr{i}];
end
legend(legStr);
title('HV contribution');

xlabel('Point index');
ylabel('Value');
set(gca,'FontSize',20);
set(gca, 'YScale', 'log');
grid on


% R2val = [];
% R2valInd = 1;
% for r = [1.9,2.1]
%     R2val(R2valInd,:) = CalR22(points,W,r);
%     R2valInd = R2valInd + 1;
% end
% 
% R2dif = R2val(2,:)-R2val(1,:);
% R2same = R2dif > 0;
% prob = sum(R2same) / size(R2same,2);
