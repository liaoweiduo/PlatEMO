M = 2;
num_vec = 10;
[W1,num_vec] = UniformPoint(num_vec, M);
W1 = W1./repmat(sqrt(sum(W1.^2, 2)),1,M);
W2 = (1 - a) .* W1 + a .* (1/sqrt(M)) .* ones(1,M);
W2 = W2./ sqrt(sum(W2.^2,2));
figure
Draw(W1)
xlim([0,1])
ylim([0,1])
for i = 1:num_vec
    plot3([0,W1(i,1)],[0,W1(i,2)],[0,W1(i,3)],'-k'); 
end
figure
Draw(W2)
xlim([0,1])
ylim([0,1])
for i = 1:num_vec
    plot3([0,W2(i,1)],[0,W2(i,2)],[0,W2(i,3)],'-k'); 
end
set(gca,'FontSize',40);