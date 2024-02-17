function [ CC1_fit ] = prv_ga_fit_CC1( CC1_x )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

 global  md rscm rsom rslm rshm Trend ...
         t2t_CC1 wicks tails bodies
         
fitness = zeros(md,1);

t2t_CC1 = zeros(md,1);

wicks = zeros(md,1);
tails = zeros(md,1);
bodies = zeros(md,1);

% CC1_x(1) = Candle_a

    [PLM1, PLM2] = macd(rscm);
    MCDO_p = PLM1 - PLM2;
    MCDO = (MCDO_p*20) + rscm;
%     plot(PLM1); hold on; plot(PLM2, 'r'); plot(rscm/13, 'k');
%     plot(rscm, 'k'); hold on; plot(MCDO, 'r'); hold off;
    MCDOE = (MCDO - rscm)./1000; 
    MCDOA=tsmovavg(MCDOE, 's', round(CC1_x(3)), 1);
%     plot(MCDOE, 'k'); hold on; plot(MCDOA, 'r'); plot(zeros(md,1), 'k')

for i_CC1 = 20 : md
    if rscm(i_CC1) > rsom(i_CC1) % 양봉
        wicks(i_CC1) = rshm(i_CC1) - rscm(i_CC1);
        tails(i_CC1) = abs(rslm(i_CC1) - rsom(i_CC1));
        bodies(i_CC1) = rscm(i_CC1) - rsom(i_CC1);
    elseif rscm(i_CC1) < rsom(i_CC1) % 음봉
        wicks(i_CC1) = rshm(i_CC1) - rsom(i_CC1);
        tails(i_CC1) = abs(rslm(i_CC1) - rscm(i_CC1));
        bodies(i_CC1) = rsom(i_CC1) - rscm(i_CC1);
    end
    
    
    if  MCDO(i_CC1) > rscm(i_CC1) 
        if MCDOE(i_CC1) > MCDOA(i_CC1)
            if MCDOA(i_CC1) <= CC1_x(4)
                t2t_CC1(i_CC1) = +1;
            elseif MCDOA(i_CC1) >= CC1_x(5)
                t2t_CC1(i_CC1) = -1;
            end
        elseif MCDOE(i_CC1) < MCDOA(i_CC1)
            if MCDOA(i_CC1) <= CC1_x(4)
                t2t_CC1(i_CC1) = -1;
            elseif MCDOA(i_CC1) >= CC1_x(5)
                t2t_CC1(i_CC1) = +1;
            end
        end
    elseif MCDO(i_CC1) < rscm(i_CC1) 
        if MCDOE(i_CC1) < MCDOA(i_CC1)
            if MCDOA(i_CC1) <= CC1_x(4)
                t2t_CC1(i_CC1) = -1;
            elseif MCDOA(i_CC1) >= CC1_x(5)
                t2t_CC1(i_CC1) = +1;
            end
        elseif MCDOE(i_CC1) > MCDOA(i_CC1)
            if MCDOA(i_CC1) <= CC1_x(4)
                t2t_CC1(i_CC1) = +1;
            elseif MCDOA(i_CC1) >= CC1_x(5)
                t2t_CC1(i_CC1) = -1;
            end
        end
    end
    
    % Hammer and Haning man
    % (the length of wicks or tails / the length of body) > candle_a
    % --> price reversal    
     %         || (wicks(i_CC1) / bodies(i_CC1)) > CC1_x(1)
     %         || (tails(i_CC1) / bodies(i_CC1)) > CC1_x(2)

    
    
end % CC1




%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CC1( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                  fitness(fit_i) = max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i); 
               
            elseif sum( t2t_CC1( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_CC1(fit_j) == -1 % S(j)가 -1 이면
                        fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                
                elseif t2t_CC1(fit_j) == 1 ... % S(j)가 1 이고
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                        fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end    
            end
        end
    
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_CC1( (Tib+1):(Tin-1) )~=0 ) == 0
                  fitness(fit_i) = rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) ;
                  
            elseif sum( t2t_CC1( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_CC1(fit_j) == 1 
                        fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                        
                elseif t2t_CC1(fit_j) == -1 ... 
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                        fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end    
            end
        end
    end
end

    i_CC1;
    CC1_x;
    CC1_fit = sum(fitness);

end
