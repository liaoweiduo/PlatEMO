%
%--------------------------------------------------------------------------
% 
%--------------------------------------------------------------------------
clear;
N = 100;
M =   8;    % 3  5  8 10
D =  17;    % 7  9 12 14
            %12 14 17 19 MaF1
runs = 1:20;
algorithms = {'HypE','HypE_DR','HypE_DR2','HypE_optimal'};
problem = 'MaF1';
generation = 40000;
for run = runs
    figSavePath = fullfile('Analysis','solution',[problem,'_N',int2str(N),'_M',...
        int2str(M),'_D',int2str(D),'_',int2str(run),'_',int2str(generation)]);

    fig = figure();
    for index = 1:length(algorithms)
        algorithm = algorithms{index};
        readPath = fullfile('Data_processed',algorithm,[algorithm,'_',problem,...
            '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run),'.mat']);
        load(readPath);

        %% Picture
        subplot(2,2,index)
        generationSet = result(:,2);
        generationIndexSet = cell2mat(result(:,1));
        generationIndexSet = generationIndexSet';


        individualSet = generationSet{find(generationIndexSet==generation)};
        objectiveSet = individualSet.objs;

        Draw(objectiveSet);
        title([algorithm,'-',problem,...
            '_N',int2str(N),'_M',int2str(M),'_D',int2str(D),'_',int2str(run)]);

        ylim([0,0.6]);
        % h = plot([0.5,0],[0,0.5]);
        % set(h,'color',[96 96 96]/255);



        % xlim([0,1]);
        % zlim([0,1]);
        % set(gcf, 'position', [500 500 500 500]);
        % set(gca,'FontSize',20);

    end

    saveas(gcf,figSavePath,'fig');
    saveas(gcf,figSavePath,'png');
    close(fig);
end