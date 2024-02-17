cccc
% pause
  tic;  

%% for test without stock price data

    md = 1000; 
    simt = md-246;

%% header informations

    netDim= 100; 
    specRad = 0.9; 
    connectivity = 2;
   
    inputLength = 1;
    outputLength = 1;
    
    samplelength = md;
    
    ofbSC = 1.0;  
    noiselevel = 0;%.000001;
    
    TLR=md;
    F0S=md;
    
%     linearOutputUnits = 0; linearNetwork = 0; WienerHopf = 0;
    initialRunlength = md*.05; 
    sampleRunlength = F0S-initialRunlength;
    freeRunlength = 0; plotRunlength = TLR-F0S;
%     inputscaling = [.99;.99]; inputshift = [0;0];
%     teacherscaling = [0.99;0.99]; teachershift = [0;0];
    
%%
    run S3_gen_net
    run S4_gen_inout
    
buy=zeros(1000,1); sell=zeros(1000,1);
for ii = 1:1000
    if (sampleout(ii)) == 1
        buy(ii) = 1;
    elseif (sampleout(ii)) == -1
        sell(ii) = 1;
    end
end
    
    run S5_learning
    run S6_results
   
    close all
    
% [Trend no no_s no~=no_s no-no_s rscm]
 
% [Trend*100 no*100 no_s*100 rscm (raw_stock_d(996,:)'-20130000)]

a=toc;
SpendTime = a/60
clear a ii
% save([num2str(raw_stock_d_ed(1,1000)),'_testESN']);
save(['testESN_',num2str(test),'.mat']);

