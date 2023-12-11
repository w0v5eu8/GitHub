clearvars;

%% SP500 Data Collection
% �ؿ� �ֽ� ������ collection
% �ε���: S&P 500 (^GSPC), NASDAQ Composite (^IXIC), Dow Jones Industrial Average (^DJI)
% ����: S&P 500�� ���ϴ� ����
% ���񸮽�Ʈ: https://en.m.wikipedia.org/wiki/List_of_S%26P_500_companies
% ������: https://finance.yahoo.com/

%% ������ ���� üũ �� �ʱ�ȭ
% ������ ���� mat �� �ֳ� üũ�ϰ� ���� ��� ó�� ũ�Ѹ� �ϴ� ���̹Ƿ� ETF ������ setting
if exist('../../DATA/FNC/SP500.mat','file')
    load('../../DATA/FNC/SP500.mat');
    for i=1:length(SP500)
        SP500(i).Update=0;
    end
else
    SP500.codeName=[];
    SP500.Update=[];
    SP500.Date=[];
    SP500.Price=[];
    SP500.Volume=[];
    SP500.Close=[];
    SP500.Open=[];
    SP500.High=[];
    SP500.Low=[];
end

%% Symbol ����Ʈ ����
options = weboptions('Timeout',Inf);
flag=1;
while flag==1
    try
        str=webread('https://en.m.wikipedia.org/wiki/List_of_S&P_500_companies',options);
        flag=0;
    catch
        fprintf('re try webread\n');
        flag=1;
    end
end

% ��Ű ������ �Ľ�
str_all=[];
str_all=[str_all strfind(str,'XNYS:')];
str_all=[str_all strfind(str,'mbol/')];
str_all=[str_all strfind(str,'bols/')];

SP500_list(1).Symbol='^GSPC'; % S&P 500
SP500_list(2).Symbol='^IXIC'; % NASDAQ
SP500_list(3).Symbol='^DJI'; % DOW JONES

% ��Ű ������ �Ľ�
for i=1:length(str_all)
    temp_str=sprintf('%s',str(str_all(i)+5:str_all(i)+15));
    str_i=strfind(temp_str,'"');
    complete_str=sprintf('%s',temp_str(1:str_i-1));
    complete_str=upper(complete_str);
    complete_str(strfind(complete_str,'.'))='-';
    SP500_list(3+i).Symbol=complete_str;
end
fprintf('SP500 list done.\n');

%% World_List ������� ������Ʈ
for i=1:length(SP500_list)
    
    %% ũ�Ѹ� �� setting
    % SP500_list�� �ִ� �ֽ��� SP500�� ���° index���� ã��.
    % SP500�� �ִ� ���  stock_exist�� 1, stock_index�� SP500�� index ��ȣ
    % SP500���� �ű� ����� �ֽ��̸� stock_exist�� 0, stock_index�� SP500�� length+1
    stock_exist=0;
    for stock_index=1:length(SP500)
        if(strcmp(SP500_list(i).Symbol,SP500(stock_index).codeName))
            stock_exist=1;
            break;
        end
    end
    if (stock_exist == 0)
        if isempty(SP500(1).codeName)
            stock_index = 1;
        else
            stock_index=length(SP500)+1;
        end
    end
    
    % ���� ����� �����̸� Update�� 1�� ����
    SP500(stock_index).Update=1;
    
    % yahoo ũ�Ѹ� �ڵ�� �����ϸ� �����ϸ� �ֽŵ����ͱ��� ũ�Ѹ� ��.
    % FNC_01_SP500_yahoo_Data_Replace.m�� % ���� �ְ� �ݿ��� ���ؼ� ��ü �����͸� ���� �޾� ��.
    % ���� fromdate�� 19000101�� ����,
    % SP500�� ��¥ �����ʹ� double�� yyyymmdd �������� ����Ǿ� ����
    % ����Ÿ�� ���� �Ⱓ�� ����. empty���� üũ �ʿ�.
    
    fromdate='01011900';
    todate=datestr(now,'ddmmyyyy');
    % �ҷ��� SP500 �ɺ� ����
    symbol= SP500_list(i).Symbol;
    
    %% SP500 ���� ũ�Ѹ�
    % fromdate�� todate (now) ���� �޳��̸� pass
    if datenum(fromdate,'ddmmyyyy') <= datenum(todate,'ddmmyyyy')
        options = weboptions('Timeout',Inf);
        flag=1;
        while flag==1
            try
                Temp=FNC_Func_yahoo(fromdate, todate, symbol);
                flag=0;
            catch
                fprintf('re try webread\n');
                flag=1;
            end
        end
    else
        fprintf('Warninig: SP500 %d / %d - %s fromdate Pass.\n',i, length(SP500_list), SP500_list(i).Symbol);
    end
    
    %% ũ�Ѹ� ������ SP500�� ������Ʈ
    SP500(stock_index).codeName=SP500_list(i).Symbol;
    
    if datenum(fromdate,'ddmmyyyy') <= now % fromdate�� todate ���� �޳��̸� pass
        if isempty(Temp) == 0 % ũ�Ѹ��� �����Ͱ� ������ pass
            SP500(stock_index).Date=[str2num(datestr(datenum(cellstr(Temp.Date),'yyyy-mm-dd'),'yyyymmdd'))]; % �����
            SP500(stock_index).Close=[Temp.Close]; % ����
            SP500(stock_index).Open=[Temp.Open]; % �ð�
            SP500(stock_index).High=[Temp.High]; % ��
            SP500(stock_index).Low=[Temp.Low]; % ����
            SP500(stock_index).Volume=[Temp.Volume]; % �ŷ���
            SP500(stock_index).Price=[Temp.AdjClose]; % ���� ����
        else
            fprintf('Warninig: SP500 %d / %d - %s Data empty.\n',i, length(SP500_list), SP500_list(i).Symbol);
        end
    end
    
    %% NaN Check
    if sum(isnan(SP500(stock_index).Price)) > 0
        fprintf('Warninig: SP500 %d / %d - %s NaN\n',i, length(SP500_list), SP500_list(i).Symbol);
        for nan_i=1:length(SP500(stock_index).Price)
            if isnan(SP500(stock_index).Price(nan_i)) == 1
                fprintf('Warninig: SP500 %d / %d - %s NaN Adjust index = %d\n',i, length(SP500_list), SP500_list(i).Symbol, nan_i);
                if nan_i == 1
                    SP500(stock_index).Price(nan_i) = 0;
                else
                    SP500(stock_index).Price(nan_i) = SP500(stock_index).Price(nan_i-1);
                end
            end
        end
    end
    
    fprintf('SP500: %d / %d - %s Done.\n',i, length(SP500_list), SP500_list(i).Symbol);
end

%% Save
save('../../DATA/FNC/SP500.mat','SP500');
fprintf('FNC_01_SP500 Done.\n');