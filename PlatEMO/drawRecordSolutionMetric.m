clear
Path = 'ParallelMOEADFeatureSelection';
Prob = 'Bankruptcy';
Metr = 'IGD+';

figure()
hold on 
grid on
view(2)
title([Prob, ' ', Metr]);

drawLine(Path, 'MOEAD-STAT', Prob, Metr, 0:10:200, '-.');
drawLine(Path, 'npMOEAD-FS-2', Prob, Metr, 0:10:200, '-x');
drawLine(Path, 'npMOEAD-FS-4', Prob, Metr, 0:10:200, '-v');
drawLine(Path, 'ffpMOEAD-FS-2', Prob, Metr, 0:10:200, '-+');
drawLine(Path, 'ffpMOEAD-FS-4', Prob, Metr, 0:10:200, '-d');
drawLine(Path, 'sfpMOEAD-FS-2', Prob, Metr, 0:10:200, '-^');
drawLine(Path, 'sfpMOEAD-FS-4', Prob, Metr, 0:10:200, '-*');
drawLine(Path, 'oipMOEAD-FS-2', Prob, Metr, 0:10:200, '-o');
drawLine(Path, 'oipMOEAD-FS-4', Prob, Metr, 0:10:200, '-s');
drawLine(Path, 'aspMOEAD-FS-2', Prob, Metr, 0:10:200, '-p');
drawLine(Path, 'aspMOEAD-FS-4', Prob, Metr, 0:10:200, '-h');

set(gca, 'YScale', 'log');
set(gca,'FontSize',20);
legend('MOEA/D-STAT','npMOEA/D-FS-2','npMOEA/D-FS-4','ffpMOEA/D-FS-2','ffpMOEA/D-FS-4','sfpMOEA/D-FS-2','sfpMOEA/D-FS-4','oipMOEA/D-FS-2','oipMOEA/D-FS-4','aspMOEA/D-FS-2','aspMOEA/D-FS-4');

function drawLine(path, algorithm, problem, Metr, xrange, marker)
    metric = [];
    for i = 0:2
        metric(:,i+1) = load(['~/jMetal/Experiments/', path, '/data/',algorithm,'/', problem, '/RS',num2str(i),'/',Metr]);
    end
    metric(21,:) = load(['~/jMetal/Experiments/', path, '/data/',algorithm,'/', problem, '/',Metr])';
    averageMetric = mean(metric,2);
    plot(xrange,averageMetric,marker,'LineWidth',3,'MarkerSize',10);
end