r = 5;
As = [0:0.02:0.2,0.3:0.1:1];
% As = 0:0.1:1;
% As = 0:0.001:0.01;
M = 8;
N = 36;             % will change for uniform
num_vec = 100;      % will change for uniform
num_front = 100;
PFproblem = {};
% PFproblem = {@DTLZ7,@DTLZ1,@DTLZ2,@MinusDTLZ1,@MinusDTLZ2};

%% generate data set
pointsSet = {};
for problem = PFproblem
    varargin = {'-algorithm', @SMSEMOA, '-problem', problem, '-M', M};
    Global = GLOBAL(varargin{:});
    points = Global.problem.PF(N);
    fmax   = max(points,[],1);
    fmin   = min(points,[],1);
    points  = (points-repmat(fmin,size(points,1),1))./repmat(fmax-fmin,size(points,1),1);
    pointsSet{end+1} = points;
end
num_randomG = num_front - size(pointsSet,2);
for i = 1:num_randomG
%     mu = zeros(1,M);
%     sigma = eye(M,M);
%     R = mvnrnd(mu,sigma,N);
    points = rand(N,M);
    FrontNo = NDSort(points,inf);
    points = points(FrontNo == ceil(max(FrontNo)/2),:); 
    fmax   = max(points,[],1);
    fmin   = min(points,[],1);
    points  = (points-repmat(fmin,size(points,1),1))./repmat(fmax-fmin,size(points,1),1);
    pointsSet{end+1} = points;
end

%% generate W
WSet = {};
for i = 1:size(As,2)
    a = As(i);
    [w,num_vect] = UniformPoint(num_vec, M);
    if num_vect ~= num_vec
        disp(['num_vec changes to ', num2str(num_vect)]);
    end
    num_vec = num_vect;
    w = w./repmat(sqrt(sum(w.^2, 2)),1,M);
    w = (1 - a) .* w + a .* (1/sqrt(M)) .* ones(1,M);
    w = w./ sqrt(sum(w.^2,2));
    
    WSet{end+1} = w;
end

%% calculate CIR
CIRs = zeros(1,size(As,2));
for wi = 1:size(As,2)
    disp(['start: ', num2str(wi),'/', num2str(size(As,2))]);
    w = WSet{wi};
    CIRs(wi) = CalCIR(pointsSet,w,r);
end
disp('start random');
CIRr = CalCIR(pointsSet,UniformVector(num_vec, M),r);

%% plot
figure()
hold on;
plot(As,CIRs,'LineWidth',3)
plot(As,repmat(CIRr,size(As,2),1),'LineWidth',3)
legend('uniform','random');
title(['R2HCA, r = ', num2str(r), ', m = ', num2str(M)]);
xlabel('a');
ylabel('CIR');
set(gca,'FontSize',20);
% set(gca, 'YScale', 'log');
grid on
