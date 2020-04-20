rmpath('/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Algorithms/FVMOEA');
M = 3;
N = 91;
num_vec = 100;

[points,N] = UniformPoint(N, M);
points = 1-points;

% figure()
% Draw(points);
% set(gca,'FontSize',20);
% xlabel('');
% ylabel('');
% zlabel('');
% saveas(gca,fullfile('Analysis','master','distribution','fig','normalizedInvTriangular.eps'),'eps');

R2probs = [];
HVprobs = [];
for run = 1:11
    [w,num_vec] = UniformVector(num_vec, M);

    R2val = [];
    HVval = [];
    R2valInd = 1;
    for r = [5,5.1]
        R2val(R2valInd,:) = CalR22(points,w,r);
        ref = r*(max(points,[],1)-min(points,[],1))+min(points,[],1);
        HVval(R2valInd,:) = CalHVC(points,ref,size(points,1));
        R2valInd = R2valInd + 1;
    end

    R2dif = R2val(2,:)-R2val(1,:);
    R2same = R2dif > 0;
    R2probs(run) = sum(R2same) / size(R2same,2);

    HVdif = HVval(2,:)-HVval(1,:);
    HVsame = HVdif > 0;
    HVprobs(run) = sum(HVsame) / size(HVsame,2);
end

R2mean = mean(R2probs)
R2std  = std(R2probs)
HVmean = mean(HVprobs)
HVstd  = std(HVprobs)
addpath('/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Algorithms/FVMOEA');