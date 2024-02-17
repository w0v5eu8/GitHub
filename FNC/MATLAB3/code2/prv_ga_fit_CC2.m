function [ CC2_fit ] = prv_ga_fit_CC2( CC2_x )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

 global  md rscm rsom rslm rshm Trend ...
         t2t_CC2 bodies CC2B CC2S

fitness = zeros(md,1);

t2t_CC2 = zeros(md,1);
CC2B = zeros(md,1);
CC2S = zeros(md,1);

% CC2_x(1) = Candle_b = 1;
% CC2_x(2) = Candle_c = 1;


    [PLM1, PLM2] = macd(rshm);
    MCDO_p = PLM1 - PLM2;
    MCDO = (MCDO_p*20) + rshm;
%     plot(PLM1); hold on; plot(PLM2, 'r'); plot(rscm/13, 'k');
%     plot(rshm, 'k'); hold on; plot(MCDO, 'r'); hold off;
    MCDOE = (MCDO - rshm)./1000; 
    MCDOA=tsmovavg(MCDOE, 's', round(CC2_x(3)), 1);
%     plot(MCDOE, 'k'); hold on; plot(MCDOA, 'r'); plot(zeros(md,1), 'k')


for i_CC2 = 2 : md

    CC2S(i_CC2) = (abs(rscm(i_CC2) - rsom(i_CC2-1)) / bodies(i_CC2-1));
    CC2B(i_CC2) = (abs(rsom(i_CC2-1) - rscm(i_CC2)) / bodies(i_CC2-1));
    
   % Dark Cloud Cover
    % white -> black
    % (abs(next day's close - previous day's open) / the length of previous candle stick's body ) < candle_b
    % --> future bearigh trend
    if MCDO(i_CC2) < rshm(i_CC2) && MCDOE(i_CC2) < MCDOA(i_CC2) 
%         rscm(i_CC2-1) > rsom(i_CC2-1) && rscm(i_CC2) < rsom(i_CC2) && ...
%             CC2S(i_CC2) < CC2_x(1) ...
%             && rshm(i_CC2)-rshm(i_CC2-1) > 0 && rshm(i_CC2)-rshm(i_CC2-1) > rslm(i_CC2-1)-rslm(i_CC2)
        t2t_CC2(i_CC2) = +1;

    end
    
    % Piercing Line
    % black -> white
    % (abs(pervioud day's open - next day's close) / the length of previous candle stick's body ) < candle_c
    % --> future bullish trend
    if MCDO(i_CC2) > rshm(i_CC2) && MCDOE(i_CC2) > MCDOA(i_CC2) 
%         rscm(i_CC2-1) < rsom(i_CC2-1) && rscm(i_CC2) > rsom(i_CC2) && ...
%             CC2B(i_CC2) < CC2_x(2) ...
%             && rslm(i_CC2-1)-rslm(i_CC2) > 0 && rslm(i_CC2-1)-rslm(i_CC2) > rshm(i_CC2)-rshm(i_CC2-1)
        t2t_CC2(i_CC2) = -1;

    end
end % CC2

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CC2( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                  fitness(fit_i) = max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i); 
               
            elseif sum( t2t_CC2( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_CC2(fit_j) == -1 % S(j)가 -1 이면
                        fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                
                elseif t2t_CC2(fit_j) == 1 ... % S(j)가 1 이고
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                        fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end    
            end
        end
    
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CC2( (Tib+1):(Tin-1) )~=0 ) == 0
                  fitness(fit_i) = rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) ;
                  
            elseif sum( t2t_CC2( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_CC2(fit_j) == 1 
                        fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                        
                elseif t2t_CC2(fit_j) == -1 ... 
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                        fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end    
            end
        end
    end
end

%     i_CC2
    CC2_x;
    CC2_fit = sum(fitness);
    
end
