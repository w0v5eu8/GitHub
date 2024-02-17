function [ WR_fit ] = prv_ga_fit_WR( WR_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
         t2t_WR WPCTR

%     WPCTR = willpctr(HIGHP, LOWP, CLOSEP, NPERIODS) calculates the 
%     Williams PercentR (%R) values for the given set of stock prices for
%     a specified number of periods (NPERIODS).  NPERIODS must be a scalar
%     integer.  If NPERIODS is not provided, a 14-period default is used.     

fitness = zeros(md,1);

t2t_WR = zeros(md,1);

PDM = zeros(md,1);
MDM = zeros(md,1);
TR = zeros(md,1);
PDI = zeros(md,1);
MDI = zeros(md,1);
DX = zeros(md,1);
ADX = zeros(md,1);

% WR_x(1) = 기간
% WR_x(2) = -100 과매도 기준
% WR_x(3) = -100 에서 -? 까지 오르면 매수
% WR_x(4) = 0 과매수 기준
% WR_x(5) = 0 에서 -? 까지 떨어지면 매도
% WR_x(6) = 며칠전에 같은 패턴이 나와야 - 기준
% WR_x(7) = 며칠전에 같은 패턴이 나와야 - 기준

for i_ADX = 2 : md

    if     rshm(i_ADX)-rshm(i_ADX-1) > 0 && rshm(i_ADX)-rshm(i_ADX-1) > rslm(i_ADX-1)-rslm(i_ADX)
        PDM(i_ADX) = rshm(i_ADX)-rshm(i_ADX-1);
    elseif rslm(i_ADX-1)-rslm(i_ADX) > 0 && rslm(i_ADX-1)-rslm(i_ADX) > rshm(i_ADX)-rshm(i_ADX-1)
        MDM(i_ADX) = rslm(i_ADX-1)-rslm(i_ADX);
    end
    
    TR(i_ADX) = abs(max([ rshm(i_ADX)-rslm(i_ADX) , rshm(i_ADX)-rscm(i_ADX-1) , rslm(i_ADX)-rscm(i_ADX-1) ]));
    
    PDI(i_ADX) = PDM(i_ADX)/TR(i_ADX);
    MDI(i_ADX) = MDM(i_ADX)/TR(i_ADX);

end

    PDI=tsmovavg(PDI, 's', round(WR_x(8)), 1);
    MDI=tsmovavg(MDI, 's', round(WR_x(8)), 1);
    
WPCTR = willpctr(rshm, rslm, rscm, round(WR_x(1)));

for i_WR = 1 + round( max([WR_x(1), WR_x(6), WR_x(7)]) ) : md
    
    DX(i_WR) = (abs(PDI(i_WR)-MDI(i_WR))) / (abs(PDI(i_WR)+MDI(i_WR))) * 100;
    ADX(i_WR) = sum(DX( i_WR - round(WR_x(9)) : i_WR )) / round(WR_x(9)); 
    
    if WPCTR(i_WR) <= WR_x(2)+WR_x(3) ... %&& WPCTR(i_WR-round(WR_x(6))) < WR_x(2) ... % && WPCTR(i_WR-2) < WR_x(2) && WPCTR(i_WR-3) < WR_x(2) && WPCTR(i_WR-4) < WR_x(2) && WPCTR(i_WR-5) < WR_x(2) ...
%             && ADX(i_WR) < ADX(i_WR-round(WR_x(10))) && ADX(i_WR) < ADX(i_WR-round(WR_x(11)))
        t2t_WR(i_WR) = -1; %             && rslm(i_WR-1)-rslm(i_WR) > 0 && rslm(i_WR-1)-rslm(i_WR) > rshm(i_WR)-rshm(i_WR-1) ...

    end
    
    if WPCTR(i_WR) >= WR_x(4)-WR_x(5) ... %&& WPCTR(i_WR-round(WR_x(7))) > WR_x(4)% ... % && WPCTR(i_WR-2) > WR_x(2) && WPCTR(i_WR-3) > WR_x(2) && WPCTR(i_WR-4) > WR_x(2) && WPCTR(i_WR-5) > WR_x(2) ...
%             && ADX(i_WR) < ADX(i_WR-round(WR_x(10))) && ADX(i_WR) < ADX(i_WR-round(WR_x(11)))
        t2t_WR(i_WR) = +1; %             && rshm(i_WR)-rshm(i_WR-1) > 0 && rshm(i_WR)-rshm(i_WR-1) > rslm(i_WR-1)-rslm(i_WR) ...

    end
    
end % WR

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_WR( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                  fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) ); 
               
            elseif sum( t2t_WR( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_WR(fit_j) == -1 % S(j)가 -1 이면
                        fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                
                elseif t2t_WR(fit_j) == 1 ... % S(j)가 1 이고
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                        fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end    
            end
        end
    
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_WR( (Tib+1):(Tin-1) )~=0 ) == 0
                  fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                  
            elseif sum( t2t_WR( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_WR(fit_j) == 1 
                        fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                        
                elseif t2t_WR(fit_j) == -1 ... 
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                        fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end    
            end
        end
    end
end

%     i_WR;
    WR_x;
    WR_fit = sum(fitness);
    
    
end
