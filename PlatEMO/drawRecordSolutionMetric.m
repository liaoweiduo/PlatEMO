clear
Path = 'GetData';
Prob = 'Vehicle';
Metr = 'IGD+';

figure()
hold on 
view(2)
title([Prob, ' ', Metr]);

drawLine(Path, 'MOEAD-STAT', Prob, Metr, 0:10:200, '-*');
drawLine(Path, 'oipMOEAD-FS-2', Prob, Metr, 0:10:200, '-o');
drawLine(Path, 'oipMOEAD-FS-4', Prob, Metr, 0:10:200, '-s');
drawLine(Path, 'oipMOEAD-FS-8', Prob, Metr, 0:10:200, '-d');
drawLine(Path, 'aspMOEAD-FS-2', Prob, Metr, 0:10:200, '-<');
drawLine(Path, 'aspMOEAD-FS-4', Prob, Metr, 0:10:200, '->');
drawLine(Path, 'aspMOEAD-FS-8', Prob, Metr, 0:10:200, '-^');
drawLine(Path, 'rdpMOEAD-FS-2', Prob, Metr, 0:10:200, '-v');
drawLine(Path, 'rdpMOEAD-FS-4', Prob, Metr, 0:10:200, '-x');
drawLine(Path, 'rdpMOEAD-FS-8', Prob, Metr, 0:10:200, '-+');

legend('MOEA/D-STAT','oipMOEA/D-FS-2','oipMOEA/D-FS-4','oipMOEA/D-FS-8','aspMOEA/D-FS-2','aspMOEA/D-FS-4','aspMOEA/D-FS-8','rdpMOEA/D-FS-2','rdpMOEA/D-FS-4','rdpMOEA/D-FS-8');

function drawLine(path, algorithm, problem, Metr, xrange, marker)
    metric = [];
    for i = 0:20
        metric(:,i+1) = load(['~/jMetal/Experiments/', path, '/data/',algorithm,'/', problem, '/RS',num2str(i),'/',Metr]);
    end
    metric(21,:) = load(['~/jMetal/Experiments/', path, '/data/',algorithm,'/', problem, '/',Metr])';
    averageMetric = mean(metric,2);
    plot(xrange,averageMetric,marker,'LineWidth',2,'MarkerSize',10);
end