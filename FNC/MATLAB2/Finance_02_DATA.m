%% clear
clear all;
close all;
clc;
fprintf('Finance_02_DATA - Start\n');

%% Init setting
% tic toc
tic;

% loading DATA
load('../DATA/FNC/DATA/DATA.mat');

% Beacase Yahoo return realtime streaming data & it will run +1 day. 
End_Date=datestr(now-1,'dd-mmm-yyyy');

% save flag
flag=0;

fprintf('Init Setting Done.\n');

%% KOSPI KOSDAQ Crawling and Update
for i=1:length(DATA)
    
    if DATA(i).K == 1
        % init variable: KOSPI for Google
        Ticker=sprintf('KRX:%s',DATA(i).Ticker);
        if isempty(DATA(i).Date)
            Begin_Date='01-Jan-2005';
        else
            Begin_Date=datestr(DATA(i).Date(length(DATA(i).Date))+1,'dd-mmm-yyyy');
            %Begin_Date=datestr(datenum(DATA(i).Date{length(DATA(i).Date)})+1,'dd-mmm-yyyy');
        end
        
        % the lastest version check
        if datenum(Begin_Date) > datenum(End_Date)
            fprintf('%d / %d - %s - %s Already the lastest version.\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name);
            continue;
        end
    else
        % init variable: KOSDAQ for Yahoo
        Ticker=sprintf('%s.KQ',DATA(i).Ticker);
        if isempty(DATA(i).Date)
            Begin_Date='01-Jan-2005';
        else
            Begin_Date=datestr(DATA(i).Date(length(DATA(i).Date))+1,'dd-mmm-yyyy');
            %Begin_Date=datestr(datenum(DATA(i).Date{length(DATA(i).Date)})+1,'dd-mmm-yyyy');
        end
        
        % the lastest version check
        if datenum(Begin_Date) > datenum(End_Date)
            fprintf('%d / %d - %s - %s Already the lastest version.\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name);
            continue;
        end
    end
    
    
    % Call function and update DATA
    if DATA(i).K == 1
        % Call Finance_func_DATA_Google for KOSPI
        TEMP=Finance_02_DATA_func_google(Ticker,'start',Begin_Date,'end',End_Date);
        DATA(i).Date=vertcat(DATA(i).Date,flip(TEMP.date));
        DATA(i).Open=vertcat(DATA(i).Open,flip(TEMP.open));
        DATA(i).High=vertcat(DATA(i).High,flip(TEMP.high));
        DATA(i).Low=vertcat(DATA(i).Low,flip(TEMP.low));
        DATA(i).Close=vertcat(DATA(i).Close,flip(TEMP.close));
        DATA(i).Volume=vertcat(DATA(i).Volume,flip(TEMP.volume));
        flag=1;
    else
        % Call Finance_func_DATA_Yahoo for KOSDAQ
        TEMP=Finance_02_DATA_func_yahoo(Ticker,Begin_Date,End_Date,'d');
        % Yahoo is alway return one lastest data at least if put on no stock trade date.
        % if just one TEMP retun and it is already in DATA then it will ignore.
        if length(TEMP.DateTime) ~= 1 || floor(TEMP.DateTime(1)) ~= floor(DATA(i).Date(length(DATA(i).Date)))
            DATA(i).Date=vertcat(DATA(i).Date,TEMP.DateTime);
            DATA(i).Open=vertcat(DATA(i).Open,TEMP.openPrice);
            DATA(i).High=vertcat(DATA(i).High,TEMP.highPrice);
            DATA(i).Low=vertcat(DATA(i).Low,TEMP.lowPrice);
            DATA(i).Close=vertcat(DATA(i).Close,TEMP.closePrice);
            DATA(i).Volume=vertcat(DATA(i).Volume,TEMP.volume);
            flag=1;
        end
    end
    
    fprintf('DATA: %d / %d - %s - %s\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name);
end

%% Save
if flag == 1
    save('../DATA/FNC/DATA/DATA.mat','DATA');
    fprintf('Save DATA Done.\n');
end

%% tic toc
toc_time = toc;
fprintf('%.2f sec\n%.2f min\n', toc_time, toc_time/60);