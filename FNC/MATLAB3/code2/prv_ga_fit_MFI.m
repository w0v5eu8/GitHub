function [ MFI_fit ] = prv_ga_fit_MFI( MFI_x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global  md rscm rsom rslm rshm rsvm Trend ...
    t2t_MFI tprc monf monra MFI

fitness = zeros(md,1);

t2t_MFI = zeros(md,1);
pmonf = zeros(md,1);
nmonf = zeros(md,1);
monra = zeros(md,1);

% MFI_x(1) = period
% MFI_x(2) = sell threshold
% MFI_x(3) = buy threshold

PDM = zeros(md,1);
MDM = zeros(md,1);
TR = zeros(md,1);
PDI = zeros(md,1);
MDI = zeros(md,1);
DX = zeros(md,1);
ADX = zeros(md,1);

tprc = typprice([rshm rslm rscm]);
monf = tprc.*rsvm;

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

    PDI=tsmovavg(PDI, 's', round(MFI_x(4)), 1);
    MDI=tsmovavg(MDI, 's', round(MFI_x(4)), 1);
    

for i_MFI = 23 : md
    
    if tprc(i_MFI) > tprc(i_MFI-1)
        pmonf(i_MFI) = monf(i_MFI);
    elseif tprc(i_MFI) < tprc(i_MFI-1)
        nmonf(i_MFI) = monf(i_MFI);
    end

    DX(i_MFI) = (abs(PDI(i_MFI)-MDI(i_MFI))) / (abs(PDI(i_MFI)+MDI(i_MFI))) * 100;
    ADX(i_MFI) = sum(DX( i_MFI - round(MFI_x(5)) : i_MFI )) / round(MFI_x(5)); 
  
    
    monra(i_MFI) = sum(pmonf(i_MFI - round(MFI_x(1)):i_MFI)) / sum(nmonf(i_MFI - round(MFI_x(1)):i_MFI));
    
    MFI(i_MFI) = 100 - (100/(1+monra(i_MFI)));
    
    if MFI(i_MFI) > MFI_x(2) && ADX(i_MFI) < ADX(i_MFI-round(MFI_x(6))) && ADX(i_MFI) < ADX(i_MFI-round(MFI_x(7)))
%         && rshm(i_MFI)-rshm(i_MFI-1) > 0 && rshm(i_MFI)-rshm(i_MFI-1) > rslm(i_MFI-1)-rslm(i_MFI) ...
                    
        t2t_MFI(i_MFI) = +1;
    end
    
    
    if MFI(i_MFI) < MFI_x(3) && ADX(i_MFI) < ADX(i_MFI-round(MFI_x(8))) && ADX(i_MFI) < ADX(i_MFI-round(MFI_x(9)))
%         && rslm(i_MFI-1)-rslm(i_MFI) > 0 && rslm(i_MFI-1)-rslm(i_MFI) > rshm(i_MFI)-rshm(i_MFI-1) ...
                    
        t2t_MFI(i_MFI) = -1;
    end
    
end % MFI

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_MFI( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = 1.5*( max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i) );
                
            elseif sum( t2t_MFI( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_MFI(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_MFI(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 2 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_MFI( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = 1.5*( rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) ) );
                
            elseif sum( t2t_MFI( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_MFI(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_MFI(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 2 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

% i_MFI;
MFI_x;
MFI_fit = sum(fitness);



end
