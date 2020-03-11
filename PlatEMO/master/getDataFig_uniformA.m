clear

problems = {
    @DTLZ1, @DTLZ2, @DTLZ3, @DTLZ4,...
    @WFG1, @WFG2, @WFG3, @WFG4, @WFG5, @WFG6, @WFG7, @WFG8, @WFG9,...
    @MinusDTLZ1, @MinusDTLZ2, @MinusDTLZ3, @MinusDTLZ4,...
    @MinusWFG1, @MinusWFG2, @MinusWFG3, @MinusWFG4, @MinusWFG5,...
    @MinusWFG6, @MinusWFG7, @MinusWFG8, @MinusWFG9,...
    };

M = [3,5,8,10]; 
r = 5;

xindex = 0:0.1:1;
algorithms = {{@R2HCAEMOAa0r2,100,2,2,0.0},{@R2HCAEMOAa0r5,100,5,2,0.0};...
          {@R2HCAEMOAa1r2,100,2,2,0.1},{@R2HCAEMOAa1r5,100,5,2,0.1};...
          {@R2HCAEMOAa2r2,100,2,2,0.2},{@R2HCAEMOAa2r5,100,5,2,0.2};...
          {@R2HCAEMOAa3r2,100,2,2,0.3},{@R2HCAEMOAa3r5,100,5,2,0.3};...
          {@R2HCAEMOAa4r2,100,2,2,0.4},{@R2HCAEMOAa4r5,100,5,2,0.4};...
          {@R2HCAEMOAa5r2,100,2,2,0.5},{@R2HCAEMOAa5r5,100,5,2,0.5};...
          {@R2HCAEMOAa6r2,100,2,2,0.6},{@R2HCAEMOAa6r5,100,5,2,0.6};...
          {@R2HCAEMOAa7r2,100,2,2,0.7},{@R2HCAEMOAa7r5,100,5,2,0.7};...
          {@R2HCAEMOAa8r2,100,2,2,0.8},{@R2HCAEMOAa8r5,100,5,2,0.8};...
          {@R2HCAEMOAa9r2,100,2,2,0.9},{@R2HCAEMOAa9r5,100,5,2,0.9};...
          {@R2HCAEMOAa10r2,100,2,2,1.0},{@R2HCAEMOAa10r5,100,5,2,1.0};...
         };
if r == 2
    algorithms = algorithms(:,1);
else 
    algorithms = algorithms(:,2);
end

for pi = 1:size(problems,2)
    for m = M
        problem = problems{pi};
        MetricsData = [];
        for ai = 1:size(algorithms,1)
            algorithm = algorithms{ai}{1};
            fprintf('start %s\n', [func2str(algorithm),'_',func2str(problem),'_M',num2str(m)]);

            %% calculate mean Metrics
            files = dir(fullfile('Data',func2str(algorithm),...
                [func2str(algorithm),'_',func2str(problem),'_M',num2str(m),'*']));

            Metrics = [];
            for fileIndex = 1:size(files,1)
                file = files(fileIndex);
                filename = fullfile(file.folder, file.name);
                load(filename,'metric');
                Metrics(fileIndex) = metric.NHV;
            end
            MetricsData(1,ai) = mean(Metrics);
        end
        
        %% calculate Random mean
        algoSMS = str2func(['R2HCAEMOA',num2str(r)]);
        files = dir(fullfile('Data',func2str(algoSMS),...
            [func2str(algoSMS),'_',func2str(problem),'_M',num2str(m),'*']));

        Metrics = [];
        for fileIndex = 1:size(files,1)
            file = files(fileIndex);
            filename = fullfile(file.folder, file.name);
            load(filename,'metric');
            Metrics(fileIndex) = metric.NHV;
        end
        MetricsData(2,:) = repmat(mean(Metrics),1,size(algorithms,2));
        
        %% calculate SMSEMOA mean
        algoSMS = str2func(['SMSEMOA',num2str(r)]);
        files = dir(fullfile('Data',func2str(algoSMS),...
            [func2str(algoSMS),'_',func2str(problem),'_M',num2str(m),'*']));

        Metrics = [];
        for fileIndex = 1:size(files,1)
            file = files(fileIndex);
            filename = fullfile(file.folder, file.name);
            load(filename,'metric');
            Metrics(fileIndex) = metric.NHV;
        end
        MetricsData(3,:) = repmat(mean(Metrics),1,size(algorithms,2));
            
        %% plot for each problem
        figure()
        hold on;
        plot(xindex,MetricsData(1,:),'-v','LineWidth',3,'MarkerSize',20)
        plot(xindex,MetricsData(2,:),'-x','LineWidth',3,'MarkerSize',20)
        plot(xindex,MetricsData(3,:),'-.','LineWidth',3,'MarkerSize',20)
        legend('Uniform','Random','SMSEMOA');
%         title(['R2HCA, r = ', num2str(r), ', m = ', num2str(m)]);
        xlabel('a');
        ylabel('NHV');
        set(gca,'FontSize',20);
%         set(gca, 'YScale', 'log');
        grid on
        
        %% save fig
        saveas(gca,fullfile('Analysis','master','distribution','fig','R2HCAuniformA',...
            ['R2HCA_',func2str(problem),'_M',num2str(m),'_r',num2str(r),'.eps']),'eps');
        close(figure(gcf))

    end
end

