function Population = CalHVC(Population,ref,numSel)
    data = Population.objs;
    ref = ref*max(data,[],1);
    
    [PopNum,~] = size(data);
    numDel = PopNum-numSel;

    HVC = zeros(1,PopNum);
    for i=1:PopNum
        data1 = data;
        s = data1(i,:);
        data1(i,:)=[];
        data1 = max(s,data1);       
        HVC(1,i) = prod(ref-s)-stk_dominatedhv(data1,ref);         
    end
    
    %Population=Population(1:numSel);
    
    for j=1:numDel  
        [~,worst] = min(HVC);
        s = data(worst,:);
        Population(worst) = [];   
        data(worst,:) = [];    
        HVC(worst) = [];
        if j==numDel
            break;
        end
        for i=1:(PopNum-j)
                data1 = data;
                k = data1(i,:);
                data1(i,:) = [];
                w = max(s,k);
                if isdominated(w,data1)
                    continue;
                else                    
                    data1 = max(w,data1);
                    HVC(1,i) = HVC(1,i) + prod(ref-w)-stk_dominatedhv(data1,ref);       
                end                 
        end       
    end
    
    function result = isdominated(s,data)
        data = s-data;
        data = data>0;
        data = prod(data,2);
        temp = sum(data);
        if temp>0
            result = true;
        else
            result = false;
        end
    end
end