clear
r = 5;
As = [0:0.02:0.2,0.3:0.1:1];
% As = 0:0.1:1;
% As = 0:0.001:0.01;
Ms = [3,5,8,10];
Ns = [91,70,36,30];             % will change for uniform
num_vec = 100;      % will change for uniform
num_front = 100;
PFproblem = {};
% PFproblem = {@DTLZ7,@DTLZ1,@DTLZ2,@MinusDTLZ1,@MinusDTLZ2};

for mi = 1:size(Ms,2)
    M = Ms(mi);
    N = Ns(mi);
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
    
    for i = 1:num_randomG/4
        
%         points = rand(N,M);
%         FrontNo = NDSort(points,inf);
%         points = points(FrontNo == ceil(max(FrontNo)/2),:); 
%         fmax   = max(points,[],1);
%         fmin   = min(points,[],1);
%         points  = (points-repmat(fmin,size(points,1),1))./repmat(fmax-fmin,size(points,1),1);
%         pointsSet{end+1} = points;

        varargin = {'-algorithm', @SMSEMOA, '-problem', @DTLZ1, '-M', M};
        Global = GLOBAL(varargin{:});
        pointss = Global.problem.PF(1000);
        perm = randperm(size(pointss,1));
        points = pointss(perm(1:N),:);
%         
%         [points,N] = UniformVector(N, M);
%         points = points ./ sum(points,2);
%         points = 1-points;
        fmax   = max(points,[],1);
        fmin   = min(points,[],1);
        points  = (points-repmat(fmin,size(points,1),1))./repmat(fmax-fmin,size(points,1),1);
        pointsSet{end+1} = points;
    end
    for i = num_randomG/4+1:num_randomG/4 * 2

        varargin = {'-algorithm', @SMSEMOA, '-problem', @DTLZ2, '-M', M};
        Global = GLOBAL(varargin{:});
        pointss = Global.problem.PF(1000);
        perm = randperm(size(pointss,1));
        points = pointss(perm(1:N),:);

        fmax   = max(points,[],1);
        fmin   = min(points,[],1);
        points  = (points-repmat(fmin,size(points,1),1))./repmat(fmax-fmin,size(points,1),1);
        pointsSet{end+1} = points;
    end
    for i = num_randomG/4 *2 +1:num_randomG/4 * 3
        
        varargin = {'-algorithm', @SMSEMOA, '-problem', @MinusDTLZ1, '-M', M};
        Global = GLOBAL(varargin{:});
        pointss = Global.problem.PF(1000);
        perm = randperm(size(pointss,1));
        points = pointss(perm(1:N),:);
        
        fmax   = max(points,[],1);
        fmin   = min(points,[],1);
        points  = (points-repmat(fmin,size(points,1),1))./repmat(fmax-fmin,size(points,1),1);
        pointsSet{end+1} = points;
    end
    for i = num_randomG/4 *3 +1:num_randomG
        
        varargin = {'-algorithm', @SMSEMOA, '-problem', @MinusDTLZ2, '-M', M};
        Global = GLOBAL(varargin{:});
        pointss = Global.problem.PF(1000);
        perm = randperm(size(pointss,1));
        points = pointss(perm(1:N),:);
        
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
    CIRrs = [];
    for ri = 1:5
        disp([num2str(ri)]);
        CIRrs(ri) = CalCIR(pointsSet,UniformVector(num_vec, M),r);
    end
    CIRr = mean(CIRrs);

    %% plot
    figure()
    hold on;
    plot(As,CIRs,'-v','LineWidth',3,'MarkerSize',20)
    plot(As,repmat(CIRr,size(As,2),1),'-x','LineWidth',3,'MarkerSize',20)
    legend('Uniform','Random');
%     title(['R2HCA, r = ', num2str(r), ', m = ', num2str(M)]);
    xlabel('a');
    ylabel('CIR');
    xlabel('');
    ylabel('');
    set(gca,'FontSize',20);
    % set(gca, 'YScale', 'log');
    grid on

    saveas(gca,fullfile('Analysis','master','distribution','fig','R2HCAuniformA',...
                ['r',num2str(r),'m',num2str(M),'_ave.eps']),'eps');
    close(figure(gcf))
end