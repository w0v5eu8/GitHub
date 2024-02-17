%%

md = 1000;
simt = md-246; % initializing 의 의미는???
   
raw_stock_cp_m(:,1) = double(raw_stock_cp_ed(stnm,:)); 
raw_stock_op_m(:,1) = double(raw_stock_op_ed(stnm,:)); 
raw_stock_hp_m(:,1) = double(raw_stock_hp_ed(stnm,:)); 
raw_stock_lp_m(:,1) = double(raw_stock_lp_ed(stnm,:)); 
raw_stock_v_m(:,1) = double(raw_stock_v_ed(stnm,:));
rscm = raw_stock_cp_m; rsom = raw_stock_op_m; 
rshm = raw_stock_hp_m; rslm = raw_stock_lp_m; 
rsvm = raw_stock_v_m;

rscmn = manorm(rscm)-1;
rshmn = manorm(rshm)-1;
rslmn = manorm(rslm)-1;

t2t_cp_m = double(rscm);
min_t2t_cp_m = min(t2t_cp_m);
max_t2t_cp_m = max(t2t_cp_m);

    for i_t2t = 1:md
        t2t_cp(i_t2t,1) = ((t2t_cp_m(i_t2t,1) - min_t2t_cp_m(1))/(max_t2t_cp_m(1) - min_t2t_cp_m(1)) - 0.5)*2;
    end    

ndz=9;
    
    for inpm2 = 1+ndz:length(t2t_cp(:,1))
        maxVal = max(t2t_cp(inpm2-ndz:inpm2,1)); minVal = min(t2t_cp(inpm2-ndz:inpm2,1));
        if maxVal - minVal > 0
            rscmm(inpm2,1) = ((t2t_cp(inpm2,1) - minVal)/(maxVal - minVal)-0.5)*2;
        end
    end
    
%     plot(rscmm); hold on; 
%     plot(rscmn*2, 'r'); hold off;
%     axis([md-100 md -1.2 1.2])





%% Trend
Trend_P = 0.05;  
Trend_T = 6; % 5; % minimal time interval
Trend_T2 = 1;

Trend = zeros(md,1);

for i_trend = 3 : (md - 3)
    if      rscm(i_trend) == rscm(i_trend - 1) && ...
            rscm(i_trend) == rscm(i_trend + 1)
        Trend(i_trend) = 0; % 어제와 같고, 내일과도 같으면 0

        
    elseif  rscm(i_trend) > rscm(i_trend - 2) && ...
            rscm(i_trend) > rscm(i_trend - 1) && ...
            rscm(i_trend) > rscm(i_trend + 1) && ...
            rscm(i_trend) > rscm(i_trend + 2) 
        Trend(i_trend) = +1; % 그제보다 높고, 어제보다 높고, 내일보다 높고, 모래보다 높으면 SELL
    elseif  rscm(i_trend) < rscm(i_trend - 2) && ...
            rscm(i_trend) < rscm(i_trend - 1) && ...
            rscm(i_trend) < rscm(i_trend + 1) && ...
            rscm(i_trend) < rscm(i_trend + 2)
        Trend(i_trend) = -1; % 그제보다 낮고, 어제보다 낮고, 내일보다 낮고, 모래보다 낮으면 BUY

    elseif  rscm(i_trend) >  rscm(i_trend - 2) && ...
            rscm(i_trend) >  rscm(i_trend - 1) && ...
            rscm(i_trend) <  rscm(i_trend + 1) && ...
            rscm(i_trend) <  rscm(i_trend + 2)
        Trend(i_trend) = -1; % 그제보다 높고, 어제보다 높고, 내일보다 낮고, 모래보다 낮으면 BUY
    elseif  rscm(i_trend) <  rscm(i_trend - 2) && ...
            rscm(i_trend) <  rscm(i_trend - 1) && ...
            rscm(i_trend) >  rscm(i_trend + 1) && ...
            rscm(i_trend) >  rscm(i_trend + 2)
        Trend(i_trend) = +1; % 그제보다 낮고, 어제보다 낮고, 내일보다 높고, 모래보다 높으면 SELL
   
    end
end
Trend_ch = Trend;
% 어제와 내일 가격과 비교하기 때문에 처음과 마지막 날 값은 무조건 0이 됨
% 어제, 오늘, 내일 종가가 다 같으면 오늘 Trend 값을 0으로 처리
% --> 어제와 오늘은 같지만 내일과는 다르면?
% 아직 경우의 수를 충분히 고려하지 않았음! --> 수정 완료
% -1이나 +1이 연속해서 나오는 경우(종가변동이 없는 경우) 처음 신호를 받음
% 문제: 바로 내일 신호만 갖고 전날 teacher 신호를 내는 것이 맞는가?
% 적시성과 신뢰성의 문제
% 신뢰성이 없는 정보가 더 치명적일 수 있다 ?

Trend_m1 = find(abs(Trend)==1); % 신호가 있는 날짜들만 호출
sT = size(Trend_m1,1);
for i2_trend = 2 : sT
    if Trend(Trend_m1(i2_trend -1)) ~= 0
        if Trend_m1(i2_trend) - Trend_m1(i2_trend - 1) < Trend_T && ...
                ( abs( rscm(Trend_m1(i2_trend - 1)) - rscm(Trend_m1(i2_trend)) ) / ...
                ( (rscm(Trend_m1(i2_trend - 1)) + rscm(Trend_m1(i2_trend))) / 2 ) ) ...
                < Trend_P ...
                || Trend_m1(i2_trend) - Trend_m1(i2_trend - 1) < Trend_T2
%             Trend(Trend_m1(i2_trend - 1)) = 0;
            Trend(Trend_m1(i2_trend)) = 0;
        end
    end
end
Trend_ch2 = Trend;
% 신호가 있는 날짜들의 간격이 Trend_T 이내이고,
% 동시에 가격 변동폭이 평균가 대비 기준치(Trend_P) 이하인 경우엔 두 신호를 모두 지움 (0으로 설정)

Trend_m3 = find(abs(Trend)==1);
for i4_trend = 2 : (size(Trend_m3,1) - 0)
    
    mv = (Trend_m3(i4_trend) - Trend_m3(i4_trend - 1)); % 밑변
    
    if     Trend(Trend_m3(i4_trend - 1)) > Trend(Trend_m3(i4_trend))
        Trend((Trend_m3(i4_trend - 1) + 1):(Trend_m3(i4_trend) - 1)) = ...
            Trend(Trend_m3(i4_trend - 1)) + (2/-mv)*(1:(mv-1)); % down trend
    elseif Trend(Trend_m3(i4_trend - 1)) < Trend(Trend_m3(i4_trend))
        Trend((Trend_m3(i4_trend - 1) + 1):(Trend_m3(i4_trend) - 1)) = ...
            Trend(Trend_m3(i4_trend - 1)) + (2/+mv)*(1:(mv-1)); % up trend
    elseif Trend(Trend_m3(i4_trend - 1)) == Trend(Trend_m3(i4_trend))
        Trend((Trend_m3(i4_trend - 1) + 1):(Trend_m3(i4_trend) - 1)) = ...
            Trend(Trend_m3(i4_trend - 1)); % quo    
    end
end
% 선 긋기

Trend_m4 = find(abs(Trend)==1, 1, 'last');
if Trend_m4 < md - 1
    Trend(Trend_m4+1:md) = 0;
end
% 마지막 signal 이후 오늘까지는 0으로 설정 (선 긋기 마무리)


buy=zeros(1000,1); sell=zeros(1000,1);
for ii = 1:1000
    if (Trend(ii)) == 1
        buy(ii) = 1;
    elseif (Trend(ii)) == -1
        sell(ii) = 1;
    end
end

