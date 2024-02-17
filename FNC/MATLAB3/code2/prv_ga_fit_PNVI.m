function [ PNVI_fit ] = prv_ga_fit_PNVI( PNVI_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
    t2t_PNVI  pvi nvi pvi_ma nvi_ma

fitness = zeros(md,1);

t2t_PNVI = zeros(md,1);

% PNVI_x(1) = PNVI_lt
% PNVI_x(2) = PNVI_st
% PNVI_x(3) = PNVI_nh  110; % upper bound : new high
% PNVI_x(4) = PNVI_nl   90; % lower border : new low

pvi = posvolidx([rscm rsvm], 100);
nvi = negvolidx([rscm rsvm], 100);
pvi_ma = tsmovavg(pvi', 's', round(PNVI_x(1)));
nvi_ma = tsmovavg(nvi', 's', round(PNVI_x(2)));

vlROC = volroc(rscm, round(PNVI_x(3))) + 100;
vsROC = volroc(rscm, round(PNVI_x(4))) + 100;

eql = 100;

for i_PNVI = 1 + max(round(PNVI_x(1)), round(PNVI_x(2))) : md
    
    if (nvi(i_PNVI) >= nvi_ma(i_PNVI) && ( nvi(i_PNVI-1) < nvi_ma(i_PNVI-1) || nvi(i_PNVI-2) < nvi_ma(i_PNVI-2) )) ...
            || (pvi(i_PNVI) <= pvi_ma(i_PNVI) && ( pvi(i_PNVI-1) > pvi_ma(i_PNVI-1) || pvi(i_PNVI-2) > pvi_ma(i_PNVI-2) )) ...
            || vlROC(i_PNVI) <= PNVI_x(8) && vsROC(i_PNVI) >= (eql - PNVI_x(9)) && vsROC(i_PNVI) <= (eql + PNVI_x(10))        
        t2t_PNVI(i_PNVI) = -1;
    end
    
    if (pvi(i_PNVI) >= pvi_ma(i_PNVI) && ( pvi(i_PNVI-1) < pvi_ma(i_PNVI-1) || pvi(i_PNVI-2) < pvi_ma(i_PNVI-2) )) ...
            || (nvi(i_PNVI) <= nvi_ma(i_PNVI) && ( nvi(i_PNVI-1) > nvi_ma(i_PNVI-1) || nvi(i_PNVI-2) > nvi_ma(i_PNVI-2) )) ...
            || vlROC(i_PNVI) >= PNVI_x(5) && vsROC(i_PNVI) >= (eql - PNVI_x(6)) && vsROC(i_PNVI) <= (eql + PNVI_x(7))            
        t2t_PNVI(i_PNVI) = +1;
    end
    
end % PNVI

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_PNVI( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_PNVI( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_PNVI(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_PNVI(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_PNVI( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_PNVI( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_PNVI(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_PNVI(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

% i_PNVI;
PNVI_x;
PNVI_fit = sum(fitness);


end
