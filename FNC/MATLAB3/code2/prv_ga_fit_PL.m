function [ PL_fit ] = prv_ga_fit_PL( PL_x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
    t2t_PL PL mPL ADX PLMA PLMAh

fitness = zeros(md,1);

t2t_PL = zeros(md,1);

v_rise = zeros(md,1);
v_fall = zeros(md,1);

PL = zeros(md,1);

PDM = zeros(md,1);
MDM = zeros(md,1);
TR = zeros(md,1);
PDI = zeros(md,1);
MDI = zeros(md,1);
DX = zeros(md,1);
ADX = zeros(md,1);

% PL_x(1) = 기간
% PL_x(2) = 보다 크면 판다
% PL_x(3) = 보다 작으면 산다

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

    PDI=tsmovavg(PDI, 's', round(PL_x(4)), 1);
    MDI=tsmovavg(MDI, 's', round(PL_x(4)), 1);
        
for i_PL = 1+ round(PL_x(1)) : md
    
    if rscm(i_PL) > rsom(i_PL) %양봉
        v_rise(i_PL) = 1;
    elseif rscm(i_PL) < rsom(i_PL) %음봉
        v_fall(i_PL) = 1;
    end
    
    PL(i_PL) = 100 * (sum(v_rise(i_PL - round(PL_x(1)) : i_PL-1)) / round(PL_x(1)));
end

    mPL=mean(PL);

    PLMA=tsmovavg(rscm, 's', round(PL_x(10)), 1);
    PLMAh=tsmovavg(rshm, 's', round(PL_x(10)), 1);
    
for i_PL = 1 + round(max([PL_x(1), PL_x(5), PL_x(7), PL_x(6), PL_x(8), PL_x(9)])) : md
    
    DX(i_PL) = (abs(PDI(i_PL)-MDI(i_PL))) / (abs(PDI(i_PL)+MDI(i_PL))) * 100;
    ADX(i_PL) = sum(DX( i_PL - round(PL_x(5)) : i_PL )) / round(PL_x(5)); 

%     if     ( PLM1(i_PL) < PLM2(i_PL)) && PL(i_PL) < mPL - PL_x(3) 
%                      
%         t2t_PL(i_PL) = -1;
%     elseif ( PLM1(i_PL) > PLM2(i_PL)) && PL(i_PL) > mPL + PL_x(2) 
%                     
%         t2t_PL(i_PL) = +1;
%     end

    if     PL(i_PL) < mPL - PL_x(3) 
                     
        t2t_PL(i_PL) = -1;
    elseif PL(i_PL) > mPL + PL_x(2) 
                    
        t2t_PL(i_PL) = +1;
    end

%         if     (rscm(i_PL) < PLMA(i_PL) || PL(i_PL) < mPL - PL_x(3)) ... 
%                     && (ADX(i_PL) > ADX(i_PL-round(PL_x(6))) && ADX(i_PL) > ADX(i_PL-round(PL_x(7))))                      
%         t2t_PL(i_PL) = -1;
%         elseif (rscm(i_PL) > PLMA(i_PL) || PL(i_PL) > mPL + PL_x(2))... 
%                     && (ADX(i_PL) > ADX(i_PL-round(PL_x(8))) && ADX(i_PL) > ADX(i_PL-round(PL_x(9))))                    
%         t2t_PL(i_PL) = +1;
%         end
%         
%         if abs(PLMA(i_PL) - PLMAh(i_PL)) < PL_x(11)
%         t2t_PL(i_PL) = 0;
%         end
        
end % PL

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_PL( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_PL( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_PL(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_PL(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 3 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_PL( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_PL( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_PL(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_PL(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 3 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

%     i_PL
PL_x;
PL_fit = sum(fitness);

end
