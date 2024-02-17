function [ ESN_fit ] = prv_ga_fit_ESN( ESN_x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm Trend ...
         t2t_ESN ...
         sd seedm total_gain_id prr_esn ...
         buy_esn sell_esn settle_esn ...
         no_ss prr_bnh
         
     
fitness = zeros(md,1);

% ESN_x(1) = buy threshold
% ESN_x(2) = sell threshold
% ESN_x(3) = 

t2t_ESN = zeros(md,1);

buy_esn = zeros(md,1); sell_esn = zeros(md,1); nstock_esn = zeros(md,1);
poss_esn = zeros(md,1); sales_esn = zeros(md,1); ssr_esn = zeros(md,1);
gain_esn = zeros(md,1); settle_esn = zeros(md,1);

for i_ESN = sd+60 : md

    if no_ss(i_ESN-1) <= -ESN_x(1) % buy
        if no_ss(i_ESN-2) > no_ss(i_ESN-1) && no_ss(i_ESN-1) < no_ss(i_ESN) && (rscm(i_ESN-1) > rscm(i_ESN) || rscm(i_ESN-2) > rscm(i_ESN-1)) 
            buy_esn(i_ESN) = 1;
%         if no_ss(i_ESN-1) <= -ESN_x(1)
%             buy_esn(i_ESN-1) = 0;
%             buy_esn(i_ESN) = 1;
%         elseif no_ss(i_ESN-1) > -ESN_x(1)
%             buy_esn(i_ESN) = 1;
        end
    elseif no_ss(i_ESN-1) >= ESN_x(2) % sell
        if no_ss(i_ESN-2) < no_ss(i_ESN-1) && no_ss(i_ESN-1) > no_ss(i_ESN) && (rscm(i_ESN-1) < rscm(i_ESN) || rscm(i_ESN-2) < rscm(i_ESN-1))
            sell_esn(i_ESN) = 1;
%         if no_ss(i_ESN-1) >= ESN_x(2)
%             sell_esn(i_ESN-1) = 0;
%             sell_esn(i_ESN) = 1;
%         elseif no_ss(i_ESN-1) < ESN_x(2)
%             sell_esn(i_ESN) = 1;
        end
    end
% Trend의 경우와 마찬가지로 동일 신호가 연속해서 나올 때 가장 마지막 신호를 따라야 함
% 하지만 ESN의 경우 그렇게 하기 어려움...
    
if sum(abs(settle_esn)) == 0
    if buy_esn(i_ESN) == 1 
        nstock_esn(i_ESN) = floor(seedm/rscm(i_ESN));
        poss_esn(i_ESN) = rscm(i_ESN).*nstock_esn(i_ESN);
        settle_esn(i_ESN) = -1;
    end
    
    if sell_esn(i_ESN) == 1 && sum(poss_esn(1:i_ESN)) ~= 0 
        sales_esn(i_ESN) = rscm(i_ESN).*nstock_esn(find(nstock_esn~=0, 1, 'last'));
        ssr_esn(i_ESN) = sales_esn(i_ESN).*0.005;
        
        gain_esn(i_ESN) = sales_esn(i_ESN) - poss_esn(find(poss_esn~=0, 1, 'last')) - ssr_esn(i_ESN);
        settle_esn(i_ESN) = 1;
    end
    
elseif sum(abs(settle_esn)) ~= 0
    if buy_esn(i_ESN) == 1 && settle_esn(find(settle_esn~=0, 1, 'last'))==1 
        % &&  find(buy_esn(sd:i_ESN2-1)~=0,1,'last') < find(sell_esn(sd:i_ESN2-1)~=0,1,'last')  
        % (find(buy_esn~=0, 1, 'last')) < (find(sell_esn~=0, 1, 'last'))
        nstock_esn(i_ESN) = floor(seedm/rscm(i_ESN));
        poss_esn(i_ESN) = rscm(i_ESN).*nstock_esn(i_ESN);
        settle_esn(i_ESN) = -1;
    end
    
    if sell_esn(i_ESN) == 1 && settle_esn(find(settle_esn~=0, 1, 'last'))==-1 
        % && (find(buy_esn(sd:i_ESN2-1)~=0, 1, 'last')) > (find(sell_esn(sd:i_sim2-1)~=0, 1, 'last'))
        sales_esn(i_ESN) = rscm(i_ESN).*nstock_esn(find(nstock_esn~=0, 1, 'last'));
        ssr_esn(i_ESN) = sales_esn(i_ESN).*0.005;
        
        gain_esn(i_ESN) = sales_esn(i_ESN) - poss_esn(find(poss_esn~=0, 1, 'last')) - ssr_esn(i_ESN);
        settle_esn(i_ESN) = 1;
    end
end
end
  
    total_gain_esn = sum(gain_esn);

    for fit_i = sd:md

    fitness(fit_i) = total_gain_id - total_gain_esn; 
    
    end

prr_esn = total_gain_esn/seedm;
prr_bnh = (round(seedm/rscm(sd))*rscm(md) - round(seedm/rscm(sd))*rscm(sd))/seedm;

    i_ESN;
    ESN_x;
    ESN_fit = sum(fitness);
    
end
