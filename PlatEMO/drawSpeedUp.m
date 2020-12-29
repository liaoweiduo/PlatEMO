clear

Problem = 'Vehicle';
speedUp = [];
Algorithm = 'MOEA/D-STAT';
STATTimeCost = 48772;
speedUp(1:3,1) = [1;1;1];
Algorithm = 'oipMOEA/D-FS-2';
timeCost = 31222;
speedUp(1,2) = STATTimeCost / timeCost;
Algorithm = 'oipMOEA/D-FS-4';
timeCost = 15520;
speedUp(1,3) = STATTimeCost / timeCost;
Algorithm = 'oipMOEA/D-FS-8';
timeCost = 9199;
speedUp(1,4) = STATTimeCost / timeCost;
Algorithm = 'aspMOEA/D-FS-2';
timeCost = 25494;
speedUp(2,2) = STATTimeCost / timeCost;
Algorithm = 'aspMOEA/D-FS-4';
timeCost = 15937;
speedUp(2,3) = STATTimeCost / timeCost;
Algorithm = 'aspMOEA/D-FS-8';
timeCost = 9118;
speedUp(2,4) = STATTimeCost / timeCost;
Algorithm = 'rdpMOEA/D-FS-2';
timeCost = 27103;
speedUp(3,2) = STATTimeCost / timeCost;
Algorithm = 'rdpMOEA/D-FS-4';
timeCost = 14899;
speedUp(3,3) = STATTimeCost / timeCost;
Algorithm = 'rdpMOEA/D-FS-8';
timeCost = 8761;
speedUp(3,4) = STATTimeCost / timeCost;


% Problem = 'Musk1';
% speedUp = [];
% efficient = [];
% Algorithm = 'MOEA/D-STAT';
% STATTimeCost = 611831;
% speedUp(1:3,1) = [1;1;1];
% efficient(1:3,1) = [1;1;1];
% Algorithm = 'oipMOEA/D-FS-2';
% timeCost = 361551;
% speedUp(1,2) = STATTimeCost / timeCost;
% efficient(1,2) = speedUp(1,2) / 2;
% Algorithm = 'oipMOEA/D-FS-4';
% timeCost = 189015;
% speedUp(1,3) = STATTimeCost / timeCost;
% efficient(1,3) = speedUp(1,3) / 4;
% Algorithm = 'oipMOEA/D-FS-8';
% timeCost = 96692;
% speedUp(1,4) = STATTimeCost / timeCost;
% efficient(1,4) = speedUp(1,4) / 8;
% Algorithm = 'aspMOEA/D-FS-2';
% timeCost = 330139;
% speedUp(2,2) = STATTimeCost / timeCost;
% efficient(2,2) = speedUp(2,2) / 2;
% Algorithm = 'aspMOEA/D-FS-4';
% timeCost = 165553;
% speedUp(2,3) = STATTimeCost / timeCost;
% efficient(2,3) = speedUp(2,3) / 4;
% Algorithm = 'aspMOEA/D-FS-8';
% timeCost = 87210;
% speedUp(2,4) = STATTimeCost / timeCost;
% efficient(2,4) = speedUp(2,4) / 8;
% Algorithm = 'rdpMOEA/D-FS-2';
% timeCost = 330748;
% speedUp(3,2) = STATTimeCost / timeCost;
% efficient(3,2) = speedUp(3,2) / 2;
% Algorithm = 'rdpMOEA/D-FS-4';
% timeCost = 168456;
% speedUp(3,3) = STATTimeCost / timeCost;
% efficient(3,3) = speedUp(3,3) / 4;
% Algorithm = 'rdpMOEA/D-FS-8';
% timeCost = 86277;
% speedUp(3,4) = STATTimeCost / timeCost;
% efficient(3,4) = speedUp(3,4) / 8;

figure()
hold on 
view(2)
title([Problem]);
plot(1:4,speedUp(1,:),'-o','LineWidth',2,'MarkerSize',10)
plot(1:4,speedUp(2,:),'-<','LineWidth',2,'MarkerSize',10)
plot(1:4,speedUp(3,:),'-s','LineWidth',2,'MarkerSize',10)
plot(1:4,[1,2,4,8],'--','LineWidth',2,'MarkerSize',10)
set(gca,'xtick',[1 2 3 4],'xticklabel',{'1','2','4','8'});
xlabel('number of processor');
ylabel('speed up');
legend('oipMOEA/D-FS','aspMOEA/D-FS','rdpMOEA/D-FS','ideal');

% figure()
% hold on
% view(2)
% title([Problem]);
% plot(1:4,efficient(1,:),'-o','LineWidth',2,'MarkerSize',10)
% plot(1:4,efficient(2,:),'-<','LineWidth',2,'MarkerSize',10)
% plot(1:4,efficient(3,:),'-s','LineWidth',2,'MarkerSize',10)
% set(gca,'xtick',[1 2 3 4],'xticklabel',{'1','2','4','8'});
% xlabel('number of processor');
% ylabel('efficient');
% legend('oipMOEA/D-FS','aspMOEA/D-FS','rdpMOEA/D-FS');


% xtickangle(45)

