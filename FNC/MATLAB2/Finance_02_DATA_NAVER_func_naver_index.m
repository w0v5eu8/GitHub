function TEMP=Finance_02_DATA_NAVER_func_naver_index(ticker, begin_date, end_date)
%{
%% for stand-alone test, init setting

clear all;
close all;
clc;

ticker='KOSPI';
begin_date=datenum('2017-12-29','yyyy-mm-dd');
%end_date=floor(now)-1;
end_date=begin_date;
%}

%% find last page number
url=sprintf('http://finance.naver.com/sise/sise_index_day.nhn?code=%s&page=1',ticker);
str=webread(url);
str_t{1}=sprintf('<a href="/sise/sise_index_day.nhn?code=%s&amp;page=',ticker);
str_t{2}='"  >¸ÇµÚ';
str = strsplit(str,str_t);
last_page = str2double(str(length(str)-1));
if isnan(last_page)
    last_page=1;
end

% set webread option timeout
options = weboptions('Timeout',60);

%% crwaling
TEMP=[];
TEMP_i=0;
for page=1:last_page
    
    % URL
    url=sprintf('http://finance.naver.com/sise/sise_index_day.nhn?code=%s&page=%d',ticker,page);
    
    % Web Read
    flag = 1;
    while flag==1
        try
            str=webread(url,options);
            %fprintf('werbread page=%d/%d\n',page, last_page);
            flag=0;
        catch
            fprintf('re try webread\n');
            flag=1;
        end
    end
    
    % for string processing
    splitcritic=[];
    splitcritic{1}='<td class="date">';
    splitcritic{2}='<td class="number_1">';
    splitcritic{3}='</td>';
    
    % string split
    str_temp=[];
    temp=[];
    str_temp=strsplit(str,splitcritic);
    index=[3 5 12 14 21 23 33 35 42 44 51 53];
    temp = str_temp(index);
    
    % update
    for i=1:2:length(temp)
        if strcmp(temp{i}, '&nbsp;')
            continue;
        end
        date_temp = datenum(temp(i),'yyyy.mm.dd');

        if date_temp > end_date
            break;
        end
        if begin_date <= date_temp
            TEMP_i=TEMP_i+1;
            TEMP.date(TEMP_i,1) = date_temp;
            TEMP.close(TEMP_i,1) = str2double(temp(i+1));
        else
            return;
        end
    end
    %fprintf('page = %d\n',page);    
end