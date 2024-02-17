%%
global md
clc
%     raw_stock_d_ed(1,md)
%     raw_stock_n_ed(stnm)
%     options_RSI.Generations
    profit=[prr_id prr_bnh 0;prr_esn1 prr_esn2 prr_esn3]
%     net=[netDim specRad connectivity]
%     buy_n_sell=[howmany_B_esn howmany_S_esn]  
    corr=[corr1 ; corr2 ; corr3]
%     eig=[max(abs(eigs(intWM0,1))) max(abs(eigs(intWM,1)))]
%     fname = [num2str(stnm),'_ESN trade']; 
%     figure('name', fname, 'Position', [80,100,1000,500]);
%     subplot(2,1,1)
%     plot(rscm, 'k'); hold on;
%     for i=1:md
%         if buy_esn1(i)*rscm(i) ~= 0
%             plot(i,buy_esn1(i).*rscm(i), 'o', 'color', 'r');
%         elseif sell_esn1(i)*rscm(i) ~= 0
%             plot(i,sell_esn1(i).*rscm(i), 'o', 'color', 'b');
%         end
%     end
%     for i=1:md
%         if buy_esn2(i)*rscm(i) ~= 0
%             plot(i,buy_esn2(i).*rscm(i), 'o', 'color', 'r');
%         elseif sell_esn2(i)*rscm(i) ~= 0
%             plot(i,sell_esn2(i).*rscm(i), 'o', 'color', 'b');
%         end
%     end
%     for i=1:md
%         if buy_esn3(i)*rscm(i) ~= 0
%             plot(i,buy_esn3(i).*rscm(i), 'o', 'color', 'r');
%         elseif sell_esn3(i)*rscm(i) ~= 0
%             plot(i,sell_esn3(i).*rscm(i), 'o', 'color', 'b');
%         end
%     end    
%     axis([md-150 md min(rscm(sd:md)) max(rscm(sd:md))]);
%     subplot(2,1,2)
%     plot(no_ss1, 'k')
%     hold on;
%     plot(no_ss2, 'k')
%     plot(no_ss3, 'k')
%     plot(-ones(md,1)*SIM_x1(1), 'r')
%     plot(+ones(md,1)*SIM_x1(2), 'b')
%     plot(-ones(md,1)*SIM_x2(1), 'r')
%     plot(+ones(md,1)*SIM_x2(2), 'b')
%     plot(-ones(md,1)*SIM_x3(1), 'r')
%     plot(+ones(md,1)*SIM_x3(2), 'b')
%     plot(-ones(md,1), 'r')
%     plot(+ones(md,1), 'b')
%     plot(Trend, 'g')
%     axis([md-150 md -1.2 1.2]);
%     
% 
%     hold off;
    
    final1(1:3,indx)=no_ss1(998:1000,1);
    final2(1:3,indx)=no_ss2(998:1000,1);
    final3(1:3,indx)=no_ss3(998:1000,1);
%     fn=[num2str(ddd),'.jpg'];
%     saveas(gcf,fn)
%     close