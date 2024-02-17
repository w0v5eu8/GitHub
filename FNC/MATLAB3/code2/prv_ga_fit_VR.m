function [ VR_fit ] = prv_ga_fit_VR( VR_x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
    t2t_VR VR v_rise v_fall VRCO

fitness = zeros(md,1);

t2t_VR = zeros(md,1);

v_rise = zeros(md,1);
v_fall = zeros(md,1);
VR = zeros(md,1);

% VR_x(1) = 기간
% VR_x(2) = 2 와 3 사이면 BUY
% VR_x(3) = 2 와 3 사이면 BUY
% VR_x(4) = 4 이하면 SELL
% VR_x(5) = 5 이상이면 SELL



VRCO_p = chaikosc(rshm, rslm, rscm, rsvm); 
VRCO = (VRCO_p*5 + rscm);

for i_VR = 1+round(VR_x(1)) : md
    
    if rscm(i_VR) > rsom(i_VR) %양봉
        v_rise(i_VR) = rsvm(i_VR);
    elseif rscm(i_VR) < rsom(i_VR) %음봉
        v_fall(i_VR) = rsvm(i_VR);
    end
    

    VR(i_VR) = 100 * ( sum(v_rise(i_VR - round(VR_x(1)) : i_VR - 1)) ...
                        / sum(v_fall(i_VR - round(VR_x(1)) : i_VR - 1)) );
    
    if VRCO(i_VR) > rscm(i_VR) && abs(VRCO_p(i_VR)) > abs(VRCO_p(i_VR-1)) && abs(VRCO_p(i_VR-1)) > abs(VRCO_p(i_VR-2)) && abs(VRCO_p(i_VR-2)) > abs(VRCO_p(i_VR-3))     % VR(i_VR) > VR_x(2) && VR(i_VR) < VR_x(3) ...
%             && rslm(i_VR-1)-rslm(i_VR) > 0 && rslm(i_VR-1)-rslm(i_VR) > rshm(i_VR)-rshm(i_VR-1)
        t2t_VR(i_VR) = +1;
        
    elseif VRCO(i_VR) < rscm(i_VR) && abs(VRCO_p(i_VR)) > abs(VRCO_p(i_VR-1)) && abs(VRCO_p(i_VR-1)) > abs(VRCO_p(i_VR-2)) && abs(VRCO_p(i_VR-2)) > abs(VRCO_p(i_VR-3)) % VR(i_VR) < VR_x(4) ...
%             && rshm(i_VR)-rshm(i_VR-1) > 0 && rshm(i_VR)-rshm(i_VR-1) > rslm(i_VR-1)-rslm(i_VR)
        t2t_VR(i_VR) = -1;
    end    
    if VR(i_VR) > VR_x(5) ...
%             && rshm(i_VR)-rshm(i_VR-1) > 0 && rshm(i_VR)-rshm(i_VR-1) > rslm(i_VR-1)-rslm(i_VR)
        t2t_VR(i_VR) = +1;
    
    end
    
end % VR

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_VR( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = ( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_VR( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_VR(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_VR(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_VR( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = ( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_VR( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_VR(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_VR(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

%     i_VR
VR_x;
VR_fit = sum(fitness);

end
