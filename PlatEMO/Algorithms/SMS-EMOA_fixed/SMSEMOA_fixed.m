function SMSEMOA_fixed(Global)
% <algorithm> <O-Z>
% An EMO Algorithm Using the Hypervolume Measure as Selection Criterion

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Generate random population
    Population = Global.Initialization();
    FrontNo    = NDSort(Population.objs,inf);
    %% init Ma(Pascal's triangle)
    %   find Ma(H+M,M)<n<Ma(H+M+1,M)
    disp(['disp M N:', num2str(Global.M),' ', num2str(Global.N)]);
    yh = zeros(1, Global.M);
    yh(1) = 1;
    Ma = yh;
    maxNum = 0;
    while maxNum < Global.N
        yh = [yh,0]+[0,yh];
        Ma = [Ma;yh(1:Global.M)];
        maxNum = yh(Global.M);
    end
    disp('disp Ma: ');
    disp(Ma);
    %% Calculate H from N and M based on Ma
    M = Global.M;
    N = Global.N;
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
    disp(['H = ', num2str(H)]);
    %% Optimization
    while Global.NotTermination(Population)
        for i = 1 : Global.N
            drawnow();
            Offspring = Global.Variation(Population(randperm(Global.N,2)),1);
            
            r = 1 + 1/H;
%             if mod(Global.evaluated, 1000) == 0 
%                 disp(['r = ', num2str(r)]);
%             end
            
            [Population,FrontNo] = Reduce([Population,Offspring],FrontNo, r);
        end
    end
end