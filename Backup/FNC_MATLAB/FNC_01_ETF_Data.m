clearvars;

%% ETF Data Collection
% ETF ��ü����Ʈ: http://marketdata.krx.co.kr/mdi#document=13040101
% ETF ����: http://marketdata.krx.co.kr/mdi#document=08010203

%% ������ ���� üũ �� �ʱ�ȭ
% ������ ���� mat �� �ֳ� üũ�ϰ� ���� ��� ó�� ũ�Ѹ� �ϴ� ���̹Ƿ� ETF ������ setting
if exist('../../DATA/FNC/ETF.mat','file')
    load('../../DATA/FNC/ETF.mat');
    for i=1:length(ETF)
        ETF(i).Update=0;
    end
else
    ETF.full_code=[];
    ETF.shrot_code=[];
    ETF.codeName=[];
    ETF.Update=[];
    ETF.Date=[];
    ETF.Price=[]; % ����
    ETF.NAV=[];
    ETF.Basic=[];
    ETF.Volume=[];
    ETF.vPrice=[];
    ETF.Open=[];
    ETF.High=[];
    ETF.Low=[];
end

%% ���� ETF ���� ���� �����ڵ� �ҷ�����
options = weboptions('Timeout',Inf);
flag=1;
while flag==1
    try
        etf_code=webread('http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx', ...
            'bld','MKD/13/1304/13040101/mkd13040101', ...
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
            'pagePath','/contents/MKD/13/1304/13040101/MKD13040101.jsp',...
            'domforn','00', ...
            'uly_gubun','00', ...
            'gubun','00',...
            'fromdate',datestr(now-30,'yyyymmdd'), ...
            'todate',datestr(now,'yyyymmdd'), ...
            'isu_cd','ALL', ...
            'code',etf_code,...
            options);
        flag=0;
    catch
        fprintf('re try webread\n');
        flag=1;
    end
end
temp=jsondecode(temp);
temp_list=temp.block1;

fprintf('ETF list done.\n');

%% ����� ����(temp_list)���� ETF�� ������� ������Ʈ
for i=1:length(temp_list)
    
    %% ũ�Ѹ� �� setting
    % temp_list�� �ִ� �ֽ��� ETF�� ���° index���� ã��.
    % ETF�� �ִ� ���  stock_exist�� 1, stock_index�� ETF�� index ��ȣ
    % ETF���� �ű� ����� �ֽ��̸� stock_exist�� 0, stock_index�� ETF�� length+1
    stock_exist=0;
    for stock_index=1:length(ETF)
        if(strcmp(temp_list(i).isu_kor_abbrv,ETF(stock_index).codeName))
            stock_exist=1;
            break;
        end
    end
    if (stock_exist == 0)
        if isempty(ETF(1).codeName)
            stock_index = 1;
        else
            stock_index=length(ETF)+1;
        end
    end
    
    % ���� ����� �����̸� Update�� 1�� ����
    ETF(stock_index).Update=1;
    
    % fromdate��  �����ϴ� ��������  ������ ��+1, �ű� ����� �����̸� 19700101�� ����,
    % todate�� ũ�Ѹ� ���� ����(����)
    % ETF�� ��¥ �����ʹ� double�� yyyymmdd �������� ����Ǿ� ����
    % ����Ÿ�� ���� �Ⱓ�� ����. empty���� üũ �ʿ�.
    if (stock_exist)
        if isempty(ETF(stock_index).Date) == 0
            fromdate=datestr(datenum(num2str(ETF(stock_index).Date(length(ETF(stock_index).Date))),...
                'yyyymmdd')+1,'yyyymmdd');
        end
    else
        fromdate='19700101';
    end
    todate=datestr(now-1,'yyyymmdd');
    
    % �ҷ��� ETF id ����
    isu_cd = temp_list(i).isu_cd;
    
    %% ETF ���� ũ�Ѹ�: http://marketdata.krx.co.kr/mdi#document=08010203
    if datenum(fromdate,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        options = weboptions('Timeout',Inf);
        flag=1;
        while flag==1
            try
                etf_code=webread('http://marketdata.krx.co.kr/contents/COM/GenerateOTP.jspx', ...
                    'bld','MKD/08/0801/08010700/mkd08010700_04', ...
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
                    'mkt','ETF', ...
                    'domforn','00', ...
                    'uly_gubun','00', ...
                    'gubun','00', ...
                    'isu_cd',isu_cd, ...
                    'isu_srt_cd',isu_cd, ...
                    'fromdate',fromdate, ...
                    'todate',todate, ...
                    'gubun2','2', ...
                    'pagePath','/contents/MKD/08/0801/08010700/MKD08010700.jsp', ...
                    'code',etf_code, ...
                    options);
                flag=0;
            catch
                fprintf('re try webread\n');
                flag=1;
            end
        end
        temp=jsondecode(temp);
        temp_data=temp.block1;
    else
        fprintf('Warninig: ETF %d / %d - %s fromdate Pass.\n',i, length(temp_list), temp_list(i).isu_kor_abbrv);
    end
    
    %% ũ�Ѹ� ������ ETF�� ������Ʈ
    ETF(stock_index).full_code=temp_list(i).isu_cd; % ���� full �ڵ�
    ETF(stock_index).shrot_code=temp_list(i).isu_srt_cd; % ���� short �ڵ�
    ETF(stock_index).codeName=temp_list(i).isu_kor_abbrv; % �����
    
    if datenum(fromdate,'yyyymmdd') <= datenum(todate,'yyyymmdd') % fromdate�� todate ���� �޳��̸� pass
        if isempty(temp_data) == 0 % ũ�Ѹ��� �����Ͱ� ������ pass
            ETF(stock_index).Date=[ETF(stock_index).Date; ...
                str2num(datestr(datenum(flip({temp_data.work_dt}.'),'yyyy/mm/dd'),'yyyymmdd'))]; % �����
            ETF(stock_index).Price=[ETF(stock_index).Price; ...
                str2double(flip({temp_data.isu_end_pr}.'))]; % ����
            ETF(stock_index).NAV=[ETF(stock_index).NAV; ...
                str2double(flip({temp_data.last_nav}.'))]; % NAV
            ETF(stock_index).Basic=[ETF(stock_index).Basic; ...
                str2double(flip({temp_data.last_indx}.'))]; % ��������
            ETF(stock_index).Volume=[ETF(stock_index).Volume; ...
                str2double(flip({temp_data.tot_tr_vl}.'))]; % �ŷ���(��)
            ETF(stock_index).vPrice=[ETF(stock_index).vPrice; ...
                str2double(flip({temp_data.tot_tr_amt}.'))]; % �ŷ����(�鸸��)
            ETF(stock_index).Open=[ETF(stock_index).Open; ...
                str2double(flip({temp_data.isu_opn_pr}.'))]; % �ð�
            ETF(stock_index).High=[ETF(stock_index).High; ...
                str2double(flip({temp_data.isu_hg_pr}.'))]; % ��
            ETF(stock_index).Low=[ETF(stock_index).Low; ...
                str2double(flip({temp_data.isu_lw_pr}.'))]; % ����
        else
            fprintf('Warninig: ETF %d / %d - %s Data empty.\n',i, length(temp_list), temp_list(i).isu_kor_abbrv);
        end
    end
    
    %% NaN Check
    if sum(isnan(ETF(stock_index).Price)) > 0
        fprintf('Warninig: ETF %d / %d - %s NaN\n',i, length(temp_list), temp_list(i).isu_kor_abbrv);
        for nan_i=1:length(ETF(stock_index).Price)
            if isnan(ETF(stock_index).Price(nan_i)) == 1
                fprintf('Warninig: ETF %d / %d - %s NaN Adjust index = %d\n',i, length(temp_list), temp_list(i).isu_kor_abbrv, nan_i);
                if nan_i == 1
                    ETF(stock_index).Price(nan_i) = 0;
                else
                    ETF(stock_index).Price(nan_i) = ETF(stock_index).Price(nan_i-1);
                end
            end
        end
    end
    
    fprintf('ETF: %d / %d - %s Done.\n',i, length(temp_list), temp_list(i).isu_kor_abbrv);
end

%% Save
save('../../DATA/FNC/ETF.mat','ETF');
fprintf('FNC_01_ETF Done.\n');