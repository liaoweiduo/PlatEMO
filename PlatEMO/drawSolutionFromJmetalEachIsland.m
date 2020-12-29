clear
Path = 'GetData';
algorithm = 'oipMOEAD-FS-8';
problem = 'Musk1';

figure()
hold on 
view(2)
title([problem]);

FUN = load(['~/jMetal/Experiments/', Path, '/data/',algorithm,'/', problem, '/BEST_HV_FUN.tsv']);
% FrontNo    = NDSort(FUN,inf); 
% objChoose = FUN(FrontNo==1,:);
% objChoose = unique(objChoose, 'rows');
% if objChoose(1,1) == 0
%     objChoose = objChoose(2:end,:);
% end

fun1 = FUN(1:29,:);
fun2 = FUN(30:66,:);
fun3 = FUN(67:103,:);
fun4 = FUN(104:140,:);
fun5 = FUN(141:177,:);
fun6 = FUN(178:214,:);
fun7 = FUN(215:250,:);
fun8 = FUN(251:278,:);

scatter(fun1(:,1),fun1(:,2),100,'*');
scatter(fun2(:,1),fun2(:,2),100,'+');
scatter(fun3(:,1),fun3(:,2),100,'^');
scatter(fun4(:,1),fun4(:,2),100,'d');
scatter(fun5(:,1),fun5(:,2),100,'x');
scatter(fun6(:,1),fun6(:,2),100,'>');
scatter(fun7(:,1),fun7(:,2),100,'o');
scatter(fun8(:,1),fun8(:,2),100,'s');

xlim([0,1])
legend('Island 0','Island 1','Island 2','Island 3','Island 4','Island 5','Island 6','Island 7')


% drawLine(Path, 'NSGAII', Prob, '-x');
% drawLine(Path, 'SPEA2', Prob, '-+');
% drawLine(Path, 'MOEAD', Prob, '-^');
% drawLine(Path, 'MOEAD-STAT', Prob, strategy, '-*');
% drawLine(Path, 'oipMOEAD-FS-2', Prob, strategy, '-o');
% drawLine(Path, 'oipMOEAD-FS-4', Prob, strategy, '-s');
% drawLine(Path, 'oipMOEAD-FS-8', Prob, strategy, '-d');
% drawLine(Path, 'aspMOEAD-FS-2', Prob, strategy, '-<');
% drawLine(Path, 'aspMOEAD-FS-4', Prob, strategy, '->');
% drawLine(Path, 'aspMOEAD-FS-8', Prob, strategy, '-^')
% drawLine(Path, 'rdpMOEAD-FS-2', Prob, strategy, '-v');
% drawLine(Path, 'aspMOEAD-FS-4', Prob, strategy, '-x');
% drawLine(Path, 'aspMOEAD-FS-8', Prob, strategy, '-+')

% legend('MOEA/D-STAT','oipMOEA/D-FS-2','aspMOEA/D-FS-2','rdpMOEA/D-FS-2');%,'oipMOEA/D-FS-1','oipMOEA/D-FS-2','oipMOEA/D-FS-4','oipMOEA/D-FS-8'); % 'NSGAII','SPEA2','MOEA/D'
