tic; clc
%% global variables 
clear global raw_stock_cp_m raw_stock_op_m raw_stock_hp_m raw_stock_lp_m raw_stock_v_m md Trend stock_num rscm raw_stock_n_ed ...
         t2t_RSI t2t_RC t2t_MTM t2t_SS t2t_CC1 t2t_CC2 t2t_CC3 t2t_MA t2t_VR t2t_PL t2t_MFI t2t_PNVI t2t_CCI t2t_WR t2t_DMI ...
         RSI sROC lROC M2M MTM mtm pKD pK pD wicks tails bodies CC2B CC2S Dipa VR v_rise v_fall VRCO PL mPL PLMA PLMAh MFI pvi pvi_ma nvi nvi_ma CCI WPCTR ADX DX PDI MDI TR PDM MDM
      global raw_stock_cp_m raw_stock_op_m raw_stock_hp_m raw_stock_lp_m raw_stock_v_m md Trend stock_num rscm rsom rshm rslm rsvm raw_stock_n_ed...
         t2t_RSI t2t_RC t2t_MTM t2t_SS t2t_CC1 t2t_CC2 t2t_CC3 t2t_MA t2t_VR t2t_PL t2t_MFI t2t_PNVI t2t_CCI t2t_WR t2t_DMI ...
         RSI sROC lROC M2M MTM mtm pKD pK pD wicks tails bodies CC2B CC2S Dipa VR v_rise v_fall VRCO PL mPL PLMA PLMAh MFI pvi pvi_ma nvi nvi_ma CCI WPCTR ADX DX PDI MDI TR PDM MDM

%% TA
    TA_header
%     stock_num = [LGD SSE SSEP KIA NAV SHF]; 
%     stock_num = [LGE LGEP HDC HDCB SSH WRF]; 
%     stock_num = [GS DSIC GSHS SK SSTW LTS HDM];
    stock_num = [SSE]; % test
%%    
   
for stnm = stock_num;
    %     raw_stock_v; raw_stock_op; raw_stock_cp; raw_stock_hp; raw_stock_lp; raw_stock_fh; raw_stock_fc; raw_stock_d; raw_stock_names; raw_stock_codes;
    raw_stock_cp_m(:,1) = double(raw_stock_cp_ed(stnm,:)); raw_stock_op_m(:,1) = double(raw_stock_op_ed(stnm,:)); 
    raw_stock_hp_m(:,1) = double(raw_stock_hp_ed(stnm,:)); raw_stock_lp_m(:,1) = double(raw_stock_lp_ed(stnm,:)); raw_stock_v_m(:,1) = double(raw_stock_v_ed(stnm,:));
    rscm = raw_stock_cp_m; rsom = raw_stock_op_m; rshm = raw_stock_hp_m; rslm = raw_stock_lp_m; rsvm = raw_stock_v_m;
        max_duration = 1000; md = max_duration;

%% Set

if     stnm == NAV;
    Trend_P = 0.030;
elseif stnm == SSE;
    Trend_P = 0.05;
elseif stnm == MIM;
    Trend_P = 0.029;    
elseif stnm == HDM;
    Trend_P = 0.023;    
elseif stnm == LTS;
    Trend_P = 0.023;    
elseif stnm == SHF;
    Trend_P = 0.015;    
elseif stnm == WRF;
    Trend_P = 0.020;    
elseif stnm == SK;
    Trend_P = 0.021;    
elseif stnm == HDC;
    Trend_P = 0.022;
elseif stnm == SSTW;
    Trend_P = 0.017;    
elseif stnm == CJDT;
    Trend_P = 0.025;    
elseif stnm == HDMB;
    Trend_P = 0.024;
elseif stnm == GSHS;
    Trend_P = 0.029;
elseif stnm == KGIN;
    Trend_P = 0.048;
elseif stnm == SSEP;
    Trend_P = 0.021;
elseif stnm == LGD; 
    Trend_P = 0.06;   
elseif stnm == LGE;
    Trend_P = 0.020;
elseif stnm == LGEP
    Trend_P = 0.020;
elseif stnm == DSIC
    Trend_P = 0.022;    
elseif stnm == KIA;
    Trend_P = 0.025;    
elseif stnm == SKH;
    Trend_P = 0.025;     
elseif stnm == LGCP;
    Trend_P = 0.020;
elseif stnm == LGL; 
    Trend_P = 0.025;
elseif stnm == HDD; 
    Trend_P = 0.025;
elseif stnm == KDEX; 
    Trend_P = 0.009;
elseif stnm == LDCH; 
    Trend_P = 0.022;    
elseif stnm == SSBR;
    Trend_P = 0.021;
elseif stnm == SEDP;
    Trend_P = 0.021;
elseif stnm == SSH;
    Trend_P = 0.021;   
elseif stnm == KTRN;
    Trend_P = 0.033;    
elseif stnm == HDE;
    Trend_P = 0.029;
elseif stnm == KCC;
    Trend_P = 0.022;
elseif stnm == DHM;
    Trend_P = 0.025; 
elseif stnm == KHO;
    Trend_P = 0.024;    
elseif stnm == GS;
    Trend_P = 0.024;
elseif stnm == HDCB;
    Trend_P = 0.024;           
end

%% Trend

Trend_T = 6; % 5; % minimal time interval
Trend_T2 = 1;

Trend = zeros(md,1);

for i_trend = 4:(md - 3)
    if      rscm(i_trend) == rscm(i_trend - 1) && ...
            rscm(i_trend) == rscm(i_trend + 1)
        Trend(i_trend) = 0; % 어제와 같고, 내일과도 같으면 0

        
    elseif  rscm(i_trend) > rscm(i_trend - 2) && ...
            rscm(i_trend) > rscm(i_trend - 1) && ...
            rscm(i_trend) > rscm(i_trend + 1) && ...
            rscm(i_trend) > rscm(i_trend + 2) && ...
            rscm(i_trend) > rscm(i_trend + 3)
        Trend(i_trend) = +1; % 그제보다 높거나 같고, 어제보다 높거나 같고, 내일보다 높거나 같고, 모래보다 높거나 같고, 글피보다 높거나 같으면 SELL
    elseif  rscm(i_trend) < rscm(i_trend - 2) && ...
            rscm(i_trend) < rscm(i_trend - 1) && ...
            rscm(i_trend) < rscm(i_trend + 1) && ...
            rscm(i_trend) < rscm(i_trend + 2) && ...
            rscm(i_trend) < rscm(i_trend + 3)
        Trend(i_trend) = -1; % 그제보다 높거나 같고, 어제보다 낮거나 같고, 내일보다 낮거나 같고, 모래보다 낮거나 같고, 글피보다 낮거나 같으면 BUY

    elseif  rscm(i_trend) >  rscm(i_trend - 2) && ...
            rscm(i_trend) >  rscm(i_trend - 1) && ...
            rscm(i_trend) <  rscm(i_trend + 1) && ...
            rscm(i_trend) <  rscm(i_trend + 2)
        Trend(i_trend) = -1; % 그제보다 높고, 어제보다 높고, 내일보다 낮고, 모래보다 낮으면 -1
    elseif  rscm(i_trend) <  rscm(i_trend - 2) && ...
            rscm(i_trend) <  rscm(i_trend - 1) && ...
            rscm(i_trend) >  rscm(i_trend + 1) && ...
            rscm(i_trend) >  rscm(i_trend + 2)
        Trend(i_trend) = +1; % 그제보다 낮고, 어제보다 낮고, 내일보다 높고, 모래보다 높으면 +1
        
%     elseif  rscm(i_trend) <  rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) <  rscm(i_trend + 1)
%         Trend(i_trend) = 0; % 그제보다 낮고, 어제와 같고, 내일보단 낮으면 0
%     elseif  rscm(i_trend) >  rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) >  rscm(i_trend + 1)
%         Trend(i_trend) = 0; % 그제보다 높고, 어제와 같고, 내일보다 높으면 0
%     elseif  rscm(i_trend) <  rscm(i_trend - 3) && ...
%             rscm(i_trend) == rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) <  rscm(i_trend + 1)
%         Trend(i_trend) = 0; % 3일전보다 낮고, 그제, 어제와 같고, 내일보단 낮으면 0
%     elseif  rscm(i_trend) >  rscm(i_trend - 3) && ...
%             rscm(i_trend) == rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) >  rscm(i_trend + 1)
%         Trend(i_trend) = 0; % 3일전보다 높고, 그제, 어제와 같고, 내일보다 높으면 0
%         % 결국 전날이나 그제과 같으면 0 --> 동일한 종가가 유지되면 가장 앞 선 시점에 신호를 내도록..
        
        
%     elseif  rscm(i_trend) >  rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) <  rscm(i_trend + 1) && ...
%             rscm(i_trend) <  rscm(i_trend + 2)
%         Trend(i_trend) = -1; % 그제보다 높고, 어제와는 같고, 내일보다 낮고, 모래보다 낮으면 BUY --> 이 게 문제가 있는듯
%     elseif  rscm(i_trend) <  rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) >  rscm(i_trend + 1) && ...
%             rscm(i_trend) >  rscm(i_trend + 2)
%         Trend(i_trend) = +1; % 그제보다 낮고, 어제와는 같고, 내일보다 높고, 모래보다 높으면 SELL --> 마찬가지
%     elseif  rscm(i_trend) >  rscm(i_trend - 3) && ...
%             rscm(i_trend) == rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) <  rscm(i_trend + 1) && ...
%             rscm(i_trend) <  rscm(i_trend + 2)
%         Trend(i_trend) = -1; % 3일전보다 높고, 그제, 어제와는 같고, 내일보다 낮고, 모래보다 낮으면 BUY
%     elseif  rscm(i_trend) <  rscm(i_trend - 3) && ...
%             rscm(i_trend) == rscm(i_trend - 2) && ...
%             rscm(i_trend) == rscm(i_trend - 1) && ...
%             rscm(i_trend) >  rscm(i_trend + 1) && ...
%             rscm(i_trend) >  rscm(i_trend + 2)
%         Trend(i_trend) = +1; % 3일전보다 낮고, 그제, 어제와는 같고, 내일보다 높고, 모래보다 높으면 SELL
        
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


%     Trend_m1 = find(abs(Trend)==1); % 신호가 있는 날짜들만 호출
%
%     for i2_trend = 2 : (size(Trend_m1,1) - 0)
%         if Trend(Trend_m1(i2_trend - 1)) == -1 && Trend(Trend_m1(i2_trend)) == -1
%                 Trend(Trend_m1(i2_trend - 1)) = 0;
%         elseif Trend(Trend_m1(i2_trend - 1)) == 1 && Trend(Trend_m1(i2_trend)) == 1
%                 Trend(Trend_m1(i2_trend - 1)) = 0;
%         end
%     end
%     % +/-1 다음에 다시 +/-1 신호가 나오는 경우 마지막 신호를 받음
%     % --> 나중에 ESN에서 문제가 될 것으로 보임(마지막 teacher 신호를 믿을 수 없게 됨)

%     Trend_m1 = find(abs(Trend)==1); % 신호가 있는 날짜들만 호출
%
%     for i2_trend = 2 : (size(Trend_m1,1) - 0)
%         if Trend(Trend_m1(i2_trend - 1)) == +1 && Trend(Trend_m1(i2_trend)) == -1 ...
%                 && Trend_m1(i2_trend) - Trend_m1(i2_trend - 1) < 3
%                 Trend(Trend_m1(i2_trend - 1)) = 0;
%                 Trend(Trend_m1(i2_trend)) = 0;
%         end
%     end

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

%     Trend_m2 = find(abs(Trend)==1);
%     for i3_trend = 2 : (size(Trend_m2,1) - 0)
%         if Trend(Trend_m2(i3_trend - 1)) == Trend(Trend_m2(i3_trend))
%             if     Trend(Trend_m2(i3_trend)) == 1
%                    Trend(Trend_m2(i3_trend - 1):Trend_m2(i3_trend)) = 1;
%             elseif Trend(Trend_m2(i3_trend)) == -1
%                    Trend(Trend_m2(i3_trend - 1):Trend_m2(i3_trend)) = -1;
%             end
%         end
%     end
%     % Trend 값이 같은 경우, 두 날짜의 실제 가격을 비교해서 상황에 적합한 신호만 남김
%     % --> 두 날짜 사이를 모두 -1 이나 +1 로 채우는 방식으로 변경함
%     Trend_ch3 = Trend;


% Trend_m25 = find(abs(Trend)==1, 1, 'last');
% if Trend_m25 > md - 2
%     Trend(Trend_m25:md) = 0;
% end
% 오늘을 기준으로 2일 이내에 나온 signal 은 무시함 (0으로 설정)
% downtrend 에서 하루 주가가 튀었다가 다시 이어서 떨어지는 경우, BUY signal 이 나오면 안 됨

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


%% test
   rscm_test(:,1) = double(raw_stock_cp_ed(stnm,:));
% % 
%     [(1:md)' Trend_ch Trend_ch2 Trend rscm_test]
% % %     [(1:md)' Trend_ch Trend_ch2 Trend_ch3 Trend rscm_test]
% % 
%     figure; plot(rscm_test, 'k'); hold on;
%     plot(rscm_test.*(Trend==-1), 'o', 'color', 'r');
%     plot(rscm_test.*(Trend==1), 'o', 'color', 'b');
%     title(num2str(stnm)); hold off; axis([-Inf md 10000 Inf]);


%     figure('Position', [100,100,1200,800]); subplot(2,1,1); plot(Trend); axis([md-100 md -1.2 1.2]);
%     subplot(2,1,2); plot(rscm_test); axis([md-100 md -Inf Inf]);
%     ddd=raw_stock_d_ed(1,md);
%     fn=[num2str(ddd),'.jpg'];
%     saveas(gcf,fn)
%     close

%%
    Simulation

    
    
    
    

    
    
    
    
%% Technical Analyses
%     pause


%% RSI Relative Strength Index
% average of days / ob / os / slope / slope 

    LB = [  4;  40;  50;  1.00;  0.50];
    UB = [ 16;  50;  60;  2.00;  1.00];    

numpa_RSI=5; rng('default')
%     options = gaoptimset(@ga);
%     options = gaoptimset('PopInitRange',{[]}, 'InitialPopulation',[], 'PopulationType','doubleVector', ...
%         'CreationFcn',{@gacreationlinearfeasible}, 'CrossoverFcn',{@crossoverscattered}, 'MutationFc', {@mutationadaptfeasible})   
options_RSI = gaoptimset('PopulationSize',200, 'Generations',20 );
[RSI_x, fval, exitflag, output, population, scores] = ...
    ga(@prv_ga_fit_RSI, numpa_RSI, [], [], [], [], LB, UB, [], [], options_RSI);
para_RSI=zeros(stnm,numpa_RSI); para_RSI(stnm,:) = RSI_x;
% fval_RSI(stnm) = fval; exitflag_RSI(stnm) = exitflag; output_RSI(stnm) = output;
% populaton_RSI(stnm) = population; scores_RSI(stnm,:) = scores;
t2t_RSI_a=zeros(md,stnm); t2t_RSI_a(:,stnm) = t2t_RSI;
t2t_RSI_b = (t2t_RSI==-1); t2t_RSI_s = (t2t_RSI==1); 
t2t_RSI_bb = rscm(:,1).*t2t_RSI_b; t2t_RSI_ss = rscm(:,1).*t2t_RSI_s;

% pause
%% Rate of Change
% lt st nh nl equb eulb

    LB = [ 19;   4;  101;   95;   05;   05];
    UB = [ 31;  11;  105;   99;   15;   15];

numpa_RC=6; rng('default')
options_RC = gaoptimset('PopulationSize',200, 'Generations',20 );
[RC_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_RC, numpa_RC, [], [], [], [], LB, UB, [], [], options_RC);
para_RC=zeros(stnm,numpa_RC); para_RC(stnm,:) = RC_x; 
% fval_RC(stnm) = fval; exitflag_RC(stnm) = exitflag; output_RC(stnm) = output;
% populaton_RC(stnm) = population; scores_RC(stnm,:) = scores;
t2t_RC_a=zeros(md,stnm); t2t_RC_a(:,stnm) = t2t_RC;
t2t_RC_b = (t2t_RC==-1); t2t_RC_s = (t2t_RC==1); 
t2t_RC_bb = rscm(:,1).*t2t_RC_b; t2t_RC_ss = rscm(:,1).*t2t_RC_s;


%% MTM
% M2M 이
% 2보다 작고 2-3보다 크면 산다 --> 판다
% 4보다 크고 4+5보다 작으면 판다 --> 산다

    LB = [  9;  -.40;  .20;  .10;  .20];
    UB = [ 16;  -.10;  .90;  .40;  .90];

numpa_MTM=5; rng('default')
options_MTM = gaoptimset('PopulationSize',200, 'Generations',20 );
[MTM_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_MTM, numpa_MTM, [], [], [], [], LB, UB, [], [], options_MTM);
para_MTM=zeros(stnm,numpa_MTM); para_MTM(stnm,:) = MTM_x; 
% fval_MTM(stnm) = fval; exitflag_MTM(stnm) = exitflag; output_MTM(stnm) = output;
% populaton_MTM(stnm) = population; scores_MTM(stnm,:) = scores;
t2t_MTM_a=zeros(md,stnm); t2t_MTM_a(:,stnm) = t2t_MTM;
t2t_MTM_b = (t2t_MTM==-1); t2t_MTM_s = (t2t_MTM==1); 
t2t_MTM_bb = rscm(:,1).*t2t_MTM_b; t2t_MTM_ss = rscm(:,1).*t2t_MTM_s;


%% Stochastic system
% pK pK-pD pK pD-pK

    LB = [  55;   1;    40;   1;    4;    4;    4];
    UB = [  60;   1;    45;   1;   31;   31;   31];

numpa_SS=7; rng('default')
options_SS = gaoptimset('PopulationSize',200, 'Generations',20 );
[SS_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_SS, numpa_SS, [], [], [], [], LB, UB, [], [], options_SS);
para_SS=zeros(stnm,numpa_SS); para_SS(stnm,:) = SS_x; 
% fval_SS(stnm) = fval; exitflag_SS(stnm) = exitflag; output_SS(stnm) = output;
% populaton_SS(stnm) = population; scores_SS(stnm,:) = scores;
t2t_SS_a=zeros(md,stnm); t2t_SS_a(:,stnm) = t2t_SS;
t2t_SS_b = (t2t_SS==-1); t2t_SS_s = (t2t_SS==1); 
t2t_SS_bb = rscm(:,1).*t2t_SS_b; t2t_SS_ss = rscm(:,1).*t2t_SS_s;


%% Candle Chart system

% % % CC (test)
% % 
% %     LB = [  0;   0; 0.3; 0.3;   0;   0;   0;   0];
% %     UB = [ 10;  10;  10;  10;   5;   5;   5;   5];
% % 
% % numpa_CC=8; rng('default')
% % options_CC = gaoptimset('PopulationSize',200, 'Generations',20 );
% % [CC_x, fval, exitflag, output, population, scores] = ... 
% %     ga(@prv_ga_fit_CC, numpa_CC, [], [], [], [], LB, UB, [], [], options_CC);
% % para_CC=zeros(stnm,numpa_CC); para_CC(stnm,:) = CC_x; 
% % fval_CC(stnm) = fval; exitflag_CC(stnm) = exitflag; output_CC(stnm) = output;
% % populaton_CC(stnm) = population; scores_CC(stnm,:) = scores;
% % t2t_CC_a=zeros(md,stnm); t2t_CC_a(:,stnm) = t2t_CC;
% % t2t_CC_b = (t2t_CC==-1); t2t_CC_s = (t2t_CC==1); 
% % t2t_CC_bb = rscm(:,1).*t2t_CC_b; t2t_CC_ss = rscm(:,1).*t2t_CC_s;
% % test
% % fname = [num2str(stnm),'_CC'];
% % figure('name', fname, 'Position', [100,150,1200,600]); plot(rscm, 'k'); hold on; 
% % for i=1:md
% %     if t2t_CC_bb(i) ~= 0
% %         plot(i,t2t_CC_bb(i), 'o', 'color', 'r');
% %     elseif t2t_CC_ss(i) ~= 0 
% %         plot(i,t2t_CC_ss(i), 'o', 'color', 'b');
% %     end
% % end
% % hold off


%% CC1

    LB = [  0;   0;   4;   3;  10];
    UB = [  0;   0;  16;  20;  40];

numpa_CC1=5; rng('default')
options_CC1 = gaoptimset('PopulationSize',200, 'Generations',20 );
[CC1_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_CC1, numpa_CC1, [], [], [], [], LB, UB, [], [], options_CC1);
para_CC1=zeros(stnm,numpa_CC1); para_CC1(stnm,:) = CC1_x; 
% fval_CC1(stnm) = fval; exitflag_CC1(stnm) = exitflag; output_CC1(stnm) = output;
% populaton_CC1(stnm) = population; scores_CC1(stnm,:) = scores;
t2t_CC1_a=zeros(md,stnm); t2t_CC1_a(:,stnm) = t2t_CC1;
t2t_CC1_b = (t2t_CC1==-1); t2t_CC1_s = (t2t_CC1==1); 
t2t_CC1_bb = rscm(:,1).*t2t_CC1_b; t2t_CC1_ss = rscm(:,1).*t2t_CC1_s;


%% CC2

    LB = [   0;   0;   4];
    UB = [   0;   0;  16];

numpa_CC2=3; rng('default')
options_CC2 = gaoptimset('PopulationSize',200, 'Generations',20 );
[CC2_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_CC2, numpa_CC2, [], [], [], [], LB, UB, [], [], options_CC2);
para_CC2=zeros(stnm,numpa_CC2); para_CC2(stnm,:) = CC2_x; 
% fval_CC2(stnm) = fval; exitflag_CC2(stnm) = exitflag; output_CC2(stnm) = output;
% populaton_CC2(stnm) = population; scores_CC2(stnm,:) = scores;
t2t_CC2_a=zeros(md,stnm); t2t_CC2_a(:,stnm) = t2t_CC2;
t2t_CC2_b = (t2t_CC2==-1); t2t_CC2_s = (t2t_CC2==1); 
t2t_CC2_bb = rscm(:,1).*t2t_CC2_b; t2t_CC2_ss = rscm(:,1).*t2t_CC2_s;

 
%% CC3

    LB = [  0;   0;   4;   0];
    UB = [  5;   5;  16;   5];

numpa_CC3=4; rng('default')
options_CC3 = gaoptimset('PopulationSize',200, 'Generations',20 );
[CC3_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_CC3, numpa_CC3, [], [], [], [], LB, UB, [], [], options_CC3);
para_CC3=zeros(stnm,numpa_CC3); para_CC3(stnm,:) = CC3_x; 
% fval_CC3(stnm) = fval; exitflag_CC3(stnm) = exitflag; output_CC3(stnm) = output;
% populaton_CC3(stnm) = population; scores_CC3(stnm,:) = scores;
t2t_CC3_a=zeros(md,stnm); t2t_CC3_a(:,stnm) = t2t_CC3;
t2t_CC3_b = (t2t_CC3==-1); t2t_CC3_s = (t2t_CC3==1); 
t2t_CC3_bb = rscm(:,1).*t2t_CC3_b; t2t_CC3_ss = rscm(:,1).*t2t_CC3_s;


%% Moving Average (Disparity)

% % % LB = [30;  5; 10; 10; 10; 10; 10; 10];
% % % UB = [Inf; 20; Inf; Inf; Inf; Inf; Inf; Inf];
% % % rng('default')
% % % [MA_x, fval, exitflag, output, population, scores] = ... 
% % %     ga(@prv_ga_fit_MA, 8, [], [], [], [], LB, UB, [], [], options);
% % % para_MA(stnm,:) = MA_x; 
% % % % fval_MA(stnm) = fval; exitflag_MA(stnm) = exitflag; output_MA(stnm) = output;
% % % % populaton_MA(stnm) = population; scores_MA(stnm,:) = scores;
% % % t2t_MA_a(:,stnm) = t2t_MA;
% % % t2t_MA_b = (t2t_MA==-1); t2t_MA_s = (t2t_MA==1); 
% % % t2t_MA_bb = rscm(:,1).*t2t_MA_b; t2t_MA_ss = rscm(:,1).*t2t_MA_s;
% % % fname = [num2str(stnm),'_MA'];
% % % figure('name', fname); plot(rscm, 'k');
% % % hold on; plot(t2t_MA_bb, 'o', 'color', 'r'); plot(t2t_MA_ss, 'o', 'color', 'b');
% % % hold off

    LB = [  9;  90;  100;    9;    9;   1;   3;   1;   3];
    UB = [ 31; 100;  110;   16;   16;   3;   5;   3;   5];

numpa_MA=9; rng('default')
options_MA = gaoptimset('PopulationSize',200, 'Generations',20 );
[MA_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_MA, numpa_MA, [], [], [], [], LB, UB, [], [], options_MA);
para_MA=zeros(stnm,numpa_MA); para_MA(stnm,:) = MA_x; 
% fval_MA(stnm) = fval; exitflag_MA(stnm) = exitflag; output_MA(stnm) = output;
% populaton_MA(stnm) = population; scores_MA(stnm,:) = scores;
t2t_MA_a=zeros(md,stnm); t2t_MA_a(:,stnm) = t2t_MA;
t2t_MA_b = (t2t_MA==-1); t2t_MA_s = (t2t_MA==1); 
t2t_MA_bb = rscm(:,1).*t2t_MA_b; t2t_MA_ss = rscm(:,1).*t2t_MA_s;


%% VR

    LB = [  4;    0;    0;    0;  100];
    UB = [ 21;    0;    0;    0;  300];

numpa_VR=5; rng('default')
options_VR = gaoptimset('PopulationSize',200, 'Generations',20 );
[VR_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_VR, numpa_VR, [], [], [], [], LB, UB, [], [], options_VR);
para_VR=zeros(stnm,numpa_VR); para_VR(stnm,:) = VR_x; 
%fval_VR(stnm) = fval; exitflag_VR(stnm) = exitflag; output_VR(stnm) = output;
% populaton_VR(stnm) = population; scores_VR(stnm,:) = scores;
t2t_VR_a=zeros(md,stnm); t2t_VR_a(:,stnm) = t2t_VR;
t2t_VR_b = (t2t_VR==-1); t2t_VR_s = (t2t_VR==1); 
t2t_VR_bb = rscm(:,1).*t2t_VR_b; t2t_VR_ss = rscm(:,1).*t2t_VR_s;


%% PL

    LB = [  6;   4;   4;    8;    8;   1;   3;   1;  3;   4;   0]; % 50;  30];
    UB = [ 16;  16;  16;   20;   20;   3;   5;   3;  5;  21;   5]; % 70;  50];

numpa_PL=11; rng('default')
options_PL = gaoptimset('PopulationSize',200, 'Generations',20 );
[PL_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_PL, numpa_PL, [], [], [], [], LB, UB, [], [], options_PL);
para_PL=zeros(stnm,numpa_PL); para_PL(stnm,:) = PL_x; 
% fval_PL(stnm) = fval; exitflag_PL(stnm) = exitflag; output_PL(stnm) = output;
% populaton_PL(stnm) = population; scores_PL(stnm,:) = scores;
t2t_PL_a=zeros(md,stnm); t2t_PL_a(:,stnm) = t2t_PL;
t2t_PL_b = (t2t_PL==-1); t2t_PL_s = (t2t_PL==1); 
t2t_PL_bb = rscm(:,1).*t2t_PL_b; t2t_PL_ss = rscm(:,1).*t2t_PL_s;


%% MFI
% 
    LB = [   9;   40;   40;    9;    9;   1;   3;   1;   3];
    UB = [  21;   60;   60;   21;   21;   3;   5;   3;   5];

numpa_MFI=9; rng('default')
options_MFI = gaoptimset('PopulationSize',200, 'Generations',20 );
[MFI_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_MFI, numpa_MFI, [], [], [], [], LB, UB, [], [], options_MFI);
para_MFI=zeros(stnm,numpa_MFI); para_MFI(stnm,:) = MFI_x; 
% fval_MFI(stnm) = fval; exitflag_MFI(stnm) = exitflag; output_MFI(stnm) = output;
% populaton_MFI(stnm) = population; scores_MFI(stnm,:) = scores;
t2t_MFI_a=zeros(md,stnm); t2t_MFI_a(:,stnm) = t2t_MFI;
t2t_MFI_b = (t2t_MFI==-1); t2t_MFI_s = (t2t_MFI==1); 
t2t_MFI_bb = rscm(:,1).*t2t_MFI_b; t2t_MFI_ss = rscm(:,1).*t2t_MFI_s;


%% PNVI

    LB = [   3;   5;  15;   4;   100;   20;   20;    80;   20;   20];
    UB = [  55;  59;  30;   9;   130;   30;   30;   100;   30;   30];

numpa_PNVI=10; rng('default')
options_PNVI = gaoptimset('PopulationSize',200, 'Generations',20 );
[PNVI_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_PNVI, numpa_PNVI, [], [], [], [], LB, UB, [], [], options_PNVI);
para_PNVI=zeros(stnm,numpa_PNVI); para_PNVI(stnm,:) = PNVI_x; 
% fval_PNVI(stnm) = fval; exitflag_PNVI(stnm) = exitflag; output_PNVI(stnm) = output;
% populaton_PNVI(stnm) = population; scores_PNVI(stnm,:) = scores;
t2t_PNVI_a=zeros(md,stnm); t2t_PNVI_a(:,stnm) = t2t_PNVI;
t2t_PNVI_b = (t2t_PNVI==-1); t2t_PNVI_s = (t2t_PNVI==1); 
t2t_PNVI_bb = rscm(:,1).*t2t_PNVI_b; t2t_PNVI_ss = rscm(:,1).*t2t_PNVI_s;


%% CCI

    LB = [   6;   6;     0;   30;  -30;    9;    9;    1;    3;    1;    3];
    UB = [  22;  22;  0.05;   50;    0;   21;   21;    3;    5;    3;    5];

numpa_CCI=11; rng('default')
options_CCI = gaoptimset('PopulationSize',200, 'Generations',20 );
[CCI_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_CCI, numpa_CCI, [], [], [], [], LB, UB, [], [], options_CCI);
para_CCI=zeros(stnm,numpa_CCI); para_CCI(stnm,:) = CCI_x; 
% fval_CCI(stnm) = fval; exitflag_CCI(stnm) = exitflag; output_CCI(stnm) = output;
% populaton_CCI(stnm) = population; scores_CCI(stnm,:) = scores;
t2t_CCI_a=zeros(md,stnm); t2t_CCI_a(:,stnm) = t2t_CCI;
t2t_CCI_b = (t2t_CCI==-1); t2t_CCI_s = (t2t_CCI==1); 
t2t_CCI_bb = rscm(:,1).*t2t_CCI_b; t2t_CCI_ss = rscm(:,1).*t2t_CCI_s;


%% WR

    LB = [   9;  -60;   10;   -50;   10;    5;    5;   1;   3;   1;   3];
    UB = [  21;  -50;   20;   -40;   20;   20;   20;   3;   5;   3;   5];

numpa_WR=11; rng('default')
options_WR = gaoptimset('PopulationSize',200, 'Generations',20 );
[WR_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_WR, numpa_WR, [], [], [], [], LB, UB, [], [], options_WR);
para_WR=zeros(stnm,numpa_WR); para_WR(stnm,:) = WR_x; 
% fval_WR(stnm) = fval; exitflag_WR(stnm) = exitflag; output_WR(stnm) = output;
% populaton_WR(stnm) = population; scores_WR(stnm,:) = scores;
t2t_WR_a=zeros(md,stnm); t2t_WR_a(:,stnm) = t2t_WR;
t2t_WR_b = (t2t_WR==-1); t2t_WR_s = (t2t_WR==1); 
t2t_WR_bb = rscm(:,1).*t2t_WR_b; t2t_WR_ss = rscm(:,1).*t2t_WR_s;


%% DMI

    LB = [   4;   4;   1;   3;   1;   1;   3;   1];
    UB = [  21;  21;   3;   5;   1;   3;   5;   1];

numpa_DMI=8; rng('default')
options_DMI = gaoptimset('PopulationSize',200, 'Generations',20 );
[DMI_x, fval, exitflag, output, population, scores] = ... 
    ga(@prv_ga_fit_DMI, numpa_DMI, [], [], [], [], LB, UB, [], [], options_DMI);
para_DMI=zeros(stnm,numpa_DMI); para_DMI(stnm,:) = DMI_x; 
% fval_DMI(stnm) = fval; exitflag_DMI(stnm) = exitflag; output_DMI(stnm) = output;
% populaton_DMI(stnm) = population; scores_DMI(stnm,:) = scores;
t2t_DMI_a=zeros(md,stnm); t2t_DMI_a(:,stnm) = t2t_DMI;
t2t_DMI_b = (t2t_DMI==-1); t2t_DMI_s = (t2t_DMI==1); 
t2t_DMI_bb = rscm(:,1).*t2t_DMI_b; t2t_DMI_ss = rscm(:,1).*t2t_DMI_s;


%% save
% 
% save(['test_',num2str(stnm)])

% save(['test_',num2str(stnm)])
save([num2str(stnm),'_TA'])

% 
% % cc=clock;
% % ccc=cc(2:5);
% % save(['Trend_',num2str(stnm),'_',num2str(ccc)], 'Trend')



end

% pause

%% next step
auto_esn


theend=toc;
theend;
t_required=theend/60;
t_required
