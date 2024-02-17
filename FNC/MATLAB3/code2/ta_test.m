ttt = 400;
ppp = mean(rscm(md-ttt:md));
%%
close
fname = [num2str(stnm),'_RSI'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_RSI_bb(i) ~= 0
        plot(i,t2t_RSI_bb(i), 'o', 'color', 'r');
    elseif t2t_RSI_ss(i) ~= 0 
        plot(i,t2t_RSI_ss(i), 'o', 'color', 'b');
    end
end
hold off; 
axis([md-ttt md ppp*0.5 ppp*1.5])
% RSI;
% figure('name', 'RSI_test', 'Position', [10,50,1200,600]);
% plot(rscm, 'k'); hold on;
% RSI_ob=10*(RSI.*(RSI-50 > 0));
% RSI_os=10*(RSI.*(RSI-50 < 0));
% for i=1:md
%     if RSI_ob(i) ~= 0 && RSI(i) > RSI_x(2)
%         plot(i,rscm(i)+RSI_ob(i), 'o', 'color', 'b')
%     elseif RSI_os(i) ~= 0 && RSI(i) < RSI_x(3)
%         plot(i,rscm(i)-RSI_os(i), 'o', 'color', 'r')
%     end
% end
% hold off;
%%
close
fname = [num2str(stnm),'_RC'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_RC_bb(i) ~= 0
        plot(i,t2t_RC_bb(i), 'o', 'color', 'r');
    elseif t2t_RC_ss(i) ~= 0 
        plot(i,t2t_RC_ss(i), 'o', 'color', 'b');
    end
end
hold off;
axis([md-ttt md ppp*0.5 ppp*1.5])
% sROC;
% lROC;
% figure('name', 'RC_test', 'Position', [10,50,1200,600]);
% plot(1:md,sROC, 'k'); hold on; plot(ones(md,1)*100, 'k');
% plot(ones(md,1)*RC_x(3), 'g'); plot(ones(md,1)*RC_x(4), 'g');
% plot(100+ones(md,1)*RC_x(5), 'k'); plot(100-ones(md,1)*RC_x(6), 'k');
% plot(1:md,lROC, 'g'); hold off; axis([50 md mean(lROC)*0.5 Inf]);
%%
close
fname = [num2str(stnm),'_MTM'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_MTM_bb(i) ~= 0
        plot(i,t2t_MTM_bb(i), 'o', 'color', 'r');
    elseif t2t_MTM_ss(i) ~= 0 
        plot(i,t2t_MTM_ss(i), 'o', 'color', 'b');
    end
end
hold off;
axis([md-ttt md ppp*0.5 ppp*1.5])
% M2M; 
% mtm; 
% MTM;
% figure('name', 'MTM_test', 'Position', [10,50,1200,600]);
% plot(M2M, 'k'); hold on; plot(zeros(md,1)*100, 'k');
% plot(ones(md,1)*MTM_x(2), 'r'); plot(ones(md,1)*(MTM_x(2)-MTM_x(3)), 'r');
% plot(ones(md,1)*MTM_x(4), 'b'); plot(ones(md,1)*(MTM_x(4)+MTM_x(5)), 'b');
% hold off; axis([1 md -1.2 1.2]);
%%
close
fname = [num2str(stnm),'_SS'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_SS_bb(i) ~= 0
        plot(i,t2t_SS_bb(i), 'o', 'color', 'r');
    elseif t2t_SS_ss(i) ~= 0 
        plot(i,t2t_SS_ss(i), 'o', 'color', 'b');
    end
end
hold off;
axis([md-ttt md ppp*0.5 ppp*1.5])
% pKD;
% pK;
% pD;
% figure('name', 'SS_test', 'Position', [10,50,1200,600]);
% plot(pK, 'k'); hold on; plot(pD, 'g'); 
% plot(ones(md,1)*SS_x(1), 'r'); plot(ones(md,1)*SS_x(3), 'b');
% hold off; axis([1 md -Inf Inf])
% % figure('name', 'SS_test_b', 'Position', [10,50,1200,600]);
% % plot(pK-pD, 'k'); hold on; plot(ones(md,1)*SS_x(2), 'r'); hold off; axis([1 md -Inf Inf])
% % figure('name', 'SS_test_s', 'Position', [10,50,1200,600]);
% % plot(pD-pK, 'k'); hold on; plot(ones(md,1)*SS_x(4), 'b'); hold off; axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_CC1'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_CC1_bb(i) ~= 0
        plot(i,t2t_CC1_bb(i), 'o', 'color', 'r');
    elseif t2t_CC1_ss(i) ~= 0 
        plot(i,t2t_CC1_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% wicks; 
% tails;
% bodies;
% figure('name', 'CC1_test_B', 'Position', [10,50,1200,600]);
% plot(wicks./bodies, 'k'); hold on; plot(ones(md,1)*CC1_x(1), 'r'); hold off;
% figure('name', 'CC1_test_S', 'Position', [10,50,1200,600]);
% plot(tails./bodies, 'k'); hold on; plot(ones(md,1)*CC1_x(2), 'b'); hold off; 
% axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_CC2'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_CC2_bb(i) ~= 0
        plot(i,t2t_CC2_bb(i), 'o', 'color', 'r');
    elseif t2t_CC2_ss(i) ~= 0 
        plot(i,t2t_CC2_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% CC2B; CC2S;
% figure('name', 'CC2_test_B', 'Position', [10,50,1200,600]);
% plot(CC2B, 'k'); hold on; plot(ones(md,1)*CC1_x(2), 'r'); hold off;
% figure('name', 'CC2_test_S', 'Position', [10,50,1200,600]);
% plot(CC2S, 'k'); hold on; plot(ones(md,1)*CC1_x(1), 'b'); hold off; 
% axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_CC3'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_CC3_bb(i) ~= 0
        plot(i,t2t_CC3_bb(i), 'o', 'color', 'r');
    elseif t2t_CC3_ss(i) ~= 0 
        plot(i,t2t_CC3_ss(i), 'o', 'color', 'b');
    end
end
hold off;
axis([md-ttt md ppp*0.5 ppp*1.5])
%%
close
fname = [num2str(stnm),'_MA'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_MA_bb(i) ~= 0
        plot(i,t2t_MA_bb(i), 'o', 'color', 'r');
    elseif t2t_MA_ss(i) ~= 0 
        plot(i,t2t_MA_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% Dipa;
% figure('name', 'MA_test', 'Position', [10,50,1200,600]);
% plot(Dipa, 'k'); hold on; 
% plot(ones(md,1)*MA_x(2), 'b'); plot(ones(md,1)*MA_x(3), 'r'); 
% hold off; axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_VR'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_VR_bb(i) ~= 0
        plot(i,t2t_VR_bb(i), 'o', 'color', 'r');
    elseif t2t_VR_ss(i) ~= 0 
        plot(i,t2t_VR_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% VR;
% figure('name', 'VR_test', 'Position', [10,50,1200,600]);
% plot(VR, 'k'); hold on; 
% plot(ones(md,1)*VR_x(2), 'r'); plot(ones(md,1)*VR_x(3), 'r'); 
% plot(ones(md,1)*VR_x(4), 'b'); plot(ones(md,1)*VR_x(5), 'b'); 
% hold off; axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_PL'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_PL_bb(i) ~= 0
        plot(i,t2t_PL_bb(i), 'o', 'color', 'r');
    elseif t2t_PL_ss(i) ~= 0 
        plot(i,t2t_PL_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% PL;
% figure('name', 'PL_test', 'Position', [10,50,1200,600]);
% plot(PL, 'k'); hold on; 
% plot(ones(md,1)*PL_x(2), 'b'); plot(ones(md,1)*PL_x(3), 'r'); 
% hold off; axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_MFI'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_MFI_bb(i) ~= 0
        plot(i,t2t_MFI_bb(i), 'o', 'color', 'r');
    elseif t2t_MFI_ss(i) ~= 0 
        plot(i,t2t_MFI_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% MFI;
% figure('name', 'MFI_test', 'Position', [10,50,1200,600]);
% plot(MFI, 'k'); hold on; 
% plot(ones(md,1)*MFI_x(2), 'b'); plot(ones(md,1)*MFI_x(3), 'r'); 
% hold off; axis([1 md -Inf Inf])
%%
close
fname = [num2str(stnm),'_PNVI'];
figure('name', fname, 'Position', [10,50,1200,600]); plot(rscm, 'k');
hold on; 
for i=1:md
    if t2t_PNVI_bb(i) ~= 0
        plot(i,t2t_PNVI_bb(i), 'o', 'color', 'r');
    elseif t2t_PNVI_ss(i) ~= 0 
        plot(i,t2t_PNVI_ss(i), 'o', 'color', 'b');
    end
end
hold off
axis([md-ttt md ppp*0.5 ppp*1.5])
% figure('name', 'PNVI_test_p', 'Position', [10,50,1200,600]);
% plot(pvi, 'k'); hold on; 
% plot(pvi_ma, 'b'); hold off; axis([1 md -Inf Inf])
% figure('name', 'PNVI_test_n', 'Position', [10,50,1200,600]);
% plot(nvi, 'k'); hold on; 
% plot(nvi_ma, 'r'); hold off; axis([1 md -Inf Inf])


