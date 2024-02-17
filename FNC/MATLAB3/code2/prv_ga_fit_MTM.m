function [ MTM_fit ] = prv_ga_fit_MTM( MTM_x )
%UNTITLED4 Summary of this function goes here
%   Detailed exMTManation goes here

global  md rscm rsom rslm rshm Trend ...
    t2t_MTM M2M MTM mtm

fitness = zeros(md,1);

% MTM_x(1) = 기간
% MTM_x(2) =
% MTM_x(3) =
% MTM_x(4) =
% MTM_x(5) =

t2t_MTM = zeros(md,1);

MTM = zeros(md,1);
% M2M = zeros(md,1);


for i_MTM = (1 + round(MTM_x(1))) : md
    
    for i2_MTM = (1 + (i_MTM - round(MTM_x(1)))) : i_MTM
        mtm(i2_MTM,:) = abs(rscm(i2_MTM) - rscm(i2_MTM - 1));
    end
    
    MTM(i_MTM,:) = sum(mtm);
    clear mtm
    
    maxVal = max( MTM( i_MTM - round(MTM_x(1)) : i_MTM,: ) );
    minVal = min( MTM( i_MTM - round(MTM_x(1)) : i_MTM,: ) );
    if maxVal - minVal >= 0
        M2M(i_MTM,:) = ( (MTM(i_MTM,:) - minVal) / (maxVal - minVal) - 0.5 )*2;
    end
    
    if M2M(i_MTM) < MTM_x(2) && M2M(i_MTM) > MTM_x(2) - MTM_x(3); %(Trend(i_MTM) - Trend(i_MTM - 1)) > 0 ...
%             && rshm(i_MTM)-rshm(i_MTM-1) > 0 && rshm(i_MTM)-rshm(i_MTM-1) > rslm(i_MTM-1)-rslm(i_MTM)
        t2t_MTM(i_MTM) = +1;
    elseif M2M(i_MTM) > MTM_x(4) && M2M(i_MTM) < MTM_x(4) + MTM_x(5); %(Trend(i_MTM) - Trend(i_MTM - 1)) < 0 ...
%             && rslm(i_MTM-1)-rslm(i_MTM) > 0 && rslm(i_MTM-1)-rslm(i_MTM) > rshm(i_MTM)-rshm(i_MTM-1)
        t2t_MTM(i_MTM) = -1;
    end
    
end % MTM

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_MTM( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = ( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_MTM( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_MTM(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_MTM(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_MTM( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = ( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_MTM( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_MTM(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_MTM(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

%     i_MTM
MTM_x;
MTM_fit = sum(fitness);

end
