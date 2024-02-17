function [ RSI_fit ] = prv_ga_fit_RSI( RSI_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm Trend ...
    t2t_RSI RSI RS cp_op

fitness = zeros(md,1);

t2t_RSI = zeros(md,1);

RS = zeros(md,1);

% RSI_x(1) = average of 'x' days up(down) closes x일 동안의 상승(하락)폭의 평균
% RSI_x(2) = over bought 80
% RSI_x(3) = over sold 20
% RSI_x(4) = slope 2
% RSI_x(5) = slope -2

cp_op = rscm - rsom;

% upcl = double(cp_op>0).* raw_stock_cp_m;
% dwcl = double(cp_op<0).* raw_stock_cp_m;

% for i_RSI = round(RSI_x(1)) : md
%
%     RS(i_RSI) = ...
%         (sum( upcl( (i_RSI - round(RSI_x(1) - 1)):i_RSI ) ) / round(RSI_x(1))) ...
%         / (sum( dwcl( (i_RSI - round(RSI_x(1) - 1)):i_RSI ) )  / round(RSI_x(1)));
%     RSI(i_RSI) = 100 - (100/(1+RS(i_RSI)));
%     % 0 < RSI < 100
%
% end

RSI = rsindex(rscm, round(RSI_x(1)));

for i_RSI = round(RSI_x(1)) : md
    i3_RSI = 5;
    if i_RSI > i3_RSI+1
        if RSI(i_RSI) >= RSI_x(2) %
            for i2_RSI = 1:i3_RSI
                rsc1(i2_RSI) = RSI(i_RSI-i2_RSI) < (RSI_x(4))*RSI(i_RSI-i2_RSI-1); ...
%                     && RSI(i_RSI-i2_RSI) > RSI(i_RSI-i2_RSI-1);
                %                     rsc1 = RSI(i_RSI+i2_RSI) < RSI(i_RSI+i2_RSI-1);
            end
            if sum(rsc1) ~= 0
                t2t_RSI(i_RSI) = +1;
                %                         - find(rsc1, 1, 'first')) = +1;
            end
        elseif RSI(i_RSI) <= RSI_x(3) %
            for i2_RSI = 1:i3_RSI
                rsc2(i2_RSI) = RSI(i_RSI-i2_RSI) > (RSI_x(5))*RSI(i_RSI-i2_RSI-1); ...
%                     && RSI(i_RSI-i2_RSI) < RSI(i_RSI-i2_RSI-1);
                %                     rsc2 = RSI(i_RSI+i2_RSI) > RSI(i_RSI+i2_RSI-1);
            end
            if sum(rsc2) ~= 0
                t2t_RSI(i_RSI) = -1;
                %                         - find(rsc2, 1, 'first')) = -1;
            end
        end
    end
    
end % RSI

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_RSI( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_RSI( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_RSI(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_RSI(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_RSI( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_RSI( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_RSI(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_RSI(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

% i_RSI;
RSI_x;
RSI_fit = sum(fitness);

end
