algorithm = @SMSEMOA;
problem = @DTLZ2;
N = 100;
varargin = {'-algorithm', algorithm, '-problem', problem, '-N', N, '-run', 1};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(10);

maxValues = max(PF,[],1); 
minValues = min(PF,[],1); 
PF = (PF - minValues) ./ (maxValues - minValues); 

a = (1 - sum(PF,2)) ./ 3;
PF = PF + 1 * a; 

maxValues = max(PF,[],1); 
minValues = min(PF,[],1); 
PF = (PF - minValues) ./ (maxValues - minValues); 

ref = (max(PF)-min(PF)) * 4/3 + min(PF);


% draw pic
figure();
hold on
for index = 1:length(PF)
    point = PF(index,:);
    drawCuboid(point,ref);
end

scatter3(PF(:,1),PF(:,2),PF(:,3),3000,'k.')

view(3)
axis square
% xlabel('f_1', 'Fontname','Times New Roman', 'FontSize',12)
% ylabel('f_2', 'Fontname','Times New Roman', 'FontSize',12)
% zlabel('f_3', 'Fontname','Times New Roman', 'FontSize',12)

set(gca, 'linewidth',2,'fontsize',40)
% set(gca,'xdir','reverse');
% set(gca,'ydir','reverse');
set(gca,'zdir','reverse');
t=0:0:0;
set(gca,'xtick',t);
set(gca,'ytick',t);
set(gca,'ztick',t);

% saveas(gca,fullfile('Analysis','master','distribution','fig',...
%     'RPS_concave.eps'),'eps');
