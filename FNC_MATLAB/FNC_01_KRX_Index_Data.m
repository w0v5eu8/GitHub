clearvars;

%% KRX index collection
% KOSPI:    http://marketdata.krx.co.kr/mdi#document=030402
% KOSPI200: http://marketdata.krx.co.kr/mdi#document=030402
% KOSDAQ:   http://marketdata.krx.co.kr/mdi#document=030403

%% ������ ���� üũ �� �ʱ�ȭ
% ������ ���� mat �� �ֳ� üũ�ϰ� ���� ��� ó�� ũ�Ѹ� �ϴ� ���̹Ƿ� ETF ������ setting
if exist('../../DATA/FNC/KRX_Index.mat','file')
    load('../../DATA/FNC/KRX_Index.mat');
else
    KRX_Index(1).codeName='KOSPI';
    KRX_Index(1).Date=[];
    KRX_Index(1).Price=[];
    KRX_Index(2).codeName='KOSPI200';
    KRX_Index(2).Date=[];
    KRX_Index(2).Price=[];
    KRX_Index(3).codeName='KOSDAQ';
    KRX_Index(3).Date=[];
    KRX_Index(3).Price=[];
end

%% Index ������Ʈ
for i=1:3
    
    %% ũ�Ѹ� �� setting
    % index�� �´� id���� ����
    if i==1 % KOSPI
        idx_cd = '1001';
        ind_tp_cd = '1';
        idx_ind_cd = '001';
    elseif i==2 % KOSPI200
        idx_cd = '1028';
        ind_tp_cd = '1';
        idx_ind_cd = '028';
    elseif i==3 % KOSDAQ
        idx_cd = '2001';
        ind_tp_cd = '2';
        idx_ind_cd = '001';
    end
    
    % crawling date ����
    if isempty(KRX_Index(i).Date)
        fromdate='19700101';
    else
        fromdate=datestr(datenum(num2str(KRX_Index(i).Date(length(KRX_Index(i).Date))),...
            'yyyymmdd')+1,'yyyymmdd');
    end
    todate=datestr(now-1,'yyyymmdd');
    
    fprintf('KRX_Index: %s Index Crawling Setting Done.\n', KRX_Index(i).codeName);
    
    %% ���� Crawling
    if datenum(fromdate,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        options = weboptions('Timeout',Inf);
        flag=1;
        while flag==1
            try
                krx_code=webread('http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx', ...
                    'bld','MKD/03/0304/03040101/mkd03040101T2_02', ...
                    'name','form', ...
                    options);
                flag=0;
            catch
                fprintf('re try webread\n');
                flag=1;
            end
        end
        options = weboptions('RequestMethod','post','Timeout',Inf, ...
            'HeaderFields', {'Referer' 'http://marketdata.krx.co.kr/mdi'});
        flag=1;
        while flag==1
            try
                temp=webread('http://marketdata.krx.co.kr/contents/MKD/99/MKD99000001.jspx', ...
                    'idx_cd',idx_cd,...
                    'ind_tp_cd',ind_tp_cd, ...
                    'idx_ind_cd',idx_ind_cd, ...
                    'fromdate',fromdate,...
                    'todate', todate, ...
                    'pagePath','/contents/MKD/03/0304/03040101/MKD03040101T2.jsp', ...
                    'code',krx_code, ...
                    options);
                flag=0;
            catch
                fprintf('re try webread\n');
                flag=1;
            end
        end
        temp=jsondecode(temp);
        temp_data=temp.output;
    else
        fprintf('Warning: %s Index fromdate Pass.\n', KRX_Index(i).codeName);
    end
    
    %% KRX_Index ������Ʈ
    if datenum(fromdate,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        if isempty(temp_data) == 0 % ũ�Ѹ��� �����Ͱ� ������ pass
            KRX_Index(i).Date=[KRX_Index(i).Date; ...
                str2num(datestr(datenum({temp_data.trd_dd}.','yyyy/mm/dd'),'yyyymmdd'))]; % �����
            KRX_Index(i).Price=[KRX_Index(i).Price; ...
                str2double({temp_data.clsprc_idx}.')]; % ����
        else
            fprintf('Warning: %s Data empty.\n', KRX_Index(i).codeName);
        end
    end
    
    %% NaN Check
    if sum(isnan(KRX_Index(i).Price)) > 0
        fprintf('Warning: %s Index NaN\n', KRX_Index(i).codeName);
        for nan_i=1:length(KRX_Index(i).Price)
            if isnan(KRX_Index(i).Price(nan_i)) == 1
                fprintf('Warning: %s Index, %d NaN Adjust',KRX_Index(i).codeName, nan_i);
                if nan_i == 1
                    KRX_Index(i).Price(nan_i) = 0;
                else
                    KRX_Index(i).Price(nan_i) = KRX_Index(i).Price(nan_i-1);
                end
            end
        end
    end
    
    fprintf('KRX_Index: %s Index Done.\n', KRX_Index(i).codeName);
end

%% Save
save('../../DATA/FNC/KRX_Index.mat','KRX_Index');
fprintf('FNC_01_KRX_Index_Data Done.\n');