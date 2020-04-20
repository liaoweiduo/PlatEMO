thickness = 0.001;

varargin = {'-algorithm', @NSGAII, '-problem', @MinusDTLZ1, '-N', 100, '-M', 3, '-run', 1};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(500000);

figure()
hold on
view(3)
axis equal
set(gca,'XDir','reverse');
set(gca,'YDir','reverse');

% for theta = 0:pi/18:pi/2
%     x = sin(theta); y = cos(theta);
%     vector1 = [x,0,y];
%     vector2 = [0,x,y];
%     n = cross(vector1,vector2);
%     PFVectors = PF;
%     dis = sum(PFVectors .* n,2) ./ sqrt(n(1)^2 + n(2)^2 + n(3)^2); 
%     
%     points = PF(abs(dis) < thickness,:);
%     s = plot3(points(:,1),points(:,2),points(:,3),'r');
% end

points = PF(abs(PF(:,3) - 0) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.15*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.29*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.45*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.6*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.74*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.84*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.92*(-3.5)) < thickness,:);
plot3(points(:,1),points(:,2),points(:,3),'r');
points = PF(abs(PF(:,3) - 0.98*(-3.5)) < thickness/2,:);
plot3(points(:,1),points(:,2),points(:,3),'r');


for theta = 0:pi/18:pi/2
    x = sin(theta); y = cos(theta);
    vector1 = [x,y,0] - [0,0,1];
    vector2 = [0,0,1];
    n = cross(vector1,vector2);
    PFVectors = PF - [0,0,1];
    dis = sum(PFVectors .* n,2) ./ sqrt(n(1)^2 + n(2)^2 + n(3)^2); 
    
    points = PF(abs(dis) < thickness,:);
    s = plot3(points(:,1),points(:,2),points(:,3),'r');
end


set(gca,'FontSize',30);