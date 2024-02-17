clear global buy_esn sell_esn prr_esn prr_bnh no
      global buy_esn sell_esn prr_esn prr_bnh no_ss

% close all

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
  
        elseif nni > md - ET_d
            no_ss(nni:nni+(md-nni),1) = no(nni:nni+(md-nni),nni);

        end
    end

    figure;
%     plot(no_ss); hold on; plot(Trend', 'r');
%     plot(rscmn*2, 'k:'); hold off;

    plot(no_ss); hold on; plot(sampleout, 'r'); hold off; 
    corr(no_ss(md-100:md), sampleout(md-100:md)')
%     plot(sampleinput); hold on; plot(xxx, 'r'); 

    axis([md-50 md -Inf Inf])
    

% %% Trend - netOut - Price plot
%     
% pd = sd; % md-246; % 510; % 270; % 750;
% 
%     TNP_d = 19; % !!!
% 
%     fname = [num2str(stnm),'_Trend vs Nout vs Price']; figure('name', fname, 'Position', [100,80,1200,600]);
%     thex = (pd:md); plot(thex, Trend(pd:md,:), 'k'); hold on;
%     plot(t2t_hp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'y')
%     plot(t2t_lp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'y')
%     plot(t2t_cp_m(:,stm)/round(mean(rscm(md-10:md)))*10-10, 'x', 'color', 'k')
%     plot(-ones(md,1)*SIM_x(1), 'k')
%     plot(+ones(md,1)*SIM_x(2), 'k')
%     for i=pd:md
%     if buy_esn(i)~=0 
%     buy_fig(i) = buy_esn(i).*no_ss(i);
%     elseif sell_esn(i)~=0
%     sell_fig(i) = sell_esn(i).*no_ss(i);    
%     end
%     end
%     if sum(buy_esn)~=0 && sum(sell_esn)~=0
%     plot(buy_fig, 'o', 'color', 'k');
%     plot(sell_fig, 'o', 'color', 'k');
%     plot(zeros(md,1), 'o', 'color', 'w');
%     end
%     
%     for rd = 1:TNP_d
%         
%         for i0_esn = 2 : md - rd
%             ridx=rand(1);
%             if abs(Trend(i0_esn - 1)) == 1 && i0_esn > simt && i0_esn == md - rd
%                 if ridx <= 0.25
%                     plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'c')
%                 elseif ridx > 0.25 && ridx <= 0.5
%                     plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'c')
%                 elseif ridx > 0.75
%                     plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'b')
%                 else
%                     plot((i0_esn:i0_esn+rd), no(i0_esn:i0_esn+rd,i0_esn), 'g')                    
%                 end
%             elseif abs(Trend(i0_esn - 1)) == 1 && i0_esn > simt && i0_esn < md - TNP_d
%                 if ridx <= 0.25
%                     plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'c')
%                 elseif ridx > 0.25 && ridx <= 0.5
%                     plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'g')
%                 elseif ridx > 0.75
%                     plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'b')
%                 else
%                     plot((i0_esn:i0_esn+TNP_d), no(i0_esn:i0_esn+TNP_d,i0_esn), 'g')                    
%                 end
%             end
%         end
%         
%     end
% 
%     plot(thex, no_ss(pd:md,:), 'r'); 
%     hold off;
%     axis([md-20 md+TNP_d -1.5 1.5])
% 
%     profit=[prr_id prr_esn prr_bnh];
%     SIM_x;
%     net=[netDim specRad connectivity];
%     ofbSC;
% close
% %% Ideal trade
% 
%     fname = [num2str(stnm),'_Ideal trade']; 
%     figure('name', fname, 'Position', [100,80,1200,600]);
%     plot(rscm_test, 'k'); hold on; 
%     for i=1:md
%         if rscm_test(i)*(Trend(i)==-1) ~= 0
%             plot(i,rscm_test(i).*(Trend(i)==-1), 'o', 'color', 'r');
%         elseif rscm_test(i)*(Trend(i)==1) ~= 0
%             plot(i,rscm_test(i).*(Trend(i)==1), 'o', 'color', 'b');
%         end
%     end 
%     title([num2str(stnm)]); hold off;
%     close
% 
% 
% %% Correlations
% 
%     corr_Trend_Nout = corrcoef( no_ss(simt:md-1,:),Trend(simt+1:md,:) );
%     corr_Trend_Nout = corr_Trend_Nout(2);
% %     corr_Trend_Nout_recent = corr(no_ss(pd:md-1,:),Trend(pd+1:md,:))
% 
% %% KBK
% 
%     TNP_d2 = 9;
% 
%     fname = [num2str(stnm),'_KBK']; figure('name', fname, 'Position', [100,80,1200,600]);
%     for hmi = 1 : hm;
%         nni = nono(hmi);
%         fp=ceil(hm/4); subplot(fp,4,hmi);
%         plot(no(:,nni), 'r'); hold on; plot(Trend, 'k');
% %         corr_t(hmi)=corr(no(:,nni), Trend);
%         if nni < md -TNP_d2
%             corr_ss = corrcoef(no(nni:nni+TNP_d2-1,nni), Trend(nni+1:nni+TNP_d2));
%             corr_s(hmi)= corr_ss(2);
%         end
%         axis([nni-2 nni+TNP_d2 -1.5 1.5]); hold off;
%     end
% %     corr_t=mean(corr_t)
%     corr_s=mean(corr_s(hm-10:size(corr_s,2)));
% 
% buy_n_sell=[howmany_B_esn howmany_S_esn];  
% corr=[corr_Trend_Nout corr_s];
% close
% %% ESN trade
% 
%     fname = [num2str(stnm),'_ESN trade']; 
%     figure('name', fname, 'Position', [80,100,1000,500]);
%     subplot(2,1,1)
%     plot(rscm, 'k'); hold on;
%     for i=1:md
%         if buy_esn(i)*rscm(i) ~= 0
%             plot(i,buy_esn(i).*rscm(i), 'o', 'color', 'r');
%         elseif sell_esn(i)*rscm(i) ~= 0
%             plot(i,sell_esn(i).*rscm(i), 'o', 'color', 'b');
%         end
%     end
%     axis([md-150 md min(rscm(sd:md)) max(rscm(sd:md))]);
%     subplot(2,1,2)
%     plot(no_ss, 'k')
%     hold on;
%     plot(-ones(md,1)*SIM_x(1), 'r')
%     plot(+ones(md,1)*SIM_x(2), 'b')
%     plot(-ones(md,1), 'r')
%     plot(+ones(md,1), 'b')
%     plot(Trend, 'g')
%     axis([md-150 md -1.2 1.2]);
%     hold off;
%     close
% %%
%     raw_stock_d_ed(1,md)
%     raw_stock_n_ed(stnm)
% %     options_RSI.Generations
%     profit=[prr_id prr_esn prr_bnh]
% %     net=[netDim specRad connectivity]
% %     buy_n_sell=[howmany_B_esn howmany_S_esn]  
%     corr=[corr_Trend_Nout corr_s]
% %     eig=[max(abs(eigs(intWM0,1))) max(abs(eigs(intWM,1)))]
% 
