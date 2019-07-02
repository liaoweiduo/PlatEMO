function [r] = CalR(Rinit,Rfinal,win,threshold,evaluate_num,nadir_list,n)
    window = win / n;
    % win is base on evaluted num, window based on nadir list calculation
    if size(nadir_list,1) < window
        r = Rinit;
        return
    end
    
    nadirSet_y = mean(log(nadir_list(end - window + 1:end, :)),2);
    nadirSet_y_bsf = zeros(window,1);
    bsf = 10000;
    for index = 1:window
        bsf = min(bsf, nadirSet_y(index));
        nadirSet_y_bsf(index) = bsf;
    end

    % linear regression a + bx
    ab = zeros(1,2);
    xi = evaluate_num(end - window + 1:end)';
    yi = nadirSet_y_bsf;
    tmp = [xi'*xi, sum(xi); sum(xi), window] \ [xi'*yi;sum(yi)]; %[b;a] 
    ab = [tmp(2),tmp(1)];
    
    b = ab(2);
    if abs(b) < threshold
        r = Rfinal;
    else
        r = Rinit;
    end
end