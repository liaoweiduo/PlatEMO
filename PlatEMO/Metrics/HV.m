function Score = HV(PopObj,PF)
% <metric> <max>
% Hypervolume

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    [N,M]    = size(PopObj);
    RefPoint = (max(PF,[],1) - min(PF,[],1))*2 + min(PF,[],1);
    PopObj(any(PopObj>repmat(RefPoint,N,1),2),:) = [];
    if isempty(PopObj)
        Score = 0;
    elseif M<=10
        Score = stk_dominatedhv(PopObj,RefPoint);
    else
        % Estimate the HV value by Monte Carlo estimation
        SampleNum = 1000000;
        MaxValue  = RefPoint;
        MinValue  = min(PopObj,[],1);
        Samples   = unifrnd(repmat(MinValue,SampleNum,1),repmat(MaxValue,SampleNum,1));
        if gpuDeviceCount > 0
            % GPU acceleration
            Samples = gpuArray(single(Samples));
            PopObj  = gpuArray(single(PopObj));
        end
        for i = 1 : size(PopObj,1)
            drawnow();
            domi = true(size(Samples,1),1);
            m    = 1;
            while m <= M && any(domi)
                domi = domi & PopObj(i,m) <= Samples(:,m);
                m    = m + 1;
            end
            Samples(domi,:) = [];
        end
        Score = prod(MaxValue-MinValue)*(1-size(Samples,1)/SampleNum);
    end
end
