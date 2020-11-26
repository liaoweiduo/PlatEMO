function R2val = CalR22(data,W,r)
%% data need normalized
%% R2 for hvc approximation
    [PopNum,dim] = size(data);
    %dim = 10;
    R2val = zeros(1,PopNum);
    [row, ~] = size(W);
    
    for i=1:PopNum
        data1 = data;
        s = data1(i,:);
        data1(i,:)=[];
        
        if isempty(data1)
           data1 = 0; 
        end
            
        %%
        utilityPoints = zeros(PopNum-1,row);
        %matrix = zeros(PopNum+1,row);
        for j = 1:row
            currWeights = repmat(W(j,:), PopNum-1, 1);
            utilityPoints(:,j) = max((data1-s)./currWeights,[],2);
        end
        
        temp1 = min(abs(s-r)./W,[],2)';
        
        matrix = [utilityPoints;temp1];
        R2val(1,i) = sum((min(matrix)).^dim);
        
    end

end