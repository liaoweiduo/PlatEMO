M = 3;
N = 91;
num_vec = 91;
mode = 1;

probs = [];
for run = 1:5
    if mode == 1
        [W,num_vec] = UniformVector(num_vec, M);
    elseif mode == 2
        [W,num_vec] = UniformPoint(num_vec, M);
        W = W./repmat(sqrt(sum(W.^2,2)),1,M);
    else
        [W,~] = UniformVector(num_vec-M, M);
        W = [W;eye(M)];
    end

    [points,N] = UniformPoint(N, M);
    points = 1-points;

    R2val = [];
    R2valInd = 1;
    for r = [1.9,2.1]
        R2val(R2valInd,:) = CalR22(points,W,r);
        R2valInd = R2valInd + 1;
    end

    R2dif = R2val(2,:)-R2val(1,:);
    R2same = R2dif > 0;
    probs(run) = sum(R2same) / size(R2same,2);
end
