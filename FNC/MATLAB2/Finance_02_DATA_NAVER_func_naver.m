function TEMP=Finance_02_DATA_NAVER_func_naver(ticker, begin_date, end_date)
%% for stand-alone test, init setting
%{
clear all;
close all;
clc;

ticker='005930';
%begin_date=datenum('2005-01-01','yyyy-mm-dd');
begin_date=737042;
end_date=floor(now);
%}

%% find last page number

% set webread option timeout
options = weboptions('Timeout',inf);

url=sprintf('http://finance.naver.com/item/sise_day.nhn?code=%s&page=1',ticker);
flag = 1;
while flag==1
    try
        str=webread(url,options);
        flag=0;
    catch
        fprintf('re try webread\n');
        flag=1;
    end
end
str_t{1}=sprintf('<a href="/item/sise_day.nhn?code=%s&amp;page=',ticker);
str_t{2}='"  >¸ÇµÚ';
str = strsplit(str,str_t);
last_page = str2double(str(length(str)-1));
if isnan(last_page)
    last_page=1;
end

%% crwaling
TEMP=[];
TEMP_i=0;
for page=1:last_page
    
    % URL
    url=sprintf('http://finance.naver.com/item/sise_day.nhn?code=%s&page=%d',ticker,page);
    
    % Web Read
    flag = 1;
    while flag==1
        try
            str=webread(url,options);
            flag=0;
        catch
            fprintf('re try webread\n');
            flag=1;
        end
    end
    
    % for string processing
    splitcritic{1}='<span class="tah p10 gray03">';
    splitcritic{2}='</span></td>';
    splitcritic{3}='<td class="num"><span class="tah p11">';
    
    % string split
    temp=[];
    temp = strsplit(str,splitcritic);
    index=1:2:length(temp);
    temp(index)=[];
    
    % update
    for i=1:6:length(temp)
        date_temp = datenum(temp{i},'yyyy.mm.dd');
        if date_temp > end_date
            break;
        end
        if begin_date <= date_temp
            TEMP_i=TEMP_i+1;
            TEMP.date(TEMP_i,1) = date_temp;
            TEMP.close(TEMP_i,1) = str2double(temp{i+1});
            TEMP.open(TEMP_i,1) = str2double(temp{i+2});
            TEMP.high(TEMP_i,1) = str2double(temp{i+3});
            TEMP.low(TEMP_i,1) = str2double(temp{i+4});
            TEMP.volume(TEMP_i,1) = str2double(temp{i+5});
        else
            return;
        end
    end
    %fprintf('page = %d\n',page);
end

%{
% flip
TEMP.DateTime = flip(TEMP.DateTime);
TEMP.closePrice = flip(TEMP.closePrice);
TEMP.openPrice = flip(TEMP.openPrice);
TEMP.highPrice = flip(TEMP.highPrice);
TEMP.lowPrice = flip(TEMP.lowPrice);
TEMP.volume = flip(TEMP.volume);
%}