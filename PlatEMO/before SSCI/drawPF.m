thickness = 0.001;

varargin = {'-algorithm', @NSGAII, '-problem', @MinusDTLZ2, '-N', 100, '-M', 3, '-run', 1};
Global = GLOBAL(varargin{:});
PF = Global.problem.PF(500000);

figure()
hold on
view(3)
axis equal

% parallel horizontal line
for theta = 0:pi/18:pi/2
    y = cos(theta);
    points = PF(abs(PF(:,3) - y*(-3.5)) < thickness,:);
    plot3(points(:,1),points(:,2),points(:,3),'r');
end

% point-emitted vertical line
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