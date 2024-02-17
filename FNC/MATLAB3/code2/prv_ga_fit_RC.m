function [ RC_fit ] = prv_ga_fit_RC( RC_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm Trend ...
    t2t_RC sROC lROC

fitness = zeros(md,1);

% RC_x(1) = RC_lt
% RC_x(2) = RC_st
% RC_x(3) = RC_nh  110; % upper bound : new high
% RC_x(4) = RC_nl   90; % lower border : new low
% RC_x(5) = RC_equb  10;
% RC_x(6) = RC_eqlb  10;

eql = 100;

t2t_RC = zeros(md,1);

% lROC = zeros(md,1);
% sROC = zeros(md,1);

lROC = prcroc(rscm, round(RC_x(1))) + 100;
sROC = prcroc(rscm, round(RC_x(2))) + 100;

for i_RC = 1 + round(RC_x(1)) : md
    
    %     lROC(i_RC) = ( double(rscm(i_RC)) ./ double(rscm(i_RC-round(RC_x(1)))) )*100;
    %     sROC(i_RC) = ( double(rscm(i_RC)) ./ double(rscm(i_RC-round(RC_x(2)))) )*100;
    
    % lROC reaches new high && sROC locates near the equilibrium line
    % tiem2sell
    if lROC(i_RC) >= RC_x(3) && sROC(i_RC) >= (eql - RC_x(6)) && sROC(i_RC) <= (eql + RC_x(5))
        t2t_RC(i_RC) = +1;
    end
    
    % lROC reaches new low && sROC is near the equil. line
    % time2buy
    if lROC(i_RC) <= RC_x(4) && sROC(i_RC) >= (eql - RC_x(6)) && sROC(i_RC) <= (eql + RC_x(5))
        t2t_RC(i_RC) = -1;
    end
    
end % RC

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_RC( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_RC( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_RC(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_RC(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_RC( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_RC( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_RC(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_RC(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

i_RC;
RC_x;
RC_fit = sum(fitness);

sROC;
lROC;

end
