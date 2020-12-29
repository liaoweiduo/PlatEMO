clear
Path = 'GetData';
Prob = 'Musk1';
strategy = 'MEDIAN';   % MEDIAN  BEST

figure()
hold on 
view(2)
title([Prob, ' ', strategy]);

% drawLine(Path, 'NSGAII', Prob, '-x');
% drawLine(Path, 'SPEA2', Prob, '-+');
% drawLine(Path, 'MOEAD', Prob, '-^');
drawLine(Path, 'MOEAD-STAT', Prob, strategy, '-*');
drawLine(Path, 'oipMOEAD-FS-2', Prob, strategy, '-o');
% drawLine(Path, 'oipMOEAD-FS-4', Prob, strategy, '-s');
% drawLine(Path, 'oipMOEAD-FS-8', Prob, strategy, '-d');
drawLine(Path, 'aspMOEAD-FS-2', Prob, strategy, '-<');
% drawLine(Path, 'aspMOEAD-FS-4', Prob, strategy, '->');
% drawLine(Path, 'aspMOEAD-FS-8', Prob, strategy, '-^')
drawLine(Path, 'rdpMOEAD-FS-2', Prob, strategy, '-v');
% drawLine(Path, 'aspMOEAD-FS-4', Prob, strategy, '-x');
% drawLine(Path, 'aspMOEAD-FS-8', Prob, strategy, '-+')

legend('MOEA/D-STAT','oipMOEA/D-FS-2','aspMOEA/D-FS-2','rdpMOEA/D-FS-2');%,'oipMOEA/D-FS-1','oipMOEA/D-FS-2','oipMOEA/D-FS-4','oipMOEA/D-FS-8'); % 'NSGAII','SPEA2','MOEA/D'

function drawLine(path, algorithm, problem, strategy, marker)
    FUN = load(['~/jMetal/Experiments/', path, '/data/',algorithm,'/', problem, '/', strategy, '_HV_FUN.tsv']);
    FrontNo    = NDSort(FUN,inf); 
    objChoose = FUN(FrontNo==1,:);
    objChoose = unique(objChoose, 'rows');
    if objChoose(1,1) == 0
        objChoose = objChoose(2:end,:);
    end
    plot(objChoose(:,1),objChoose(:,2),marker,'LineWidth',2,'MarkerSize',10);
end