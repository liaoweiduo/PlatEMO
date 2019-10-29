algorithm = @SMSEMOA;
problem = @DTLZ2;
N = 100;
varargin = {'-algorithm', algorithm, '-problem', problem, '-N', N, '-run', 1};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(49);

maxValues = max(PF,[],1); 
minValues = min(PF,[],1); 
PF = (PF - minValues) ./ (maxValues - minValues); 

a = (1 - sum(PF,2)) ./ 3;
PF = PF + 1 * a; 

maxValues = max(PF,[],1); 
minValues = min(PF,[],1); 
PF = (PF - minValues) ./ (maxValues - minValues); 

ref = (max(PF)-min(PF)) * 2 + min(PF);


% draw pic
figure();
hold on
for index = 1:length(PF)
    point = PF(index,:);
    drawCuboid(point,ref);
end

scatter3(PF(:,1),PF(:,2),PF(:,3),500,'r.')

view(3)
axis square
xlabel('f_1', 'Fontname','Times New Roman', 'FontSize',12)
ylabel('f_2', 'Fontname','Times New Roman', 'FontSize',12)
zlabel('f_3', 'Fontname','Times New Roman', 'FontSize',12)

set(gca, 'linewidth',2,'fontsize',30,'fontname','Times')
set(gca,'xdir','reverse');
set(gca,'ydir','reverse');
set(gca,'zdir','reverse');