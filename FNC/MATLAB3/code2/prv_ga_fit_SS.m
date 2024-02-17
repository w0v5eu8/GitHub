function [ SS_fit ] = prv_ga_fit_SS( SS_x )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm Trend ...
    t2t_SS pKD pK pD

fitness = zeros(md,1);

% SS_x(1) = aa = pK
% SS_x(2) = bb = pK-pD
% SS_x(3) = cc = pK
% SS_x(4) = dd = pD-pK

t2t_SS = zeros(md,1);

[FpK FpD]=fpctkd([rshm, rslm, rscm], round(SS_x(5)), round(SS_x(6)));
[pK pD]=spctkd([FpK FpD], round(SS_x(7)), 'e');


for i_SS = 1:md
    
    % C(i_SS) = rscm(i_SS);
    % LL(i_SS) = min(rslm(i_SS-2:i_SS)); % lowest low price in a specified period
    % HH(i_SS) = max(rshm(i_SS-2:i_SS)); % highest high price in a specified period
    %
    % h3 = [C(i_SS-2)-LL(i_SS-2) C(i_SS-1)-LL(i_SS-1) C(i_SS)-LL(i_SS)];
    % l3 = [HH(i_SS-2)-LL(i_SS-2) HH(i_SS-1)-LL(i_SS-1) HH(i_SS)-LL(i_SS)];
    %
    % H3(i_SS) = sum( h3 ); % sum of three (C - LL)
    % L3(i_SS) = sum( l3 ); % sum of three (HH - LL)
    %
    % H3_ = sum([ H3(i_SS-2) H3(i_SS-1) H3(i_SS) ]); % sum of three H3
    % L3_ = sum([ L3(i_SS-2) L3(i_SS-1) L3(i_SS) ]); % sum of three L3
    %
    % pK(i_SS) = 100 * (H3 / L3);
    % pD(i_SS) = 100 * (H3_ / L3_);
    
    
    % pK rise above pD
    % and satisfies pK < aa && pK - pD < bb
    % time2buy
    
    if pK(i_SS) >= pD(i_SS) && ...
            pK(i_SS) < SS_x(1) %&& ...
%             rslm(i_SS-1)-rslm(i_SS) > 0 && rslm(i_SS-1)-rslm(i_SS) > rshm(i_SS)-rshm(i_SS-1)
        %              || abs(pK(i_SS) - pD(i_SS)) < SS_x(2)
        t2t_SS(i_SS) = -1;
    end
    
    % pK falls below pD
    % and satisfies pK < cc && pD - pK < dd
    % time2sell
    
    if pK(i_SS) <= pD(i_SS) && ...
            pK(i_SS) > SS_x(3) %&& ...
%             rshm(i_SS)-rshm(i_SS-1) > 0 && rshm(i_SS)-rshm(i_SS-1) > rslm(i_SS-1)-rslm(i_SS)
        %             || abs(pD(i_SS) - pK(i_SS)) < SS_x(4)
        t2t_SS(i_SS) = +1;
    end
    
    
end
%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_SS( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = ( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_SS( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_SS(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_SS(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_SS( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = ( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_SS( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_SS(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_SS(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

i_SS;
SS_x;
SS_fit = sum(fitness);

pKD = [mean(pK(5:md)) mean(pD(5:md)) mean(pK(5:md)-pD(5:md)) mean(pD(5:md)-pK(5:md)) sum(pK>pD)];

end
