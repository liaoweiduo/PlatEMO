function HypELD(Global)
% <algorithm> <HypE>
% Hypervolume estimation algorithm
% linearly decrease
% nSample --- 10000 --- Number of sampled points for HV estimation
% Rinit --- 10 --- The initial value of r

%------------------------------- Reference --------------------------------
% J. Bader and E. Zitzler, HypE: An algorithm for fast hypervolume-based
% many-objective optimization, Evolutionary Computation, 2011, 19(1):
% 45-76.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    [nSample, Rinit] = Global.ParameterSet(10000, 2);
    
    %% Calculation of paremeter calculating reference point position r
    H = getH(Global.M, Global.N);
    Rfinal = 1 + 1./H;
    
    %% Generate random population
    Population = Global.Initialization();

    %% Optimization
    while Global.NotTermination(Population)
        % Reference point for hypervolume calculation
        
%         if Global.evaluated <= Global.evaluation / 3
%             R = Rinit;
%         elseif Global.evaluated > Global.evaluation * 2 / 3
%             R = Rfinal;
%         else
%             T = Global.evaluation / 3;
%             t = Global.evaluated - Global.evaluation / 3 ;
%             R = Rinit * (T - t) / T + Rfinal * t / T;
%         end
        
        T = Global.evaluation; 
        t = Global.evaluated; 
        R = Rinit * (T - t) / T + Rfinal * t / T; 
            
        PopObj = Population.objs;
        RefPoint = R*(max(PopObj,[],1)-min(PopObj,[],1))+min(PopObj,[],1);
        MatingPool = TournamentSelection(2,Global.N,-CalHV(Population.objs,RefPoint,Global.N,nSample));
        Offspring  = GA(Population(MatingPool));    
        Population = EnvironmentalSelection([Population,Offspring],Global.N,RefPoint,nSample);
    end
end