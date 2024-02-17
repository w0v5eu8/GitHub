clear global buy_esn sell_esn prr_esn prr_bnh no_ss no
global buy_esn sell_esn prr_esn prr_bnh md no_ss
close all


%% Nout for simulation

    ET_d = 19;
    
    nono=find((no(1,:)~=0)); hm=round(size(nono,2));

    [xxzx, yyzy] = size(no);
    if xxzx-yyzy > ET_d
        ET_d = xxzx-yyzy+1;
    end
    for hmi = 2:hm
        nni = nono(hmi);
        no(1:nni-1,nni)=0;
        if nni <= md - ET_d
            no_ss(nni:nni+ET_d,1) = no(nni:nni+ET_d,nni);
        
%             no_ss(nni:nni+ET_d,1) = (sum(no(nni:nni+ET_d,nono(hmi-1):nni)')./sum(no(nni:nni+ET_d,nono(hmi-1):nni)'~=0))' ;
%             no_ss(nni:nni+ET_d,1) = (no(nni:nni+ET_d,nono(hmi-1))+3*no(nni:nni+ET_d,nono(hmi)))/4  ;

%             no_ss(nni:nni+ET_d,1) = mean(no(nni:nni+ET_d,1:nni))' ;

        elseif nni > md - ET_d
            no_ss(nni:nni+(md-nni),1) = no(nni:nni+(md-nni),nni);
%             no_ss(nni:nni+(md-nni),1) = (sum(no(nni:nni+(md-nni),nono(hmi-1):nni)')./sum(no(nni:nni+(md-nni),nono(hmi-1):nni)'~=0))' ;
%             no_ss(nni:nni+(md-nni),1) = (no(nni:nni+(md-nni),nono(hmi-1))+3*no(nni:nni+(md-nni),nono(hmi)))/4  ;

        end
    end

    corr(no_ss(760:md), Trend(760:md))
    plot(no_ss); hold on; plot(Trend', 'r');
    plot(rscmn*1.5, 'k:'); hold off;
    %     plot(no_ss); hold on; plot(xxx, 'r'); 
%     plot(sampleinput); hold on; plot(xxx, 'r'); 

    axis([md-50 md -Inf Inf])
    
    if     connectivity*10 == 1
        no_ss1 = no_ss;
    elseif connectivity*10 == 2
        no_ss2 = no_ss;
    elseif connectivity*10 == 3
        no_ss3 = no_ss;
    end
%% GA for ESN trade
                 
LB = [0.30;  0.30];
UB = [1.20;  1.20];
rand('seed',1)
options = gaoptimset('PopulationSize',1000, 'Generations',100);
[SIM_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_SIM, 2, [], [], [], [], LB, UB, [], [], options);
para_SIM = SIM_x; 
% fval_SIM(stnm) = fval; exitflag_SIM(stnm) = exitflag; output_SIM(stnm) = output;
% populaton_SIM(stnm) = population; scores_SIM(stnm,:) = scores;
raw_stock_n_ed(stnm)
prr_id;
prr_esn;
SIM_x;

howmany_S_esn = sum(sell_esn==1);
howmany_B_esn =  sum(buy_esn==1);

% figure
% plot(buy_esn, 'r')
% hold on
% plot(sell_esn, 'b')
% plot(settle_esn*0.5, 'k')
% axis([sd md -Inf Inf])
% hold off


%% Trend - netOut - Price plot
    
pd = sd; % md-246; % 510; % 270; % 750;

    TNP_d = 19; % !!!

    fname = [num2str(stnm),'_Trend vs Nout vs Price']; figure('name', fname, 'Position', [100,80,1200,600]);
    thex = (pd:md); plot(thex, Trend(pd:md,:), 'k'); hold on;
    plot(t2t_hp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'y')
    plot(t2t_lp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'y')
    plot(t2t_cp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'x', 'color', 'k')
    plot(-ones(md,1)*SIM_x(1), 'k')
    plot(+ones(md,1)*SIM_x(2), 'k')
    for i=pd:md
    if buy_esn(i)~=0 
    buy_fig(i) = buy_esn(i).*no_ss(i);
    elseif sell_esn(i)~=0
    sell_fig(i) = sell_esn(i).*no_ss(i);    
    end
    end
    if sum(buy_esn)~=0 && sum(sell_esn)~=0
    plot(buy_fig, 'o', 'color', 'k');
    plot(sell_fig, 'o', 'color', 'k');
    plot(zeros(md,1), 'o', 'color', 'w');
    end
    
    for rd = 1:TNP_d
        
        for i0_esn = 2 : md - rd
            ridx=rand(1);
            if abs(Trend(i0_esn - 1)) == 1 && i0_esn > simt && i0_esn == md - rd
                if ridx <= 0.25
                    plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'c')
                elseif ridx > 0.25 && ridx <= 0.5
                    plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'c')
                elseif ridx > 0.75
                    plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'b')
                else
                    plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'g')                    
                end
            elseif abs(Trend(i0_esn - 1)) == 1 && i0_esn > simt && i0_esn < md - TNP_d
                if ridx <= 0.25
                    plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'c')
                elseif ridx > 0.25 && ridx <= 0.5
                    plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'g')
                elseif ridx > 0.75
                    plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'b')
                else
                    plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'g')                    
                end
            end
        end
        
    end

    plot(thex, no_ss(pd:md,:), 'r'); 
    hold off;
    axis([md-20 md+TNP_d -1.5 1.5])

    profit=[prr_id prr_esn prr_bnh];
    SIM_x;
    net=[netDim specRad connectivity];
    ofbSC;
close
%% Ideal trade

    fname = [num2str(stnm),'_Ideal trade']; 
    figure('name', fname, 'Position', [100,80,1200,600]);
    plot(rscm_test, 'k'); hold on; 
    for i=1:md
        if rscm_test(i)*(Trend(i)==-1) ~= 0
            plot(i,rscm_test(i).*(Trend(i)==-1), 'o', 'color', 'r');
        elseif rscm_test(i)*(Trend(i)==1) ~= 0
            plot(i,rscm_test(i).*(Trend(i)==1), 'o', 'color', 'b');
        end
    end 
    title([num2str(stnm)]); hold off;
    close


%% Correlations

    corr_Trend_Nout = corrcoef( no_ss(simt:md-1,:),Trend(simt+1:md,:) );
    corr_Trend_Nout = corr_Trend_Nout(2);
%     corr_Trend_Nout_recent = corr(no_ss(pd:md-1,:),Trend(pd+1:md,:))

%% KBK

    TNP_d2 = 9;

    fname = [num2str(stnm),'_KBK']; figure('name', fname, 'Position', [100,80,1200,600]);
    for hmi = 1 : hm;
        nni = nono(hmi);
        fp=ceil(hm/4); subplot(fp,4,hmi);
        plot(no(:,nni), 'r'); hold on; plot(Trend, 'k');
%         corr_t(hmi)=corr(no(:,nni), Trend);
        if nni < md -TNP_d2
            corr_ss = corrcoef(no(nni:nni+TNP_d2-1,nni), Trend(nni+1:nni+TNP_d2));
            corr_s(hmi)= corr_ss(2);
        end
        axis([nni-2 nni+TNP_d2 -1.5 1.5]); hold off;
    end
%     corr_t=mean(corr_t)
    corr_s=mean(corr_s(hm-10:size(corr_s,2)));

buy_n_sell=[howmany_B_esn howmany_S_esn];  
corr=[corr_Trend_Nout corr_s];
close
%% ESN trade

    fname = [num2str(stnm),'_ESN trade']; 
    figure('name', fname, 'Position', [80,100,1000,500]);
    subplot(2,1,1)
    plot(rscm, 'k'); hold on;
    for i=1:md
        if buy_esn(i)*rscm(i) ~= 0
            plot(i,buy_esn(i).*rscm(i), 'o', 'color', 'r');
        elseif sell_esn(i)*rscm(i) ~= 0
            plot(i,sell_esn(i).*rscm(i), 'o', 'color', 'b');
        end
    end
    axis([md-150 md min(rscm(sd:md)) max(rscm(sd:md))]);
    subplot(2,1,2)
    plot(no_ss, 'k')
    hold on;
    plot(-ones(md,1)*SIM_x(1), 'r')
    plot(+ones(md,1)*SIM_x(2), 'b')
    plot(-ones(md,1), 'r')
    plot(+ones(md,1), 'b')
    plot(Trend, 'g')
    axis([md-150 md -1.2 1.2]);
    hold off;
    close
%%
    raw_stock_d_ed(1,md)
    raw_stock_n_ed(stnm)
%     options_RSI.Generations
    profit=[prr_id prr_esn prr_bnh]
%     net=[netDim specRad connectivity]
%     buy_n_sell=[howmany_B_esn howmany_S_esn]  
    corr=[corr_Trend_Nout corr_s]
%     eig=[max(abs(eigs(intWM0,1))) max(abs(eigs(intWM,1)))]

%%
if connectivity == .1
    corr1=corr;
profit1=profit;
no_ss1=no_ss;
buy_esn1=buy_esn;
sell_esn1=sell_esn;
buy_n_sell1=buy_n_sell;
SIM_x1=SIM_x;
net1=net;
prr_esn1=prr_esn;
no1=no;
clear corr2 profit2 no_ss2 buy_esn2 sell_esn2 buy_n_sell2 SIM_x2 net2 prr_esn2 no2    
clear corr3 profit3 no_ss3 buy_esn3 sell_esn3 buy_n_sell3 SIM_x3 net3 prr_esn3 no3    
elseif connectivity == .2
corr2=corr;
profit2=profit;
no_ss2=no_ss;
buy_esn2=buy_esn;
sell_esn2=sell_esn;
buy_n_sell2=buy_n_sell;
SIM_x2=SIM_x;
net2=net;
prr_esn2=prr_esn;
no2=no;
clear corr1 profit1 no_ss1 buy_esn1 sell_esn1 buy_n_sell1 SIM_x1 net1 prr_esn1 no1    
clear corr3 profit3 no_ss3 buy_esn3 sell_esn3 buy_n_sell3 SIM_x3 net3 prr_esn3 no3 
elseif connectivity == .3
corr3=corr;
profit3=profit;
no_ss3=no_ss;
buy_esn3=buy_esn;
sell_esn3=sell_esn;
buy_n_sell3=buy_n_sell;
SIM_x3=SIM_x;
net3=net;
prr_esn3=prr_esn;
no3=no;
clear corr1 profit1 no_ss1 buy_esn1 sell_esn1 buy_n_sell1 SIM_x1 net1 prr_esn1 no1    
clear corr2 profit2 no_ss2 buy_esn2 sell_esn2 buy_n_sell2 SIM_x2 net2 prr_esn2 no2    
end

clear corr profit no_ss buy_esn sell_esn buy_n_sell SIM_x net prr_esn no    
    
%% save
ddd=raw_stock_d_ed(1,md);

% cc=clock;
% ccc=cc(2:5);
if stnm==SSE
    save([num2str(SSE),'_ESN_',num2str(connectivity*10)])
elseif stnm==SSEP
    save([num2str(SSEP),'_ESN_',num2str(connectivity*10)])
elseif stnm==HDCB
    save([num2str(HDCB),'_ESN_',num2str(connectivity*10)])
elseif stnm==DSIC
    save([num2str(DSIC),'_ESN_',num2str(connectivity*10)])
elseif stnm==LDCH
    save([num2str(LDCH),'_ESN_',num2str(connectivity*10)])
elseif stnm==GSHS
    save([num2str(GSHS),'_ESN_',num2str(connectivity*10)])
elseif stnm==GS
    save([num2str(GS),'_ESN_',num2str(connectivity*10)])
elseif stnm==LGE
    save([num2str(LGE),'_ESN_',num2str(connectivity*10)])
elseif stnm==LGEP
    save([num2str(LGEP),'_ESN_',num2str(connectivity*10)])
elseif stnm==LGD
    save([num2str(LGD),'_ESN_',num2str(connectivity*10)])
elseif stnm==SEDP
    save([num2str(SEDP),'_ESN_',num2str(connectivity*10)])
elseif stnm==KDEX
    save([num2str(KDEX),'_ESN_',num2str(connectivity*10)])
elseif stnm==SSH
    save([num2str(SSH),'_ESN_',num2str(connectivity*10)])
elseif stnm==KTRN
    save([num2str(KTRN),'_ESN_',num2str(connectivity*10)])
elseif stnm==KIA
    save([num2str(KIA),'_ESN_',num2str(connectivity*10)])
elseif stnm==HDC
    save([num2str(HDC),'_ESN_',num2str(connectivity*10)])
elseif stnm==HDD
    save([num2str(HDD),'_ESN_',num2str(connectivity*10)])
elseif stnm==SSTW
    save([num2str(SSTW),'_ESN_',num2str(connectivity*10)])
elseif stnm==NAV
    save([num2str(NAV),'_ESN_',num2str(connectivity*10)])
elseif stnm==SK
    save([num2str(SK),'_ESN_',num2str(connectivity*10)])
elseif stnm==WRF
    save([num2str(WRF),'_ESN_',num2str(connectivity*10)])
elseif stnm==SHF
    save([num2str(SHF),'_ESN_',num2str(connectivity*10)])
elseif stnm==LTS
    save([num2str(LTS),'_ESN_',num2str(connectivity*10)])
elseif stnm==HDM
    save([num2str(HDM),'_ESN_',num2str(connectivity*10)])
elseif stnm==MIM
    save([num2str(MIM),'_ESN_',num2str(connectivity*10)])
else
    save([num2str(stnm),'_ESN_',num2str(connectivity*10)])
end

% if stnm==SSE
%     save(['SSE',num2str(ddd),'_',num2str(connectivity*10),'_2SIMed_',num2str(stnm),'_',num2str(ccc)])
% elseif stnm==SSEP
%     save(['SSEP',num2str(ddd),'_',num2str(connectivity*10),'_2SIMed_',num2str(stnm),'_',num2str(ccc)])
%%
%     fname = [num2str(stnm),'_Trend vs noss']; figure('name', fname, 'Position', [100,80,1200,600]);
%     plot(t2t_hp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'y'); hold on;
%     plot(t2t_lp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'y')
%     plot(t2t_cp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'o', 'color', 'cyan')
%     plot(-ones(md,1)*SIM_x(1), 'k')
%     plot(+ones(md,1)*SIM_x(2), 'k')
% 
%     thex = (pd:md); plot(thex, Trend(pd:md,:), 'k'); 
%     plot(thex, no_ss(pd:md,:), 'r'); 
%     
%     hold off;
%     axis([md-20 md+5 -1.5 1.5])

%% prr_esn2 simulation

%     th_b = 0.6; 
%     th_s = 0.9;
% 
% buy_esn2 = zeros(md,1); sell_esn2 = zeros(md,1); nstock_esn2 = zeros(md,1);
% poss_esn2 = zeros(md,1); sales_esn2 = zeros(md,1); ssr_esn2 = zeros(md,1);
% gain_esn2 = zeros(md,1); settle_esn2 = zeros(md,1);
% 
% for i2_SIM = sd : md
% 
%     if no_ss(i2_SIM) <= -th_b % buy
%         if no_ss(i2_SIM-1) <= -th_b
%             buy_esn2(i2_SIM-1) = 0;
%             buy_esn2(i2_SIM) = 1;
%         elseif no_ss(i2_SIM-1) > -th_b
%             buy_esn2(i2_SIM) = 1;
%         end
%     elseif no_ss(i2_SIM) >= th_s % sell
%         if no_ss(i2_SIM-1) >= th_s
%             sell_esn2(i2_SIM-1) = 0;
%             sell_esn2(i2_SIM) = 1;
%         elseif no_ss(i2_SIM-1) < th_s
%             sell_esn2(i2_SIM) = 1;
%         end
%     end
%     
% if sum(abs(settle_esn2)) == 0
%     if buy_esn2(i2_SIM) == 1 
%         nstock_esn2(i2_SIM) = floor(seedm/rscm(i2_SIM));
%         poss_esn2(i2_SIM) = rscm(i2_SIM).*nstock_esn2(i2_SIM);
%         settle_esn2(i2_SIM) = -1;
%     end
%     
%     if sell_esn2(i2_SIM) == 1 && sum(poss_esn2(1:i2_SIM)) ~= 0 
%         sales_esn2(i2_SIM) = rscm(i2_SIM).*nstock_esn2(find(nstock_esn2~=0, 1, 'last'));
%         ssr_esn2(i2_SIM) = sales_esn2(i2_SIM).*0.005;
%         
%         gain_esn2(i2_SIM) = sales_esn2(i2_SIM) - poss_esn2(find(poss_esn2~=0, 1, 'last')) - ssr_esn2(i2_SIM);
%         settle_esn2(i2_SIM) = 1;
%     end
%     
% elseif sum(abs(settle_esn2)) ~= 0
%     if buy_esn2(i2_SIM) == 1 && settle_esn2(find(settle_esn2~=0, 1, 'last'))==1 
%         nstock_esn2(i2_SIM) = floor(seedm/rscm(i2_SIM));
%         poss_esn2(i2_SIM) = rscm(i2_SIM).*nstock_esn2(i2_SIM);
%         settle_esn2(i2_SIM) = -1;
%     end
%     
%     if sell_esn2(i2_SIM) == 1 && settle_esn2(find(settle_esn2~=0, 1, 'last'))==-1 
%         sales_esn2(i2_SIM) = rscm(i2_SIM).*nstock_esn2(find(nstock_esn2~=0, 1, 'last'));
%         ssr_esn2(i2_SIM) = sales_esn2(i2_SIM).*0.005;
%         
%         gain_esn2(i2_SIM) = sales_esn2(i2_SIM) - poss_esn2(find(poss_esn2~=0, 1, 'last')) - ssr_esn2(i2_SIM);
%         settle_esn2(i2_SIM) = 1;
%     end
% end
% end
%   
%     total_gain_esn2 = sum(gain_esn2);
% 
%     howmany_S_esn2 = sum(sell_esn2==1)
%     howmany_B_esn2 =  sum(buy_esn2==1)
%     
%     prr_esn2 = total_gain_esn2/seedm
    

%% test Indicators
% 
% nin = 7;
% buy_i = zeros(md,nin);
% sell_i = zeros(md,nin);
% nstock_i = zeros(md,nin);
% poss_i = zeros(md,nin);
% sales_i = zeros(md,nin);
% ssr_i = zeros(md,nin);
% gain_i = zeros(md,nin);
% settle_i = zeros(md,nin);
% 
% total_gain_t = zeros(1,nin);
% prr_t = zeros(1,nin);
% 
% t2t = t2t_pca';
% 
% for i_i = 1:7
%     
%     %     tin = (['t2t_',num2str(i_i),'=t2t(:,',num2str(i_i),')']);
%     %     eval(tin);
%     %
%     %     zoo = (['buy_i_',num2str(i_i),'=zeros(md,1)']);
%     %     eval(zoo);
%     %     zot = (['sell_i_',num2str(i_i),'=zeros(md,1)']);
%     %     eval(zot);
%     
%     for i_sim = sd:md
%         %     if eval(['t2t_',num2str(i_i),'(i_sim)']) < -0.7 % buy_i
%         %         eval(['buy_i_',num2str(i_i),'(i_sim)= 1']) ;
%         %     elseif eval(['t2t_',num2str(i_i),'(i_sim)']) > 0.7 % sell_i
%         %         eval(['sell_i_',num2str(i_i),'(i_sim)= 1']) ;
%         %     end
%         
%         if t2t(i_sim,i_i) < -0.5 % buy_i
%             buy_i(i_sim,i_i) = 1;
%         elseif t2t(i_sim,i_i) > 0.5 % sell_i
%             sell_i(i_sim,i_i) = 1;
%         end
%         
%         %     if eval(['buy_i_',num2str(i_i),'(i_sim)']) == 1 && ...
%         %             (find(eval(['buy_i_',num2str(i_i),'~=0']), 1, 'last')) < (find(eval(['sell_i_',num2str(i_i),'~=0']), 1, 'last'));
%         %     nstock(i_sim) = floor(seedm/rscm(i_sim));
%         %     poss(i_sim) = rscm(i_sim).*nstock(i_sim);
%         %     settle(i_sim) = -1;
%         %     end
%         
%         buy_i2 = buy_i(:,i_i);
%         sell_i2 = sell_i(:,i_i);
%         
%         if sum(buy_i2) == 0 || sum(sell_i2) == 0
%             
%             if buy_i(i_sim,i_i) == 1
%                 nstock_i(i_sim,i_i) = floor(seedm/rscm(i_sim));
%                 poss_i(i_sim,i_i) = rscm(i_sim).*nstock_i(i_sim,i_i);
%                 settle_i(i_sim,i_i) = -1;
%                 nnn=nstock_i(i_sim,i_i);
%             end
%             if sell_i(i_sim,i_i) == 1 && sum(poss_i(1:i_sim)) ~= 0
%                 sales_i(i_sim,i_i) = rscm(i_sim).*nnn; %nstock_i(find(nstock_i(:,i_i)~=0, 1, 'last'));
%                 ssr_i(i_sim,i_i) = sales_i(i_sim,i_i).*0.005;
%                 
%                 gain_i(i_sim,i_i) = sales_i(i_sim,i_i) - poss_i(find(poss_i~=0, 1, 'last')) - ssr_i(i_sim);
%                 settle_i(i_sim,i_i) = 1;
%             end
%             
%         elseif sum(buy_i2) ~= 0 && sum(sell_i2) ~= 0
%             
%             if buy_i(i_sim,i_i) == 1 && ...
%                     find(buy_i2~=0, 1, 'last') < find(sell_i2~=0, 1, 'last');
%                 nstock_i(i_sim,i_i) = floor(seedm/rscm(i_sim));
%                 poss_i(i_sim,i_i) = rscm(i_sim,i_i).*nstock_i(i_sim,i_i);
%                 settle_i(i_sim,i_i) = -1;
%             end
%             
%             %     if eval(['sell_i_',num2str(i_i),'(i_sim)']) == 1 && sum(poss(1:i_sim)) ~= 0 && ...
%             %             (find(eval(['buy_i_',num2str(i_i),'~=0']), 1, 'last')) > (find(eval(['sell_i_',num2str(i_i),'~=0']), 1, 'last'));
%             %     sales(i_sim) = rscm(i_sim).*nstock(find(nstock~=0, 1, 'last'));
%             %     ssr(i_sim) = sales(i_sim).*0.005;
%             %
%             %     gain(i_sim) = sales(i_sim) - poss(find(poss~=0, 1, 'last')) - ssr(i_sim);
%             %     settle(i_sim) = 1;
%             %     end
%             
%             if sell_i(i_sim,i_i) == 1 && sum(poss_i(1:i_sim)) ~= 0 && ...
%                     find(buy_i2~=0, 1, 'last') > find(sell_i2~=0, 1, 'last');
%                 sales_i(i_sim,i_i) = rscm(i_sim).*nstock_i(find(nstock_i~=0, 1, 'last'));
%                 ssr_i(i_sim,i_i) = sales_i(i_sim,i_i).*0.005;
%                 
%                 gain_i(i_sim,i_i) = sales_i(i_sim,i_i) - poss_i(find(poss_i~=0, 1, 'last')) - ssr_i(i_sim);
%                 settle_i(i_sim,i_i) = 1;
%             end
%             
%         end
%         
%     end
% 
% total_gain_t(i_i) = sum(gain_i(:,i_i));
% prr_t(i_i) = total_gain_t(i_i)/seedm;
% 
% % eval(['total_gain_',num2str(i_i),'= sum(gain_i)'])
% % eval(['prr_',num2str(i_i),'=total_gain_',num2str(i_i),'/seedm'])
% 
% % eval(['howmany_S_',num2str(i_i)]) == sum(t2t_',num2str(i_i)]) ==1 
% % eval(['howmany_B_',num2str(i_i)]) == sum(t2t_',num2str(i_i)]) ==-1
% 
% end
% 


%% 
% rc=raw_stock_cp(352,:)'
% rc=double(rc)
% hold on
% plot(rc)
% Trend_1=(Trend==1)
% rc_s = rc.*Trend_1
% plot(rc_s, 'r')
% Trend_b=(Trend==-1);
% rc_b = rc.*Trend_b;
% plot(rc_b, 'g')



    
