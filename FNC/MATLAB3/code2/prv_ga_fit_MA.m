function [ MA_fit ] = prv_ga_fit_MA( MA_x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Moving Average system

global  md rscm rsom rslm rshm Trend ...
    t2t_MA Dipa

fitness = zeros(md,1);

t2t_MA = zeros(md,1);

Dipa = zeros(md,1);

% MA_lt = MA_x(1); % long-term
% MA_st = MA_x(2); % short-term
% MA_a = MA_x(3);
% MA_b = MA_x(4);
% MA_c = MA_x(5);
% MA_a2 = MA_x(6);
% MA_b2 = MA_x(7);
% MA_c2 = MA_x(8);

% NN = MA_x(9) = 5; % time-span of MA
% p1 = MA_x(10) = 1; % upper band-width
% p2 = MA_x(11) = 1; % lower band-width


% Z = zeros(md,1);
% find_t1 = zeros(md,1);
% find_k1 = zeros(md,1);
% MZ = zeros(md,1);
% Mw = zeros(md,1);

    
    %     % Z(t) = MA(N) - MA(n) % long-term MA - short-term MA
    %     Z(i_MA) = (sum(raw_stock_cp_m(i_MA-round(MA_x(1)):i_MA))/round(MA_x(1))) - (sum(raw_stock_cp_m(i_MA-round(MA_x(2)):i_MA))/round(MA_x(2)));
    
    
    %     if Z(i_MA) >= 0
    %
    % %         for i2_MA = 2:i_MA
    % %             %         find_t1(j) = (Z(j-1) <= 0).*(Z(j) > 0);
    % %             find_t1(i2_MA) = (Z(i2_MA-1) <= 0).*(Z(i2_MA) > 0);
    % %         end
    % %
    % %         %        t1 = max(find(find_t1==1))
    % %         t1 = find(find_t1==1, 1, 'last');
    % %
    % %         MZ(i_MA) = max( Z(t1:i_MA) );
    % %
    % % %         for i3_MA = t1+1:i_MA
    % % %             find_MZ(i3_MA) = Z(i3_MA);
    % % %             MZ(i_MA) = max(find_MZ(i3_MA));
    % % %         end
    % %
    % %
    % %         if MZ(i_MA) > MA_x(4) * MA_x(5)
    % %             if Z(i_MA) < min( MZ(i_MA)/MA_x(3) , MA_x(5) )
    % %                 t2t_MA(i_MA)=-1;
    % %             end
    % %         end
    % %         % Golden Cross : time2buy
    % %         % if Z(t) >= 0 % 장기이동평균선이 단기를 뚫고 올라감
    % %         % find t1
    % %         % which is closest to t (t1 < t) % t보다 작으면서 가장 t에 가까운 t1을 구함
    % %         % satisfies Z(t1 - 1) <= 0 % t1보다 한 시기 전에는 장기이평선이 단기 아래였음
    % %         % satisfies Z(t1) > 0 % t1 시기에는 장기이평선이 뚫고 올라왔음
    % %
    % %         % MZ(t) = max(Z(t1), Z(t1 + 1), ~ , Z(t)) % t1 시기부터 t 시기까지의 Z값 중 가장 큰 값
    % %
    % %         % MZ(t) > b * c
    % %         % Z(t) < min( MZ(t)/a , c )
    %
    %     elseif Z(i_MA) < 0
    %
    % %         for i4_MA = 2:i_MA
    % %             find_k1(i4_MA) = (Z(i4_MA-1) >= 0).*(Z(i4_MA) < 0);
    % %         end
    % %
    % %         k1 = find(find_k1==1, 1, 'last');
    % %
    % %         Mw(i_MA) = max( -Z(k1:i_MA) );
    % %
    % % %         for i5_MA = k1+1:i_MA
    % % %             find_Mw(i5_MA) = -Z(i5_MA);
    % % %             Mw(i_MA) = max(find_Mw(i5_MA));
    % % %         end
    % %
    % %
    % %         if Mw(i_MA) > MA_x(7) * MA_x(8)
    % %             if -Z(i_MA) < min( Mw(i_MA)/MA_x(6) , MA_x(8) )
    % %                 t2t_MA(i_MA)=1;
    % %             end
    % %         end
    % %         % Dead Cross : time2sell
    % %         % if Z(t) < 0
    % %         % find k1
    % %         % which is closest to k (k1 < k)
    % %         % satisfies Z(k1 - 1) >= 0 % k1보다 한 시기 전에는 장기이평선이 단기 위였음
    % %         % satisfies Z(k1) < 0 % k1 시기에는 장기이평선이 뚫고 내려갔음
    % %
    % %         % w(k) = - z(k) % (k = k(1), ~ , k)
    % %         % Mw(k) = max(w(k1), w(k1+1), ~ , w(k))
    % %
    % %         % Mw(k) > b_ * c_
    % %         % w(k) < min( Mw(k)/a_ , c_)
    %     end
%%

PDM = zeros(md,1);
MDM = zeros(md,1);
TR = zeros(md,1);
PDI = zeros(md,1);
MDI = zeros(md,1);
DX = zeros(md,1);
ADX = zeros(md,1);

for i_ADX = 20 : md

    if     rshm(i_ADX)-rshm(i_ADX-1) > 0 && rshm(i_ADX)-rshm(i_ADX-1) > rslm(i_ADX-1)-rslm(i_ADX)
        PDM(i_ADX) = rshm(i_ADX)-rshm(i_ADX-1);
    elseif rslm(i_ADX-1)-rslm(i_ADX) > 0 && rslm(i_ADX-1)-rslm(i_ADX) > rshm(i_ADX)-rshm(i_ADX-1)
        MDM(i_ADX) = rslm(i_ADX-1)-rslm(i_ADX);
    end
    
    TR(i_ADX) = abs(max([ rshm(i_ADX)-rslm(i_ADX) , rshm(i_ADX)-rscm(i_ADX-1) , rslm(i_ADX)-rscm(i_ADX-1) ]));
    
    PDI(i_ADX) = PDM(i_ADX)/TR(i_ADX);
    MDI(i_ADX) = MDM(i_ADX)/TR(i_ADX);

end

    PDI=tsmovavg(PDI, 's', round(MA_x(4)), 1);
    MDI=tsmovavg(MDI, 's', round(MA_x(4)), 1);

for i_MA = 32 : md


    
    %% Disparity

 
    Dipa(i_MA) = (rscm(i_MA)/(sum(rscm(i_MA-round(MA_x(1)):i_MA-1))/round(MA_x(1))))*100;

    DX(i_MA) = (abs(PDI(i_MA)-MDI(i_MA))) / (abs(PDI(i_MA)+MDI(i_MA))) * 100;
    ADX(i_MA) = sum(DX( i_MA - round(MA_x(5)) : i_MA )) / round(MA_x(5)); 
  
    
    if     Dipa(i_MA) > MA_x(2) ...
            && ADX(i_MA) < ADX(i_MA-round(MA_x(6))) && ADX(i_MA) < ADX(i_MA-round(MA_x(7)))
%             && rshm(i_MA)-rshm(i_MA-1) > 0 && rshm(i_MA)-rshm(i_MA-1) > rslm(i_MA-1)-rslm(i_MA) ...
        t2t_MA(i_MA) = +1;
    elseif Dipa(i_MA) < MA_x(3) ...
            && ADX(i_MA) < ADX(i_MA-round(MA_x(8))) && ADX(i_MA) < ADX(i_MA-round(MA_x(9)))
%             && rslm(i_MA-1)-rslm(i_MA) > 0 && rslm(i_MA-1)-rslm(i_MA) > rshm(i_MA)-rshm(i_MA-1) ...
        t2t_MA(i_MA) = -1;
    end

    
    % MA Envelope
    
    % MA(i) = sum(raw_stock_cp_m(i:i+MA_x(9)-1))/MA_x(9);
    
    % if MA(i) %% downtrend 를 어떻게 정의하는가???
    % end
    
    % in downtrend
    % if current price 가 upper band(MA + MA_x(10))를 뚫으면
    % --> time2buy
    
    % in uptrend
    % if current price 가 lower band(MA - MA_x(11))를 뚫으면
    % --> time2sell
end % MA

%% fitness function

for fit_i = 1:md
    
    Tib = find(Trend(1:fit_i-1,1) ~= 0, 1, 'last' ); % T(i-1)
    Tin = fit_i + ( find(Trend(fit_i+1:md,1) ~= 0, 1, 'first' ) ); % T(i+1)
    
    if Trend(fit_i) == -1 % time2buy
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_MA( (Tib+1):(Tin-1) )~=0 ) == 0 % S(j)가 0이면
                fitness(fit_i) = (max( rscm( (Tib+1):(Tin-1) ) ) - rscm(fit_i));
                
            elseif sum( t2t_MA( (Tib+1):(Tin-1) )~=0 ) ~= 0 % S(j)가 0이 아니면
                if t2t_MA(fit_j) == -1 % S(j)가 -1 이면
                    fitness(fit_i) = rscm(fit_j) - rscm(fit_i); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_MA(fit_j) == 1 ... % S(j)가 1 이고
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i) ) < 0.05
                    fitness(fit_i) = 3 * ( max( rscm(Tib:Tin) ) - rscm(fit_i) );
                end
            end
        end
        
    elseif Trend(fit_i) == 1 % time2sell
        for fit_j = Tib+1 : Tin-1
            if sum( t2t_MA( (Tib+1):(Tin-1) )~=0 ) == 0
                fitness(fit_i) = (rscm(fit_i) - min( rscm( (Tib+1):(Tin-1) ) )) ;
                
            elseif sum( t2t_MA( (Tib+1):(Tin-1) )~=0 ) ~= 0
                if t2t_MA(fit_j) == 1
                    fitness(fit_i) = rscm(fit_i) - rscm(fit_j); % i 와 j 가 가까울수록 fitness 수치가 낮음
                    
                elseif t2t_MA(fit_j) == -1 ...
                        && ( abs(rscm(fit_j) - rscm(fit_i)) / rscm(fit_i)) < 0.05
                    fitness(fit_i) = 3 * ( rscm(fit_i) - min( rscm(Tib:Tin) ) );
                end
            end
        end
    end
end

%     i_MA
MA_x;
MA_fit = sum(fitness);

end
