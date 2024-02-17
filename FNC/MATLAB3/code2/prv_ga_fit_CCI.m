function [ CCI_fit ] = prv_ga_fit_CCI( CCI_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
    t2t_CCI cciM ccim ccid CCI

fitness = zeros(md,1);

% CCI_x(1) = m 값을 위해 며칠을 MA 단위로 잡느냐
% CCI_x(2) = d 값을 위해 며칠을 MA 단위로 잡느냐
% CCI_x(3) = CCI 값이 -100:+100 을 크게 벗어나지 않게 하기 위한 상수 e.g. 0.015
% CCI_x(4) = 상한 : 상향 돌파하면 매수 시작, 하향 돌파하면 청산
% CCI_x(5) = 하한 : 하향 돌파하면 매도 시작, 상향 돌파하면 청산

t2t_CCI = zeros(md,1);
CCI = zeros(md,1);

PDM = zeros(md,1);
MDM = zeros(md,1);
TR = zeros(md,1);
PDI = zeros(md,1);
MDI = zeros(md,1);
DX = zeros(md,1);
ADX = zeros(md,1);

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

    PDI=tsmovavg(PDI, 's', round(CCI_x(6)), 1);
    MDI=tsmovavg(MDI, 's', round(CCI_x(6)), 1);

cciM = (rscm + rshm + rslm)/3;
ccim = tsmovavg(cciM, 's', round(CCI_x(1)), 1);
ccid = tsmovavg(abs(cciM-ccim), 's', round(CCI_x(2)), 1);

for i_CCI = 20 + round(CCI_x(1)) : md
    
    DX(i_CCI) = (abs(PDI(i_CCI)-MDI(i_CCI))) / (abs(PDI(i_CCI)+MDI(i_CCI))) * 100;
    ADX(i_CCI) = sum(DX( i_CCI - round(CCI_x(7)) : i_CCI )) / round(CCI_x(7)); 
    
    CCI(i_CCI) = (cciM(i_CCI) - ccim(i_CCI)) / ( ccid(i_CCI) * CCI_x(3) );
    
    if CCI(i_CCI) >= CCI_x(4) ... % && CCI(i_CCI-1) < CCI_x(4)                     && rshm(i_CCI)-rshm(i_CCI-1) > 0 && rshm(i_CCI)-rshm(i_CCI-1) > rslm(i_CCI-1)-rslm(i_CCI) ...
%                     && ADX(i_CCI) < ADX(i_CCI-round(CCI_x(10))) && ADX(i_CCI) < ADX(i_CCI-round(CCI_x(11)))
        t2t_CCI(i_CCI) = +1; % 이게 +1 인게 맞나?
    elseif CCI(i_CCI) <= CCI_x(5) ... % && CCI(i_CCI-1) > CCI_x(5)                    && rslm(i_CCI-1)-rslm(i_CCI) > 0 && rslm(i_CCI-1)-rslm(i_CCI) > rshm(i_CCI)-rshm(i_CCI-1) ...
%                     && ADX(i_CCI) < ADX(i_CCI-round(CCI_x(8))) && ADX(i_CCI) < ADX(i_CCI-round(CCI_x(9)))
        t2t_CCI(i_CCI) = -1;
    end
    
end % CCI

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CCI( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_CCI( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_CCI(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_CCI(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CCI( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_CCI( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_CCI(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_CCI(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

% i_CCI
CCI_x;
CCI_fit = sum(fitness);


end
