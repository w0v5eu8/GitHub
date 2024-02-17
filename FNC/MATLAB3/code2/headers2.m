%%
    close all
    clc
    
    t2t_raw2pca
    
%     Simulation
    
%% header infos for controller learning

    simt = md-246; % 750; % 510; % 270; % initializing 의 의미는???
    
%     if     esntest <= 10  % 
%     netDim = 150;  specRad = 1.999; connectivity = .1;
%     elseif esntest <= 20 && esntest > 10 % 
%     netDim = 150;  specRad = 1.999; connectivity = .5;
%     elseif esntest <= 30 && esntest > 20 % 
%     netDim = 150;  specRad = 0.333; connectivity = .1;
%     elseif esntest <= 40 && esntest > 30 % 
%     netDim = 150;  specRad = 0.333; connectivity = .5;
% % %     elseif esntest == 5 % 
% %     netDim = 150;  specRad = 0.333; connectivity = .1;   
% %     elseif esntest == 6 % 
% %     netDim = 150;  specRad = 0.333; connectivity = .1;
% %     elseif esntest == 7 % 
% %     netDim = 150;  specRad = 0.333; connectivity = .1;
% %     elseif esntest == 8 % 
% %     netDim = 150;  specRad = 0.333; connectivity = .1;
% %     elseif esntest == 9 % 
% %     netDim = 150;  specRad = 0.333; connectivity = .1;
% %     elseif esntest == 10 % 
% %     netDim = 150;  specRad = 0.333; connectivity = .1; 
%     end
%         
        netDim= 50; 
        specRad = 0.9; %0.333; 
        connectivity = 0.2;
        headid=2;
        
    inputLength = 15; outputLength = 1;
    
    samplelength = md;
    
    ofbSC = 1.0; % [1;1]; 
    noiselevel = 0.000001;
    
    TLR=md;
    F0S=md;
%     linearOutputUnits = 0; linearNetwork = 0; WienerHopf = 0;
    initialRunlength = md-1000; sampleRunlength = F0S-initialRunlength; % 900; 
    freeRunlength = 0; plotRunlength = TLR-F0S; % 6;
%     inputscaling = [.99;.99]; inputshift = [0;0];
%     teacherscaling = [0.99;0.99]; teachershift = [0;0];
    
    %%
%     run createEmptyFigs
    run generateNet
    run generateTrainTestData
    %%
    run learnAndTest
    %%
    % run continueRun.m
    
    %%
    close all
    
%     [tc(996,:)' Trend(91:985) no(91:985)];
%     figure
%     plot(tc(996,:)', 'r')
%     hold on
%     plot(Trend(91:985), 'g')
%     plot(no(91:985), 'b')
%     hold off
%     axis([800 900 -Inf Inf])
    
% [Trend no no_s no~=no_s no-no_s rscm]
 
% [Trend*100 no*100 no_s*100 rscm (raw_stock_d(996,:)'-20130000)]


%%
% 6/19
%     netDim= 50; specRad = 0.333; connectivity = 1;
% 34 68 34 6 9

%     if     esntest == 1 % 52 16 24 5 15
%     netDim = 150;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 2 % 48 18 28 4 2
%     netDim = 150;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 3 % 39 -4 20 6 8
%     netDim = 150;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 4 % 35 45 32 15 9
%     netDim = 150;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 5 % 15 26 25 3 16
%     netDim = 150;  specRad = 0.333; connectivity = .1;
% %           37.8         20.2         25.8          6.6           10
%    
%     elseif esntest == 6 % 39 28 -2 3 18
%     netDim = 100;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 7 % 31 50 29 2 11
%     netDim = 100;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 8 % 51 30 38 15 17
%     netDim = 100;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 9 % 36 51 33 9 17
%     netDim = 100;  specRad = 0.333; connectivity = .1;
%     elseif esntest == 10 % 37 28 31 11 12
%     netDim = 100;  specRad = 0.333; connectivity = .1; 
% %          38.8         37.4         25.8            8           15

%     if esntest == 1 % 18 55 40 6 16
%     netDim = 50;  specRad = 0.333; connectivity = 2;
%     elseif esntest == 2 % 39 39 16 9 11
%     netDim = 50;  specRad = 0.333; connectivity = 1.5;
%     elseif esntest == 3 % 37 41 26 15 16
%     netDim = 50;  specRad = 0.333; connectivity = 1;
%     elseif esntest == 4 % 39 10 24 13 15 
%     netDim = 50;  specRad = 0.333; connectivity = 0.5;
%     elseif esntest == 5 % 23 13 30 9 13
%     netDim = 50;  specRad = 0.333; connectivity = 0.25;
%     elseif esntest == 6 % 46 37 21 20 16 *
%     netDim = 50;  specRad = 0.333; connectivity = 0.1;
%     elseif esntest == 7 % 35 43 29 18 9 *
%     netDim = 50;  specRad = 0.333; connectivity = 0.05;
%     
%     elseif esntest == 8 % 29 14 16 20 22
%     netDim = 100;  specRad = 0.333; connectivity = 1;
%     elseif esntest == 9 % 31 33 17 8 9
%     netDim = 100;  specRad = 0.333; connectivity = 0.5;
%     elseif esntest == 10 % 48 53 28 17 16 *
%     netDim = 100;  specRad = 0.333; connectivity = 0.1;
%     
%     elseif esntest == 11 % 23 35 17 10 9
%     netDim = 50;  specRad = 0.3; connectivity = 0.1;
%     elseif esntest == 12 % 29 51 29 15 15
%     netDim = 50;  specRad = 0.3; connectivity = 0.05;
%     elseif esntest == 13 % 15 41 26 16 9
%     netDim = 100;  specRad = 0.3; connectivity = 0.1;
%     elseif esntest == 14 % 32 18 24 17 17 / 31 22 40 18 13
%     netDim = 100;  specRad = 0.3; connectivity = 0.05;    


% 6/18
%     if esntest == 1 % 40 39 13 15 17 *
%     netDim = 100;  specRad = 0.33; connectivity = 2;
%     elseif esntest == 2 % 29 41 -3 14 14
%     netDim = 100;  specRad = 0.33; connectivity = 1.5;
%     elseif esntest == 3 % 41 42 44 22 12 *
%     netDim = 100;  specRad = 0.33; connectivity = 1;
%     elseif esntest == 4 % 35 35 30 7 16 *
%     netDim = 100;  specRad = 0.33; connectivity = 0.5;
%     elseif esntest == 5 % 28 32 38 15 20 *
%     netDim = 100;  specRad = 0.33; connectivity = 0.25;
%     elseif esntest == 6 % 27 39 17 26 20
%     netDim = 100;  specRad = 0.33; connectivity = 0.1;
%     elseif esntest == 7 % 37 37 27 4 10
%     netDim = 100;  specRad = 0.33; connectivity = 0.05;
%     
%     elseif esntest == 8 % 29 14 13 3 20
%     netDim = 100;  specRad = 0.1; connectivity = 0.3;
%     elseif esntest == 9 % 21 38 30 5 18
%     netDim = 100;  specRad = 0.3; connectivity = 0.3;
%     elseif esntest == 10 % 39 33 22 5 8
%     netDim = 100;  specRad = 0.5; connectivity = 0.3;
%     elseif esntest == 11 % 43 37 27 21 25 *
%     netDim = 100;  specRad = 0.9; connectivity = 0.3;
%     elseif esntest == 12 % 41 14 26 15 9
%     netDim = 100;  specRad = 1.5; connectivity = 0.3;
%     
%     elseif esntest == 13 % 47 47 23 12 9 *
%     netDim = 50;  specRad = 0.33; connectivity = 0.3;
%     % netDim = 100; --> 25 35 35 
%     elseif esntest == 14 % 39 32 14 14 19
%     netDim = 150;  specRad = 0.33; connectivity = 0.3;
%     elseif esntest == 15 % 22 32 26 14 26
%     netDim = 300;  specRad = 0.33; connectivity = 0.3;
%     elseif esntest == 16 % 24 -12 8 19 41
%     netDim = 500;  specRad = 0.33; connectivity = 0.3;
%     
%     elseif esntest == 17 % 31 25 17 1 2
%     netDim = 50;  specRad = 1; connectivity = 0.3;
%     elseif esntest == 18 % 24 50 21 17 8
%     netDim = 50;  specRad = 0.1; connectivity = 0.3;
%     elseif esntest == 19 % 52 50 32 15 21 * / 43 25 40 10 13
%     netDim = 50;  specRad = 0.33; connectivity = 1;
      % conn.=2.0 --> 50 38 40 8 10  
      % conn.=1.5 --> 21 25 27 12 12
      % conn.=0.8 --> 34 43 18 16 16
%     elseif esntest == 20 % 25 52 29 17 19
%     netDim = 50;  specRad = 0.33; connectivity = 0.1;
%     elseif esntest == 21 % 28 44 28 5 18 / 37 42 21 15 18
%     netDim = 100;  specRad = 0.33; connectivity = 3;
%     elseif esntest == 22 % 30 31 27 10 19
%     netDim = 150;  specRad = 0.33; connectivity = 0.1;
%     elseif esntest == 23 % 27 -18 8 4 2
%     netDim = 150;  specRad = 0.33; connectivity = 0.05;
%     elseif esntest == 24
%     netDim = 1000;  specRad = 0.33; connectivity = 0.3;
%     end