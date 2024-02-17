function [ SIM_fit ] = prv_ga_fit_SIM( SIM_x )
%UNTITLED4 Summary of this function goes here
%   Detailed exSIManation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
         t2t_SIM ...
         sd seedm total_gain_id prr_esn ...
         buy_esn sell_esn settle_esn ...
         no_ss prr_bnh
         
     
fitness = zeros(md,1);

% SIM_x(1) = buy threshold
% SIM_x(2) = sell threshold
% SIM_x(3) = 

t2t_SIM = zeros(md,1);

buy_esn = zeros(md,1); sell_esn = zeros(md,1); nstock_esn = zeros(md,1);
poss_esn = zeros(md,1); sales_esn = zeros(md,1); ssr_esn = zeros(md,1);
gain_esn = zeros(md,1); settle_esn = zeros(md,1);

for i_SIM = sd+60 : md

    if no_ss(i_SIM-1) <= -SIM_x(1) % buy
        if no_ss(i_SIM-2) > no_ss(i_SIM-1) && no_ss(i_SIM-1) < no_ss(i_SIM) && (rscm(i_SIM-1) > rscm(i_SIM) || rscm(i_SIM-2) > rscm(i_SIM-1)) 
            buy_esn(i_SIM) = 1;
%         if no_ss(i_SIM-1) <= -SIM_x(1)
%             buy_esn(i_SIM-1) = 0;
%             buy_esn(i_SIM) = 1;
%         elseif no_ss(i_SIM-1) > -SIM_x(1)
%             buy_esn(i_SIM) = 1;
        end
    elseif no_ss(i_SIM-1) >= SIM_x(2) % sell
        if no_ss(i_SIM-2) < no_ss(i_SIM-1) && no_ss(i_SIM-1) > no_ss(i_SIM) && (rscm(i_SIM-1) < rscm(i_SIM) || rscm(i_SIM-2) < rscm(i_SIM-1))
            sell_esn(i_SIM) = 1;
%         if no_ss(i_SIM-1) >= SIM_x(2)
%             sell_esn(i_SIM-1) = 0;
%             sell_esn(i_SIM) = 1;
%         elseif no_ss(i_SIM-1) < SIM_x(2)
%             sell_esn(i_SIM) = 1;
        end
    end
% Trend의 경우와 마찬가지로 동일 신호가 연속해서 나올 때 가장 마지막 신호를 따라야 함
% 하지만 ESN의 경우 그렇게 하기 어려움...
    
if sum(abs(settle_esn)) == 0
    if buy_esn(i_SIM) == 1 
        nstock_esn(i_SIM) = floor(seedm/rscm(i_SIM));
        poss_esn(i_SIM) = rscm(i_SIM).*nstock_esn(i_SIM);
        settle_esn(i_SIM) = -1;
    end
    
    if sell_esn(i_SIM) == 1 && sum(poss_esn(1:i_SIM)) ~= 0 
        sales_esn(i_SIM) = rscm(i_SIM).*nstock_esn(find(nstock_esn~=0, 1, 'last'));
        ssr_esn(i_SIM) = sales_esn(i_SIM).*0.005;
        
        gain_esn(i_SIM) = sales_esn(i_SIM) - poss_esn(find(poss_esn~=0, 1, 'last')) - ssr_esn(i_SIM);
        settle_esn(i_SIM) = 1;
    end
    
elseif sum(abs(settle_esn)) ~= 0
    if buy_esn(i_SIM) == 1 && settle_esn(find(settle_esn~=0, 1, 'last'))==1 
        % &&  find(buy_esn(sd:i_sim2-1)~=0,1,'last') < find(sell_esn(sd:i_sim2-1)~=0,1,'last')  
        % (find(buy_esn~=0, 1, 'last')) < (find(sell_esn~=0, 1, 'last'))
        nstock_esn(i_SIM) = floor(seedm/rscm(i_SIM));
        poss_esn(i_SIM) = rscm(i_SIM).*nstock_esn(i_SIM);
        settle_esn(i_SIM) = -1;
    end
    
    if sell_esn(i_SIM) == 1 && settle_esn(find(settle_esn~=0, 1, 'last'))==-1 
        % && (find(buy_esn(sd:i_sim2-1)~=0, 1, 'last')) > (find(sell_esn(sd:i_sim2-1)~=0, 1, 'last'))
        sales_esn(i_SIM) = rscm(i_SIM).*nstock_esn(find(nstock_esn~=0, 1, 'last'));
        ssr_esn(i_SIM) = sales_esn(i_SIM).*0.005;
        
        gain_esn(i_SIM) = sales_esn(i_SIM) - poss_esn(find(poss_esn~=0, 1, 'last')) - ssr_esn(i_SIM);
        settle_esn(i_SIM) = 1;
    end
end
end
  
    total_gain_esn = sum(gain_esn);

    for fit_i = sd:md

    fitness(fit_i) = total_gain_id - total_gain_esn; 
    
    end

prr_esn = total_gain_esn/seedm;
prr_bnh = (round(seedm/rscm(sd))*rscm(md) - round(seedm/rscm(sd))*rscm(sd))/seedm;

    i_SIM;
    SIM_x;
    SIM_fit = sum(fitness);
    
end
