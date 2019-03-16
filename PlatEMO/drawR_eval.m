% y = ax2 + bx + c 
% Rfinal - Rinit = deltR 
% n = evaluation; a; b = deltR / n - na; c = Rinit; 
% deltR / n2 <= a <= - deltR / n2; 
%      tu      linear         ao;
% Rinit --- 2 --- The initial value of r
% level --- 0 --- level => [-1 : 1] map to a => [ao : tu]

Rinit = 2;
N = 100;
M = 3;
evaluation = 100000;

%% calculate H
% init Ma(Pascal's triangle)
%   find Ma(H+M,M)<n<Ma(H+M+1,M)
yh = zeros(1, M);
yh(1) = 1;
Ma = yh;
maxNum = 0;
while maxNum < N
    yh = [yh,0]+[0,yh];
    Ma = [Ma;yh(1:M)];
    maxNum = yh(M);
end
% Calculate H from N and M based on Ma
Maj = Ma(:,M);
H = 0;
for n = M:size(Maj,1)
    if Maj(n) >= N
        H = n - M;
        break;
    end
end
if H == 0
    H = 1;
end
    
%% calculate other parameter
Rfinal = 1 + 1./H;
deltR = Rfinal - Rinit;
n = evaluation - N - 1;
% evaluated starts from N+1, first N evaluated was used to initialize N generations; 
% total evaluation-N


%% draw origin algo
x = 1:evaluation;
r = Rinit .* ones(1,evaluation);

plot(x,r);
hold on


%% draw line
level = -1;

a = -1 .* level .* deltR ./ (n .* n);
b = deltR ./ n - n .* a;
c = Rinit;

x = 1:evaluation;
r = CalR(a,b,c,x);

plot(x,r);

%% draw line
level = -0.5;

a = -1 .* level .* deltR ./ (n .* n);
b = deltR ./ n - n .* a;
c = Rinit;

x = 1:evaluation;
r = CalR(a,b,c,x);

plot(x,r);

%% draw line
level = 0;

a = -1 .* level .* deltR ./ (n .* n);
b = deltR ./ n - n .* a;
c = Rinit;

x = 1:evaluation;
r = CalR(a,b,c,x);

plot(x,r);

%% draw line
level = 0.5;

a = -1 .* level .* deltR ./ (n .* n);
b = deltR ./ n - n .* a;
c = Rinit;

x = 1:evaluation;
r = CalR(a,b,c,x);

plot(x,r);

%% draw line
level = 1;

a = -1 .* level .* deltR ./ (n .* n);
b = deltR ./ n - n .* a;
c = Rinit;

x = 1:evaluation;
r = CalR(a,b,c,x);

plot(x,r);


%% draw optimal algo
x = 1:evaluation;
r = Rfinal .* ones(1,evaluation);

plot(x,r);

% xlabel('evaluation');
% ylabel('r');
ylim([1,2.1]);
set(gca, 'XTick', []);                     % 清除X轴的记号点
set(gca, 'YTick', []);                     % 清除Y轴的记号点
legend('origin', '-1', '-0.5', '0', '0.5', '1', 'optimal');



%%  calculate reference point position r
function [r] = CalR(a,b,c,x)
%  r = ax^2 + bx + c
    r = a .* x .* x + b .* x + c;
end