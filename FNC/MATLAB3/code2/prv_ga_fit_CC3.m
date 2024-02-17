function [ CC3_fit ] = prv_ga_fit_CC3( CC3_x )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

 global  md rscm rsom rslm rshm Trend ...
         t2t_CC3 

fitness = zeros(md,1);

t2t_CC3 = zeros(md,1);

% CC3_x(1) = Candle_d = 1;
% CC3_x(2) = Candle_e = 1;
% CC3_x(3) = Candle_f = 1;
% CC3_x(4) = Candle_g = 1;

    [PLM1, PLM2] = macd(rslm);
    MCDO_p = PLM1 - PLM2;
    MCDO = (MCDO_p*20) + rslm;
%     plot(PLM1); hold on; plot(PLM2, 'r'); plot(rscm/13, 'k');
%     plot(rshm, 'k'); hold on; plot(MCDO, 'r'); hold off;
    MCDOE = (MCDO - rslm)./1000; 
    MCDOA=tsmovavg(MCDOE, 's', round(CC3_x(3)), 1);
%     plot(MCDOE, 'k'); hold on; plot(MCDOA, 'r'); plot(zeros(md,1), 'k')


for i_CC3 = 1 + 6 : md

 % Engulfing pattern
    
    % small body -> large body engulfs previous one
    % if second is white
    % in the ends of downtrend
    % abs(next day's close - previous day's open) > CC3_x(1)
    % abs(previous day's close - next day's open) > CC3_x(2)
    % --> bullish trend
    if MCDO(i_CC3) > rslm(i_CC3) && MCDOE(i_CC3) > MCDOA(i_CC3) 
%         rscm(i_CC3) > rsom(i_CC3) && ...
%             abs(rscm(i_CC3) - rsom(i_CC3-1)) > CC3_x(1) && ...
%             abs(rscm(i_CC3-1) - rsom(i_CC3)) > CC3_x(2)...
%             && rslm(i_CC3-1)-rslm(i_CC3) > 0 && rslm(i_CC3-1)-rslm(i_CC3) > rshm(i_CC3)-rshm(i_CC3-1)
      
        t2t_CC3(i_CC3) = -1;
    end
    
    %if second is black
    % in the ends of uptrend
    % abs(next day's open - previous day's close) > CC3_x(3)
    % abs(next day's close - previous day's open) > CC3_x(4)
    % --> bearish trend
    if MCDO(i_CC3) < rslm(i_CC3) && MCDOE(i_CC3) < MCDOA(i_CC3) 
%         rscm(i_CC3) < rsom(i_CC3) && ...
%             abs(rsom(i_CC3) - rscm(i_CC3-1)) > CC3_x(3) && ...
%             abs(rscm(i_CC3) - rsom(i_CC3-1)) > CC3_x(4) ...
%             && rshm(i_CC3)-rshm(i_CC3-1) > 0 && rshm(i_CC3)-rshm(i_CC3-1) > rslm(i_CC3-1)-rslm(i_CC3)

        t2t_CC3(i_CC3) = +1;
    end
end % CC3

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CC3( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)�� 0�̸�
                  fitness(fit_i) = max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i); 
               
            elseif sum( t2t_CC3( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)�� 0�� �ƴϸ�
                if t2t_CC3(fit_j) == -1 % S(j)�� -1 �̸�
                        fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i �� j �� �������� fitness ��ġ�� ����
                
                elseif t2t_CC3(fit_j) == 1 ... % S(j)�� 1 �̰�
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                        fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end    
            end
        end
    
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CC3( (Tib+1):(Tin-1) )~=0 ) == 0
                  fitness(fit_i) = rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) ;
                  
            elseif sum( t2t_CC3( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_CC3(fit_j) == 1 
                        fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i �� j �� �������� fitness ��ġ�� ����
                        
                elseif t2t_CC3(fit_j) == -1 ... 
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                        fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end    
            end
        end
    end
end

%     i_CC3
    CC3_x;
    CC3_fit = sum(fitness);

end