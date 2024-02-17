%% clear
clear all;
close all;
clc;
fprintf('Finance_02_DATA_NAVER - Start\n');

%% Init setting
% tic toc
tic;

% loading DATA
load('../DATA/FNC/DATA.mat');

% end date
End_Date=floor(now);

% save flag
flag=0;

fprintf('Init Setting Done.\n');

%% KOSPI KOSDAQ index Crawling and Update
for i=1:2
    % variable setting
    if isempty(DATA(i).Date)
        Begin_Date=datenum('1900-01-01','yyyy-mm-dd');
    else
        Begin_Date=DATA(i).Date(length(DATA(i).Date))+1;
    end
    
    % the lastest version check
    if Begin_Date > End_Date
        fprintf('%d / %d - %s - %s Already the lastest version.\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name);
        continue;
    end
    
    flag=1;
    Ticker = DATA(i).Ticker;
    TEMP=Finance_02_DATA_NAVER_func_naver_index(Ticker, Begin_Date, End_Date);
    
    if isempty(TEMP)
        continue;
    end
    
    DATA(i).Date=vertcat(DATA(i).Date,flip(TEMP.date));
    DATA(i).Close=vertcat(DATA(i).Close,flip(TEMP.close));
    
    fprintf('DATA: %d / %d - %s - %s\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name)
end

%% KOSPI KOSDAQ Crawling and Update
for i=3:length(DATA)
%for i=2354:length(DATA)
    if DATA(i).Update == 0
        continue;
    end
    
    % variable setting
    if isempty(DATA(i).Date)
        Begin_Date=datenum('1900-01-01','yyyy-mm-dd');
    else
        Begin_Date=DATA(i).Date(length(DATA(i).Date))+1;
    end
    
    % the lastest version check
    if Begin_Date > End_Date
        fprintf('%d / %d - %s - %s Already the lastest version.\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name)
        continue;
    end
    
    Ticker = DATA(i).Ticker;
    TEMP=Finance_02_DATA_NAVER_func_naver(Ticker, Begin_Date, End_Date);    

    if isempty(TEMP)
        fprintf('TEMP is empty: %d / %d - %s - %s\n',i, length(DATA), DATA(i).Ticker, DATA(i).Name);
        continue;
    end
    
    DATA(i).Date=vertcat(DATA(i).Date,flip(TEMP.date));
    DATA(i).Open=vertcat(DATA(i).Open,flip(TEMP.open));
    DATA(i).High=vertcat(DATA(i).High,flip(TEMP.high));
    DATA(i).Low=vertcat(DATA(i).Low,flip(TEMP.low));
    DATA(i).Close=vertcat(DATA(i).Close,flip(TEMP.close));
    DATA(i).Volume=vertcat(DATA(i).Volume,flip(TEMP.volume));
    flag=1;

    fprintf('DATA: %d / %d - %s - %s=======================================DATA: %d / %d - %s - %s\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name, i, length(DATA), DATA(i).Ticker, DATA(i).Name);
end

%% Save
if flag == 1
    save('../DATA/FNC/DATA.mat','DATA');
    fprintf('Save DATA Done.\n');
end

%% tic toc
toc_time = toc;
fprintf('%.2f sec\n%.2f min\n', toc_time, toc_time/60);