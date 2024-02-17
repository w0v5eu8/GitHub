%% Sometimes stop during buffering (loading URL)
%% Code URL : IMPORTANT "Check the number of URL pages"
% KOSPI:http://finance.naver.com/sise/sise_market_sum.nhn?sosok=0&page=1 ~
% KOSPI200: http://finance.naver.com/sise/entryJongmok.nhn?&page=1 ~
% KOSDAQ: http://finance.naver.com/sise/sise_market_sum.nhn?sosok=1&page=1 ~
% Management: http://finance.naver.com/sise/management.nhn
% Trading Halt: http://finance.naver.com/sise/trading_halt.nhn
% Caution: http://finance.naver.com/sise/investment_alert.nhn?type=caution
% Warning: http://finance.naver.com/sise/investment_alert.nhn?type=warning
% Risk: http://finance.naver.com/sise/investment_alert.nhn?type=risk
% ETF: http://finance.naver.com/api/sise/etfItemList.nhn

%% clear
close all;
clear all;
clc;
fprintf('Finance_01_DATA_Init_fromNAVER - Start\n');

%% Init Setting
KOSPI(1).Ticker=sprintf('KOSPI'); % KOSPI index
KOSPI(1).Name=sprintf('KOSPI');
KOSPI(1).K=1;
KOSPI(1).PBR=100;
KOSPI(1).Normal=1;
KOSPI(1).Update=1;
KOSPI(1).Date=[];
KOSPI(1).Open=[];
KOSPI(1).High=[];
KOSPI(1).Low=[];
KOSPI(1).Close=[];
KOSPI(1).Volume=[];

KOSPI(2).Ticker=sprintf('KOSDAQ'); % KOSDAQ index
KOSPI(2).Name=sprintf('KOSDAQ');
KOSPI(2).K=0;
KOSPI(2).PBR=100;
KOSPI(2).Normal=1;
KOSPI(2).Update=1;
KOSPI(2).Date=[];
KOSPI(2).Open=[];
KOSPI(2).High=[];
KOSPI(2).Low=[];
KOSPI(2).Close=[];
KOSPI(2).Volume=[];

KOSPI_i=2;
KOSDAQ_i=0;

fprintf('Init Setting Done.\n');

%% Page Check
% KOSPI
KOSPI_url_i=0;
codes=[1];
while(isempty(codes)==0)
    KOSPI_url_i=KOSPI_url_i+1;
    fullURL = sprintf('https://finance.naver.com/sise/sise_market_sum.nhn?&page=%d',KOSPI_url_i);
    str = urlread(fullURL);
    codes=strfind(str, '<a href="/item/main.nhn?code=');
end
KOSPI_url_i = KOSPI_url_i-1;

% KOSDAQ
KOSDAQ_url_i=0;
codes=[1];
while(isempty(codes)==0)
    KOSDAQ_url_i=KOSDAQ_url_i+1;
    fullURL = sprintf('https://finance.naver.com/sise/sise_market_sum.nhn?sosok=1&page=%d',KOSDAQ_url_i);
    str = urlread(fullURL);
    codes=strfind(str, '<a href="/item/main.nhn?code=');
end
KOSDAQ_url_i = KOSDAQ_url_i-1;

%% KOSPI
for url_i=1:KOSPI_url_i % Check the number of URL pages
    %fprintf('%d\n',url_i); // test
    fullURL = sprintf('https://finance.naver.com/sise/sise_market_sum.nhn?&page=%d',url_i);
    str = urlread(fullURL);
    codes=strfind(str, '<a href="/item/main.nhn?code=');
    for codes_i=1:length(codes)
        KOSPI_i=KOSPI_i+1;
        temp= sprintf('%s',str(codes(codes_i)+29:codes(codes_i)+34));
        KOSPI(KOSPI_i).Ticker=temp;
        for j=1:100
            if str(codes(codes_i)+51+j) == '<'
                break;
            end
        end
        KOSPI(KOSPI_i).Name=sprintf('%s',str(codes(codes_i)+51:codes(codes_i)+51+j-1));
        KOSPI(KOSPI_i).K=1;
        KOSPI(KOSPI_i).PBR=100;
        KOSPI(KOSPI_i).Normal=1;
        KOSPI(KOSPI_i).Update=1;
        KOSPI(KOSPI_i).Date=[];
        KOSPI(KOSPI_i).Open=[];
        KOSPI(KOSPI_i).High=[];
        KOSPI(KOSPI_i).Low=[];
        KOSPI(KOSPI_i).Close=[];
        KOSPI(KOSPI_i).Volume=[];
    end
end
fprintf('KOSPI Done.\n');

%% KOSDAQ
for url_i=1:KOSDAQ_url_i % Check the number of URL pages
    fullURL = sprintf('https://finance.naver.com/sise/sise_market_sum.nhn?sosok=1&page=%d',url_i);
    str = urlread(fullURL);
    codes=strfind(str, '<a href="/item/main.nhn?code=');
    for codes_i=1:length(codes)
        KOSDAQ_i=KOSDAQ_i+1;
        temp= sprintf('%s',str(codes(codes_i)+29:codes(codes_i)+34));
        KOSDAQ(KOSDAQ_i).Ticker=temp;
        for j=1:100
            if str(codes(codes_i)+51+j) == '<'
                break;
            end
        end
        KOSDAQ(KOSDAQ_i).Name=sprintf('%s',str(codes(codes_i)+51:codes(codes_i)+51+j-1));
        KOSDAQ(KOSDAQ_i).K=0;
        KOSDAQ(KOSDAQ_i).PBR=100;
        KOSDAQ(KOSDAQ_i).Normal=1;
        KOSDAQ(KOSDAQ_i).Update=1;
        KOSDAQ(KOSDAQ_i).Date=[];
        KOSDAQ(KOSDAQ_i).Open=[];
        KOSDAQ(KOSDAQ_i).High=[];
        KOSDAQ(KOSDAQ_i).Low=[];
        KOSDAQ(KOSDAQ_i).Close=[];
        KOSDAQ(KOSDAQ_i).Volume=[];
    end
end
fprintf('KOSDAQ Done.\n');

%% Expectional Stocks
fullURL_B{1} = sprintf('https://finance.naver.com/sise/management.nhn?sosok=0');
fullURL_B{2} = sprintf('https://finance.naver.com/sise/trading_halt.nhn?sosok=0');
fullURL_B{3} = sprintf('https://finance.naver.com/sise/investment_alert.nhn?type=caution&sosok=0');
fullURL_B{4} = sprintf('https://finance.naver.com/sise/investment_alert.nhn?type=warning&sosok=0');
fullURL_B{5} = sprintf('https://finance.naver.com/sise/investment_alert.nhn?type=risk&sosok=0');
fullURL_B{6} = sprintf('https://finance.naver.com/sise/management.nhn?sosok=1');
fullURL_B{7} = sprintf('https://finance.naver.com/sise/trading_halt.nhn?sosok=1');
fullURL_B{8} = sprintf('https://finance.naver.com/sise/investment_alert.nhn?type=caution&sosok=1');
fullURL_B{9} = sprintf('https://finance.naver.com/sise/investment_alert.nhn?type=warning&sosok=1');
fullURL_B{10} = sprintf('https://finance.naver.com/sise/investment_alert.nhn?type=risk&sosok=1');

% KOSPI
block_i=1;
for url_i=1:5
    str = urlread(fullURL_B{url_i});
    codes=strfind(str, '<a href="/item/main.nhn?code=');
    for codes_i=1:length(codes)
        KOSPI_block{block_i}= sprintf('%s',str(codes(codes_i)+29:codes(codes_i)+34));
        block_i=block_i+1;
    end
end

% KOSDAQ
block_i=1;
for url_i=6:10
    str = urlread(fullURL_B{url_i});
    codes=strfind(str, '<a href="/item/main.nhn?code=');
    for codes_i=1:length(codes)
        KOSDAQ_block{block_i}= sprintf('%s',str(codes(codes_i)+29:codes(codes_i)+34));
        block_i=block_i+1;
    end
end
fprintf('Expectional Stocks Done.\n');

%% Normal or Abnormal Check
% KOSPI
for i=1:length(KOSPI_block)
    for j=1:length(KOSPI)
        if(strcmp(KOSPI_block{i}, KOSPI(j).Ticker)==1)
            KOSPI(j).Normal = 0;
            fprintf('KOSPI Abnormal %s - %s \n',KOSPI(j).Ticker, KOSPI(j).Name);
            break;
        end
    end
end

for i=1:length(KOSDAQ_block)
    for j=1:length(KOSDAQ)
        if(strcmp(KOSDAQ_block{i}, KOSDAQ(j).Ticker)==1)
            KOSDAQ(j).Normal = 0;
            fprintf('KOSDAQ Abnormal %s - %s \n',KOSDAQ(j).Ticker, KOSDAQ(j).Name);
            break;
        end
    end
end
fprintf('Normal or Abnormal Check Done.\n');

%% KOSPI PBR
for i=3:length(KOSPI)
    % init var
    fullURL=[];
    str=[];
    temp_str=[];
    str_i=[];
    complete_str=[];
    
    Ticker=KOSPI(i).Ticker(length(KOSPI(i).Ticker)-5:length(KOSPI(i).Ticker));
    fullURL = sprintf('http://finance.naver.com/item/main.nhn?code=%s', Ticker);
    
    flag = 1;
    while flag==1
        try
            str=webread(fullURL);
            flag=0;
        catch
            fprintf('re try webread\n');
            flag=1;
        end
    end
    
    % find PBR
    str_i=strfind(str, '<em id="_pbr">');
    if isempty(str_i) == 0 % if there is PBR value
        % read PBR value
        temp_str=sprintf('%s',str(str_i+14:str_i+20)); % read example '<em id="_pbr">1.35</em>น่'
        str_i=strfind(temp_str,'<'); % '<' is next charater of PBR value
        complete_str=sprintf('%s',temp_str(1:str_i-1)); % read before '<'
        temp=str2double(complete_str);
        KOSPI(i).PBR=temp;
    else % if there is no PBR value, probably it is ETF
        KOSPI(i).PBR=100;
    end
    fprintf('%d / %d - %s - %s - KOSPI PBR: %5.2f\n', i, length(KOSPI), KOSPI(i).Ticker, KOSPI(i).Name, KOSPI(i).PBR);
end

%% KOSDAQ PBR
for i=1:length(KOSDAQ)
    % init var
    fullURL=[];
    str=[];
    temp_str=[];
    str_i=[];
    complete_str=[];
    
    Ticker=KOSDAQ(i).Ticker(length(KOSDAQ(i).Ticker)-5:length(KOSDAQ(i).Ticker));
    fullURL = sprintf('http://finance.naver.com/item/main.nhn?code=%s', Ticker);
    
    flag = 1;
    while flag==1
        try
            str=webread(fullURL);
            flag=0;
        catch
            fprintf('re try webread\n');
            flag=1;
        end
    end
    
    % find PBR
    str_i=strfind(str, '<em id="_pbr">');
    if isempty(str_i) == 0 % if there is PBR value
        % read PBR value
        temp_str=sprintf('%s',str(str_i+14:str_i+20)); % read example '<em id="_pbr">1.35</em>น่'
        str_i=strfind(temp_str,'<'); % '<' is next charater of PBR value
        complete_str=sprintf('%s',temp_str(1:str_i-1)); % read before '<'
        temp=str2double(complete_str);
        KOSDAQ(i).PBR=temp;
    else % if there is no PBR value, probably it is ETF
        KOSDAQ(i).PBR=100;
    end
    fprintf('%d / %d - %s - %s - KOSDAQ PBR: %5.2f\n', i, length(KOSDAQ), KOSDAQ(i).Ticker, KOSDAQ(i).Name, KOSDAQ(i).PBR);
end

%% Save All
DATA=[];
if isempty(dir('../DATA/FNC/DATA.mat'))
    DATA=KOSPI;
    DATA=[DATA KOSDAQ];
else
    load('../DATA/FNC/DATA.mat');
    
    % DATA Update init
    for i=1:length(DATA)
        DATA(i).Update=0;
    end
    
    % KOSPI
    for i=1:length(KOSPI)
        flag=1;
        for j=1:length(DATA)
            % exited ticker
            if strcmp(KOSPI(i).Ticker, DATA(j).Ticker)
                flag=0;
                DATA(j).PBR = KOSPI(i).PBR;
                DATA(j).Normal = KOSPI(i).Normal;
                DATA(j).Update = KOSPI(i).Update;
            end
        end
        
        % new ticker
        if flag==1
            DATA_i=length(DATA)+1;
            DATA(DATA_i).Ticker = KOSPI(i).Ticker;
            DATA(DATA_i).Name = KOSPI(i).Name;
            DATA(DATA_i).K = 1;
            DATA(DATA_i).PBR = KOSPI(i).PBR;
            DATA(DATA_i).Normal = KOSPI(i).Normal;
            DATA(DATA_i).Update = KOSPI(i).Update;
            DATA(DATA_i).Date = [];
            DATA(DATA_i).Open = [];
            DATA(DATA_i).High = [];
            DATA(DATA_i).Low = [];
            DATA(DATA_i).Close = [];
            DATA(DATA_i).Volume = [];
        end
    end
    
    % KOSDAQ
    for i=1:length(KOSDAQ)
        flag=1;
        for j=1:length(DATA)
            % exited ticker
            if strcmp(KOSDAQ(i).Ticker, DATA(j).Ticker)
                flag=0;
                DATA(j).PBR = KOSDAQ(i).PBR;
                DATA(j).Normal = KOSDAQ(i).Normal;
                DATA(j).Update = KOSDAQ(i).Update;
            end
        end
        
        % new ticker
        if flag==1
            DATA_i=length(DATA)+1;
            DATA(DATA_i).Ticker = KOSDAQ(i).Ticker;
            DATA(DATA_i).Name = KOSDAQ(i).Name;
            DATA(DATA_i).K = 0;
            DATA(DATA_i).PBR = KOSDAQ(i).PBR;
            DATA(DATA_i).Normal = KOSDAQ(i).Normal;
            DATA(DATA_i).Update = KOSDAQ(i).Update;
            DATA(DATA_i).Date = [];
            DATA(DATA_i).Open = [];
            DATA(DATA_i).High = [];
            DATA(DATA_i).Low = [];
            DATA(DATA_i).Close = [];
            DATA(DATA_i).Volume = [];
        end
    end
end
save('../DATA/FNC/DATA.mat','DATA');
fprintf('Save DATA Done.\n');