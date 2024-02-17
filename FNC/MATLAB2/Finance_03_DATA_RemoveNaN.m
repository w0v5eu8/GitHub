%% clear
clear all;
close all;
clc;
fprintf('Finance_03_DATA_RemoveNaN - Start\n');

%% Init setting
load('../DATA/FNC/DATA.mat');
fprintf('Init Setting Done.\n');

%% Find NaN
f=fopen('../DATA/FNC/NaN_Log.txt','w');

for i=1:length(DATA)
    % find Open NaN
    t=isnan(DATA(i).Open);
    tsum=sum(t);
    if tsum > 0
        fprintf(f,'Remove NaN. %d: %s - %s  Open NaN: %d  n: %d\n', i, DATA(i).Ticker, DATA(i).Name, tsum, length(DATA(i).Open));
    end
    DATA(i).Date(t) = [];
    DATA(i).Open(t) = [];
    DATA(i).High(t) = [];
    DATA(i).Low(t) = [];
    DATA(i).Close(t) = [];
    DATA(i).Volume(t) = [];
    
    % find High NaN
    t=isnan(DATA(i).High);
    tsum=sum(t);
    if tsum > 0
        fprintf(f,'Remove NaN. %d: %s - %s  High NaN: %d  n: %d\n', i, DATA(i).Ticker, DATA(i).Name, tsum, length(DATA(i).High));
    end
    DATA(i).Date(t) = [];
    DATA(i).Open(t) = [];
    DATA(i).High(t) = [];
    DATA(i).Low(t) = [];
    DATA(i).Close(t) = [];
    DATA(i).Volume(t) = [];
    
    % find Low NaN
    t=isnan(DATA(i).Low);
    tsum=sum(t);
    if tsum > 0
        fprintf(f,'Remove NaN. %d: %s - %s  Low NaN: %d  n: %d\n', i, DATA(i).Ticker, DATA(i).Name, tsum, length(DATA(i).Low));
    end
    DATA(i).Date(t) = [];
    DATA(i).Open(t) = [];
    DATA(i).High(t) = [];
    DATA(i).Low(t) = [];
    DATA(i).Close(t) = [];
    DATA(i).Volume(t) = [];
    
    % find Close NaN
    t=isnan(DATA(i).Close);
    tsum=sum(t);
    if tsum > 0
        fprintf(f,'Remove NaN. %d: %s - %s  Close NaN: %d  n: %d\n', i, DATA(i).Ticker, DATA(i).Name, tsum, length(DATA(i).Close));
    end
    DATA(i).Date(t) = [];
    DATA(i).Open(t) = [];
    DATA(i).High(t) = [];
    DATA(i).Low(t) = [];
    DATA(i).Close(t) = [];
    DATA(i).Volume(t) = [];
    
    fprintf('Remove NaN: %d / %d - %s - %s \n', i, length(DATA), DATA(i).Ticker, DATA(i).Name);
end
fclose(f);

%% Save
save('../DATA/FNC/DATA.mat','DATA');
fprintf('Save DATA Done.\n');