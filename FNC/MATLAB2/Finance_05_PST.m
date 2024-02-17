%% clear
close all;
clear all;
clc;
fprintf('Finance_05_PST - Start\n');

%% Variable Setting
T=5; % time interval
P=0.05; % percentage
load('../DATA/FNC/DATA.mat');
fprintf('Variable Setting Done.\n');

%% PST: price_series_transform
tic;

for i=1:length(DATA)
    % nPST=0 means there is no BUY and SELL point by PST
    if isempty(DATA(i).CloseA) || length(DATA(i).CloseA) <= 10 %% too short time series to calculate pst
        DATA(i).PST=[];
        DATA(i).nPST=0;
    else
        [DATA(i).PST, DATA(i).nPST] = Finance_05_PST_func(T,P,DATA(i).CloseA);
    end
    
    % PST: price_series_transform data for ESN target.
    % BUY:-1 SELL:1
    % nPST : number of specific reversal pionts.
    fprintf('PST: %d / %d - %s - %s\n', i, length(DATA), DATA(i).Ticker, DATA(i).Name);
end

%% tic toc
toc_time = toc;
fprintf('%.2f sec\n%.2f min\n', toc_time, toc_time/60);

%% Save
save('../DATA/FNC/DATA.mat','DATA');
filename=sprintf('../DATA/FNC/DATA_%s.mat',datestr(now,'yyyymmdd'));
save(filename,'DATA');