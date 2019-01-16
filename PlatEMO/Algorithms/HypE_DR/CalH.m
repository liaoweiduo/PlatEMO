function [ H ] = CalH( N, M )
%  calculate H
%

    %% init Ma(Pascal's triangle)
    %   find Ma(H+M,M)<n<Ma(H+M+1,M)
    yh = zeros(1, M);
    yh(1) = 1;
    Ma = yh;
    maxNum = 0;
    while maxNum < N
        yh = [yh,0]+[0,yh];
        Ma = [Ma;yh(1:M)];
        maxNum = yh(M);
    end
    %% Calculate H from N and M based on Ma
    Maj = Ma(:,M);
    H = 0;
    for n = M:size(Maj,1)
        if Maj(n) >= N
            H = n - M;
            break;
        end
    end
    if H == 0
        H = 1;
    end
end

