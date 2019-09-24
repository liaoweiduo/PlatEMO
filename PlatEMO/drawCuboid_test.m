algorithm = @SMSEMOA;
problem = @DTLZ7;
N = 100;
varargin = {'-algorithm', algorithm, '-problem', problem, '-N', N, '-run', 1};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(100);
ref = (max(PF)-min(PF)) * 1.1 + min(PF);


% draw pic
figure();
hold on
for index = 1:length(PF)
    point = PF(index,:);
    drawCuboid(point,ref);
end

scatter3(PF(:,1),PF(:,2),PF(:,3),'ro')

view(3)
axis square
set(gca,'xdir','reverse');
set(gca,'ydir','reverse');
set(gca,'zdir','reverse');