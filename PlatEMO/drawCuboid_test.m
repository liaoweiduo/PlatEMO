algorithm = @SMSEMOA;
problem = @DTLZ7;
N = 100;
varargin = {'-algorithm', algorithm, '-problem', problem, '-N', N, '-run', 1};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(40);
ref = [1,1,7];


% draw pic
figure();
hold on
for index = 1:length(PF)
    point = PF(index,:);
    drawCuboid(point,ref);
end

scatter3(PF(:,1),PF(:,2),PF(:,3),'r.')

set(gca,'xdir','reverse');
set(gca,'ydir','reverse');
set(gca,'zdir','reverse');