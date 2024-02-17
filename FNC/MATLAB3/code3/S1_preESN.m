%%

md = 1000;
simt = md-246; % initializing �� �ǹ̴�???
   
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
        Trend(i_trend) = 0; % ������ ����, ���ϰ��� ������ 0

        
    elseif  rscm(i_trend) > rscm(i_trend - 2) && ...
            rscm(i_trend) > rscm(i_trend - 1) && ...
            rscm(i_trend) > rscm(i_trend + 1) && ...
            rscm(i_trend) > rscm(i_trend + 2) 
        Trend(i_trend) = +1; % �������� ����, �������� ����, ���Ϻ��� ����, �𷡺��� ������ SELL
    elseif  rscm(i_trend) < rscm(i_trend - 2) && ...
            rscm(i_trend) < rscm(i_trend - 1) && ...
            rscm(i_trend) < rscm(i_trend + 1) && ...
            rscm(i_trend) < rscm(i_trend + 2)
        Trend(i_trend) = -1; % �������� ����, �������� ����, ���Ϻ��� ����, �𷡺��� ������ BUY

    elseif  rscm(i_trend) >  rscm(i_trend - 2) && ...
            rscm(i_trend) >  rscm(i_trend - 1) && ...
            rscm(i_trend) <  rscm(i_trend + 1) && ...
            rscm(i_trend) <  rscm(i_trend + 2)
        Trend(i_trend) = -1; % �������� ����, �������� ����, ���Ϻ��� ����, �𷡺��� ������ BUY
    elseif  rscm(i_trend) <  rscm(i_trend - 2) && ...
            rscm(i_trend) <  rscm(i_trend - 1) && ...
            rscm(i_trend) >  rscm(i_trend + 1) && ...
            rscm(i_trend) >  rscm(i_trend + 2)
        Trend(i_trend) = +1; % �������� ����, �������� ����, ���Ϻ��� ����, �𷡺��� ������ SELL
   
    end
end
Trend_ch = Trend;
% ������ ���� ���ݰ� ���ϱ� ������ ó���� ������ �� ���� ������ 0�� ��
% ����, ����, ���� ������ �� ������ ���� Trend ���� 0���� ó��
% --> ������ ������ ������ ���ϰ��� �ٸ���?
% ���� ����� ���� ����� ������� �ʾ���! --> ���� �Ϸ�
% -1�̳� +1�� �����ؼ� ������ ���(���������� ���� ���) ó�� ��ȣ�� ����
% ����: �ٷ� ���� ��ȣ�� ���� ���� teacher ��ȣ�� ���� ���� �´°�?
% ���ü��� �ŷڼ��� ����
% �ŷڼ��� ���� ������ �� ġ������ �� �ִ� ?

Trend_m1 = find(abs(Trend)==1); % ��ȣ�� �ִ� ��¥�鸸 ȣ��
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
% ��ȣ�� �ִ� ��¥���� ������ Trend_T �̳��̰�,
% ���ÿ� ���� �������� ��հ� ��� ����ġ(Trend_P) ������ ��쿣 �� ��ȣ�� ��� ���� (0���� ����)

Trend_m3 = find(abs(Trend)==1);
for i4_trend = 2 : (size(Trend_m3,1) - 0)
    
    mv = (Trend_m3(i4_trend) - Trend_m3(i4_trend - 1)); % �غ�
    
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
% �� �߱�

Trend_m4 = find(abs(Trend)==1, 1, 'last');
if Trend_m4 < md - 1
    Trend(Trend_m4+1:md) = 0;
end
% ������ signal ���� ���ñ����� 0���� ���� (�� �߱� ������)


buy=zeros(1000,1); sell=zeros(1000,1);
for ii = 1:1000
    if (Trend(ii)) == 1
        buy(ii) = 1;
    elseif (Trend(ii)) == -1
        sell(ii) = 1;
    end
end

