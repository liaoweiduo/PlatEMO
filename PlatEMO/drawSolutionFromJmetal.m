clear
Path = 'ParallelMOEADFeatureSelection';
Prob = 'MultipleFeatures';
strategy = 'MEDIAN';   % MEDIAN  BEST

figure()
hold on 
view(2)
title([Prob, ' IGD+ ', strategy]);

% drawLine(Path, 'NSGAII', Prob, '-x');
% drawLine(Path, 'SPEA2', Prob, '-+');
% drawLine(Path, 'MOEAD', Prob, '-^');
drawLine(Path, 'MOEAD-STAT', Prob, strategy, '-.');
drawLine(Path, 'rMSM-2', Prob, strategy, '-x');
drawLine(Path, 'rMSM-4', Prob, strategy, '-v');
drawLine(Path, 'ffpMOEAD-FS-2', Prob, strategy, '-+');
drawLine(Path, 'ffpMOEAD-FS-4', Prob, strategy, '-d');
drawLine(Path, 'sfpMOEAD-FS-2', Prob, strategy, '-^');
drawLine(Path, 'sfpMOEAD-FS-4', Prob, strategy, '-*');
drawLine(Path, 'oipMOEAD-FS-2', Prob, strategy, '-o');
drawLine(Path, 'oipMOEAD-FS-4', Prob, strategy, '-s');
drawLine(Path, 'aspMOEAD-FS-2', Prob, strategy, '-p');
drawLine(Path, 'aspMOEAD-FS-4', Prob, strategy, '-h');

% FUN = load(['~/jMetal/jMetal-core/src/main/resources/pareto_fronts/', Prob, '.pf']);
% FUN = sortrows(FUN,1);
% plot(FUN(:,1),FUN(:,2),'r-','LineWidth',3)

legend('MOEA/D-STAT','npMOEA/D-FS-2','npMOEA/D-FS-4','ffpMOEA/D-FS-2','ffpMOEA/D-FS-4','sfpMOEA/D-FS-2','sfpMOEA/D-FS-4','oipMOEA/D-FS-2','oipMOEA/D-FS-4','aspMOEA/D-FS-2','aspMOEA/D-FS-4');%,'oipMOEA/D-FS-1','oipMOEA/D-FS-2','oipMOEA/D-FS-4','oipMOEA/D-FS-8'); % 'NSGAII','SPEA2','MOEA/D'
set(gca,'FontSize',20);
set(gca, 'XScale', 'log');
set(gca, 'YScale', 'log');
grid on

function drawLine(path, algorithm, problem, strategy, marker)
    FUN = load(['~/jMetal/Experiments/', path, '/data/',algorithm,'/', problem, '/', strategy, '_IGD+_FUN.tsv']);
    FrontNo    = NDSort(FUN,inf); 
    objChoose = FUN(FrontNo==1,:);
    objChoose = unique(objChoose, 'rows');
    if objChoose(1,1) == 0
        objChoose = objChoose(2:end,:);
    end
    plot(objChoose(:,1),objChoose(:,2),marker,'LineWidth',3,'MarkerSize',20);
end