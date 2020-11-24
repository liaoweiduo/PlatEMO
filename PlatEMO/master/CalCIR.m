function CIR = CalCIR(datas, W, r)
    count = 0;
    for di = 1:size(datas,2)
        points = datas{di};
        ref = r*(max(points,[],1)-min(points,[],1))+min(points,[],1);
        % rmpath('/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Algorithms/FVMOEA');
        rmpath('D:\Documents\MATLAB\PlatEMO\PlatEMO\Algorithms\FVMOEA');
        HVCval = CalHVC(points,ref,size(points,1));
        % addpath('/Users/liaoweiduo/Documents/MATLAB/PlatEMO/PlatEMO/Algorithms/FVMOEA');
        addpath('D:\Documents\MATLAB\PlatEMO\PlatEMO\Algorithms\FVMOEA');
        R2HCAval = CalR22(points,W,r); 
        
        [~,HVCi] = min(HVCval);
        [~,R2HCAi] = min(R2HCAval);
        if HVCi == R2HCAi 
            count = count+1;
        end
    end
    CIR = count / size(datas,2);
end