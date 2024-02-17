function [ DMI_fit ] = prv_ga_fit_DMI( DMI_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
         t2t_DMI ADX PDI MDI DX TR PDM MDM
         
fitness = zeros(md,1);

t2t_DMI = zeros(md,1);
PDM = zeros(md,1);
MDM = zeros(md,1);
TR = zeros(md,1);
PDI = zeros(md,1);
MDI = zeros(md,1);
DX = zeros(md,1);
ADX = zeros(md,1);


% DMI_x(1) = DMI_lt
% DMI_x(2) = DMI_st
% DMI_x(3) = DMI_nh  110; % upper bound : new high
% DMI_x(4) = DMI_nl   90; % lower border : new low
% DMI_x(5) = DMI_equb  10;
% DMI_x(6) = DMI_eqlb  10;

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

    PDI=tsmovavg(PDI, 's', round(DMI_x(2)), 1);
    MDI=tsmovavg(MDI, 's', round(DMI_x(2)), 1);

for i_DMI = 1 + round(max([DMI_x(1), DMI_x(3), DMI_x(4), DMI_x(5)])) : md
    
    DX(i_DMI) = (abs(PDI(i_DMI)-MDI(i_DMI))) / (abs(PDI(i_DMI)+MDI(i_DMI))) * 100;
    ADX(i_DMI) = sum(DX( i_DMI - round(DMI_x(1)) : i_DMI )) / round(DMI_x(1)); 
    
    if PDI(i_DMI) > MDI(i_DMI) && rscm(i_DMI) >= rshm(i_DMI-1) && ADX(i_DMI) < ADX(i_DMI-round(DMI_x(3))) && ADX(i_DMI) < ADX(i_DMI-round(DMI_x(4))) % && ADX(i_DMI) < ADX(i_DMI-round(DMI_x(5)))
        t2t_DMI(i_DMI) = +1;
    end
    
    if PDI(i_DMI) < MDI(i_DMI) && rscm(i_DMI) <= rslm(i_DMI-1) && ADX(i_DMI) < ADX(i_DMI-round(DMI_x(6))) && ADX(i_DMI) < ADX(i_DMI-round(DMI_x(7))) % && ADX(i_DMI) < ADX(i_DMI-round(DMI_x(8)))
        t2t_DMI(i_DMI) = -1;
    end
    
end % DMI

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_DMI( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                  fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) ); 
               
            elseif sum( t2t_DMI( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_DMI(fit_j) == -1 % S(j)가 -1 이면
                        fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                
                elseif t2t_DMI(fit_j) == 1 ... % S(j)가 1 이고
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                        fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end    
            end
        end
    
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_DMI( (Tib+1):(Tin-1) )~=0 ) == 0
                  fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                  
            elseif sum( t2t_DMI( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_DMI(fit_j) == 1 
                        fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                        
                elseif t2t_DMI(fit_j) == -1 ... 
                            && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                        fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end    
            end
        end
    end
end

%     i_DMI;
    DMI_x;
    DMI_fit = sum(fitness);
    
    
end
