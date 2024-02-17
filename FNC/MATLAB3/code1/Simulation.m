clear global seedm sd total_gain_id
global seedm sd total_gain_id

%% Trading Simulation

rscm = raw_stock_cp_m;
rsom = raw_stock_op_m;

sd = md-246 %+120; % 510; % 750; % 270;
md = max_duration;
period = ((md - sd)/20)/12

seedm = 10000000;

%% ideal trade

buy = zeros(md,1); sell = zeros(md,1); nstock = zeros(md,1);
poss = zeros(md,1); sales = zeros(md,1); ssr = zeros(md,1);
gain = zeros(md,1); settle = zeros(md,1);

for i_sim = sd:md
    if Trend(i_sim) == -1 % buy
        if Trend(i_sim) == Trend(i_sim-1)
            buy(i_sim) = 1;
            buy(i_sim-1) = 0; 
        elseif Trend(i_sim) < Trend(i_sim-1)
            buy(i_sim) = 1;
        end
        
    elseif Trend(i_sim) == 1 % sell   
        if Trend(i_sim) == Trend(i_sim-1)
            sell(i_sim) = 1;
            sell(i_sim-1) = 0;
        elseif Trend(i_sim) > Trend(i_sim-1)
            sell(i_sim) = 1;
        end
    end
% 1이나 -1이 연속해서 나올 때, 
% 가장 먼저 나오는 포인트보단 마지막 포인트에서 거래를 하는 게 훨씬 낫다 
           
    
if sum(abs(settle)) == 0
    if buy(i_sim) == 1
    nstock(i_sim) = floor(seedm/rscm(i_sim));
    poss(i_sim) = rscm(i_sim).*nstock(i_sim);
    settle(i_sim) = -1;
    end
    
    if sell(i_sim) == 1 && sum(poss(1:i_sim)) ~= 0
    sales(i_sim) = rscm(i_sim).*nstock(find(nstock~=0, 1, 'last'));
    ssr(i_sim) = sales(i_sim).*0.005;

    gain(i_sim) = sales(i_sim) - poss(find(poss~=0, 1, 'last')) - ssr(i_sim);
    settle(i_sim) = 1;
    end

elseif sum(abs(settle)) ~= 0
    if buy(i_sim) == 1 && settle(find(settle~=0, 1, 'last'))==1
    nstock(i_sim) = floor(seedm/rscm(i_sim));
    poss(i_sim) = rscm(i_sim).*nstock(i_sim);
    settle(i_sim) = -1;
    end
    
    if sell(i_sim) == 1 && settle(find(settle~=0, 1, 'last'))==-1
    sales(i_sim) = rscm(i_sim).*nstock(find(nstock~=0, 1, 'last'));
    ssr(i_sim) = sales(i_sim).*0.005;

    gain(i_sim) = sales(i_sim) - poss(find(poss~=0, 1, 'last')) - ssr(i_sim);
    settle(i_sim) = 1;
    end
end
end


%% results

total_gain_id = sum(gain);
raw_stock_n_ed(stnm)
prr_id = total_gain_id/seedm

howmany_S = sum(sell(sd:md)==1)
howmany_B = sum(buy(sd:md)==1)

% figure
% plot(buy, 'r')
% hold on
% plot(sell, 'g')
% plot(settle*0.5, 'k')
% axis([sd md -Inf Inf])
% hold off
% 
% figure
% pnm = num2str(stnm);
% plot(buy.*rscm, 'r')
% title(pnm)
% hold on
% plot(sell.*rscm, 'g')
% plot(rscm, 'k')
% hold off

