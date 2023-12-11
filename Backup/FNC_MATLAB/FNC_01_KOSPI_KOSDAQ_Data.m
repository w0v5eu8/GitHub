clearvars;

%% KRX(KOSPI KOSDAQ) Data Collection
% �ֽ� ��ü����Ʈ �� ���� PER/PBR �� : http://marketdata.krx.co.kr/mdi#document=13020401
% �ֽ� ���ں� �ü�: http://marketdata.krx.co.kr/mdi#document=040204
% �ֽ� ���ں� �ü� �������� ���ϳ� ������ ���� �ð� �� ������ ���� ���̺�� �����ְ�
% �� ���̺��� ���������� �����͸� ����. ���� ���� ���̺��� �ð��Ѿ� ���� �ȳ���.
% ���� ���� 12�ð� ���� �Ŀ� ũ�Ѹ� �ؾ� ���� �����͸� ��Ȯ�ϰ� ���� �� ����.

%% ������ ���� üũ �� �ʱ�ȭ
% ������ ���� mat �� �ֳ� üũ�ϰ� ���� ��� ó�� ũ�Ѹ� �ϴ� ���̹Ƿ� KRX ������ setting
if exist('../../DATA/FNC/KRX.mat','file')
    load('../../DATA/FNC/KRX.mat');
    for i=1:length(KRX)
        KRX(i).Update=0;
    end
else
    KRX.full_code=[];
    KRX.shrot_code=[];
    KRX.codeName=[];
    KRX.marketName=[];
    KRX.Update=[];
    KRX.Date1=[];
    KRX.manageFlag=[];
    KRX.EPS=[];
    KRX.PER=[];
    KRX.BPS=[];
    KRX.PBR=[];
    KRX.DPS=[];
    KRX.DYR=[];
    KRX.Date=[];
    KRX.Close=[];
    KRX.Volume=[];
    KRX.vPrice=[];
    KRX.Open=[];
    KRX.High=[];
    KRX.Low=[];
    KRX.Price=[]; % �ð� �Ѿ�
    KRX.fShare=[];
end

%% ���� KOSPI, KOSDAQ ���� ���� �����ڵ� �ҷ�����
% krx Ȩ������ �ڵ� �м� ĸ�� ���� (ũ�ҿ��� F12 ������ Network ��Ŷ �м�)
options = weboptions('Timeout',Inf);
flag=1;
while flag==1
    try
        krx_code=webread('http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx', ...
            'bld','COM/finder_stkisu', ...
            'name','form', ...
            options);
        flag=0;
    catch
        fprintf('re try webread\n');
        flag=1;
    end
end
options = weboptions('RequestMethod','post','Timeout',Inf, ...
    'HeaderFields', {'Referer' 'http://marketdata.krx.co.kr/mdi'; ...
    'User-Agent' '"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit 537.36 (KHTML, like Gecko) Chrome'});
flag=1;
while flag==1
    try
        temp=webread('http://marketdata.krx.co.kr/contents/MKD/99/MKD99000001.jspx', ...
            'pagePath','/contents/COM/FinderStkIsu.jsp',...
            'mktsel','ALL', ...
            'no','P1', ...
            'code',krx_code,...
            'pageFirstCall', 'Y', ...
            options);
        flag=0;
    catch
        fprintf('re try webread\n');
        flag=1;
    end
end
temp=jsondecode(temp);
temp_list=temp.block1;

fprintf('KOSPI KOSDAQ list done.\n');

%% ����� ����(temp_list)���� KRX�� ������� ������Ʈ
for i=1:length(temp_list)
    
    %% ũ�Ѹ� �� setting
    % temp_list�� �ִ� �ֽ��� KRX�� ���° index���� ã��.
    % KRX�� �ִ� ���  stock_exist�� 1, stock_index�� KRX�� index ��ȣ
    % KRX���� �ű� ����� �ֽ��̸� stock_exist�� 0, stock_index�� KRX�� length + 1
    stock_exist=0;
    for stock_index=1:length(KRX)
        if(strcmp(temp_list(i).full_code,KRX(stock_index).full_code))
            stock_exist=1;
            break;
        end
    end
    if (stock_exist == 0)
        if isempty(KRX(1).codeName)
            stock_index = 1;
        else
            stock_index=length(KRX)+1;
        end
    end
    
    % ���� ����� �����̸� Update�� 1�� ����
    KRX(stock_index).Update=1;
    
    % fromdate��  �����ϴ� ��������  ������ ��+1, �ű� ����� �����̸� 19700101�� ����,
    % todate�� ũ�Ѹ� ���� ����(����)
    % KRX�� ��¥ �����ʹ� double�� yyyymmdd �������� ����Ǿ� ����
    % krx�� (���� PER/PBR �� ������)�� (�ֽ� ���ں� �ü� ������)�� ���� �Ⱓ ������ ���� �ٸ�.
    % ���� date1, date �ΰ��� �.
    % ����Ÿ�� ���� �Ⱓ�� ����. empty���� üũ �ʿ�.
    if (stock_exist)
        if isempty(KRX(stock_index).Date1) == 0
            fromdate1=datestr(datenum(num2str(KRX(stock_index).Date1(length(KRX(stock_index).Date1))),...
                'yyyymmdd')+1,'yyyymmdd');
        end
        if isempty(KRX(stock_index).Date) == 0
            fromdate=datestr(datenum(num2str(KRX(stock_index).Date(length(KRX(stock_index).Date))),...
                'yyyymmdd')+1,'yyyymmdd');
        end
    else
        fromdate1='19700101';
        fromdate='19700101';
    end
    todate=datestr(now-1,'yyyymmdd');
    
    % �ҷ��� ���� ���� id ����
    isu_cd = temp_list(i).full_code;
    isu_srt_cd = temp_list(i).short_code;
    
    %% ���� PER/PBR �� ũ�Ѹ�: http://marketdata.krx.co.kr/mdi#document=13020401
    if datenum(fromdate1,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        options = weboptions('Timeout',Inf);
        flag=1;
        while flag==1
            try
                krx_code=webread('http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx', ...
                    'bld','MKD/13/1302/13020401/mkd13020401', ...
                    'name','chart', ...
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
                    'market_gubun','ALL', ...
                    'isu_cd',isu_cd, ...
                    'isu_srt_cd',isu_srt_cd, ...
                    'fromdate',fromdate1, ...
                    'todate',todate, ...
                    'pagePath','/contents/MKD/13/1302/13020401/MKD13020401.jsp', ...
                    'code',krx_code, ...
                    options);
                flag=0;
            catch
                fprintf('re try webread\n');
                flag=1;
            end
        end
        temp=jsondecode(temp);
        temp_data1=temp.result;
    else
        fprintf('Warning: KRX %d / %d - %s fromdate1 Pass.\n',i, length(temp_list), temp_list(i).codeName);
    end
    
    %% �ֽ� ���ں� �ü� ũ�Ѹ�: http://marketdata.krx.co.kr/mdi#document=040204
    if datenum(fromdate,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        options = weboptions('Timeout',Inf);
        flag=1;
        while flag==1
            try
                krx_code=webread('http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx', ...
                    'bld','MKD/13/1302/13020103/mkd13020103_02', ...
                    'name','chart', ...
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
                    'isu_cd',isu_cd, ...
                    'isu_srt_cd',isu_srt_cd, ...
                    'fromdate',fromdate, ...
                    'todate',todate, ...
                    'pagePath','/contents/MKD/04/0402/04020100/MKD04020100T3T2.jsp', ...
                    'code',krx_code, ...
                    options);
                flag=0;
            catch
                fprintf('re try webread\n');
                flag=1;
            end
        end
        temp=jsondecode(temp);
        temp_data2=temp.block1;
    else
        fprintf('Warning: KRX  %d / %d - %s fromdate Pass.\n',i, length(temp_list), temp_list(i).codeName);
    end
    
    %% ũ�Ѹ� ������ KRX�� ������Ʈ
    KRX(stock_index).full_code=temp_list(i).full_code; % ���� full �ڵ�
    KRX(stock_index).shrot_code=temp_list(i).short_code; % ���� short �ڵ�
    KRX(stock_index).codeName=temp_list(i).codeName; % �����
    KRX(stock_index).marketName=temp_list(i).marketName; % KOSPI or KOSDAQ
    
    if datenum(fromdate1,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        if isempty(temp_data1) == 0 % ũ�Ѹ��� �����Ͱ� ������ pass
            KRX(stock_index).Date1=[KRX(stock_index).Date1; ...
                str2num(datestr(datenum(flip({temp_data1.work_dt}.'),'yyyy/mm/dd'),'yyyymmdd'))]; % �����
            KRX(stock_index).manageFlag=[KRX(stock_index).manageFlag; ...
                strcmp(flip({temp_data1.iisu_code}.'),'-')]; % ��������
            KRX(stock_index).EPS=[KRX(stock_index).EPS; ...
                str2double(flip({temp_data1.prv_eps}.'))]; % EPS
            KRX(stock_index).PER=[KRX(stock_index).PER; ...
                str2double(flip({temp_data1.per}.'))]; % PER
            KRX(stock_index).BPS=[KRX(stock_index).BPS; ...
                str2double(flip({temp_data1.bps}.'))]; % BPS
            KRX(stock_index).PBR=[KRX(stock_index).PBR; ...
                str2double(flip({temp_data1.pbr}.'))]; % PBR
            KRX(stock_index).DPS=[KRX(stock_index).DPS; ...
                str2double(flip({temp_data1.stk_dvd}.'))]; % �ִ����
            KRX(stock_index).DYR=[KRX(stock_index).DYR; ...
                str2double(flip({temp_data1.dvd_yld}.'))]; % �����ͷ�
        else
            fprintf('Warning: KRX  %d / %d - %s Data1 empty.\n',i, length(temp_list), temp_list(i).codeName);
        end
    end
    if datenum(fromdate,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        if isempty(temp_data2) == 0 % ũ�Ѹ��� �����Ͱ� ������ pass
            KRX(stock_index).Date=[KRX(stock_index).Date; ...
                str2num(datestr(datenum(flip({temp_data2.trd_dd}.'),'yyyy/mm/dd'),'yyyymmdd'))]; % �����
            KRX(stock_index).Close=[KRX(stock_index).Close; ...
                str2double(flip({temp_data2.tdd_clsprc}.'))]; % ����
            KRX(stock_index).Volume=[KRX(stock_index).Volume; ...
                str2double(flip({temp_data2.acc_trdvol}.'))]; % �ŷ���
            KRX(stock_index).vPrice=[KRX(stock_index).vPrice; ...
                str2double(flip({temp_data2.acc_trdval}.'))]; % �ŷ����
            KRX(stock_index).Open=[KRX(stock_index).Open; ...
                str2double(flip({temp_data2.tdd_opnprc}.'))]; % �ð�
            KRX(stock_index).High=[KRX(stock_index).High; ...
                str2double(flip({temp_data2.tdd_hgprc}.'))]; % ��
            KRX(stock_index).Low=[KRX(stock_index).Low; ...
                str2double(flip({temp_data2.tdd_lwprc}.'))]; % ����
            KRX(stock_index).Price=[KRX(stock_index).Price; ...
                str2double(flip({temp_data2.mktcap}.'))]; % �ð��Ѿ�(�鸸)
            KRX(stock_index).fShare=[KRX(stock_index).fShare; ...
                str2double(flip({temp_data2.list_shrs}.'))]; % �����ֽļ�
        else
            fprintf('Warning: KRX  %d / %d - %s Data2 empty.\n',i, length(temp_list), temp_list(i).codeName);
        end
    end
    
    %% NaN Check
    if sum(isnan(KRX(stock_index).Price)) > 0
        fprintf('Warning: KRX  %d / %d - %s NaN\n',i, length(temp_list), temp_list(i).codeName);
        for nan_i=1:length(KRX(stock_index).Price)
            if isnan(KRX(stock_index).Price(nan_i)) == 1
                fprintf('Warning: KRX %d / %d - %s NaN Adjust index = %d\n',i, length(temp_list), temp_list(i).codeName, nan_i);
                if nan_i == 1
                    KRX(stock_index).Price(nan_i) = 0;
                else
                    KRX(stock_index).Price(nan_i) = KRX(stock_index).Price(nan_i-1);
                end
            end
        end
    end
    
    fprintf('KRX: %d / %d - %s Done.\n',i, length(temp_list), temp_list(i).codeName);
end

%% Save
save('../../DATA/FNC/KRX.mat','KRX');
fprintf('FNC_01_KOSPI_KOSDAQ_Data Done.\n');