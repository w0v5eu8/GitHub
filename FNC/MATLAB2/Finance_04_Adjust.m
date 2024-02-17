%% clear
close all;
clear all;
clc;
fprintf('Finance_04_Adjust - Start\n');

%% Variable Setting
adjust_criteia=0.4; %% this means 30%
load('../DATA/FNC/DATA.mat');
fprintf('Variable Setting Done.\n');

%% Adjust
DATA(1).CloseA=DATA(1).Close; %% KOSPI Index
DATA(2).CloseA=DATA(2).Close; %% KOSDAQ Index

for stock_i=3:length(DATA)
    DATA(stock_i).OpenA(1,1)=1;
    DATA(stock_i).HighA(1,1)=1;
    DATA(stock_i).LowA(1,1)=1;
    DATA(stock_i).CloseA(1,1)=1;
    
    %% Open
    for i=length(DATA(stock_i).OpenA)+1:length(DATA(stock_i).Open)
        t=(DATA(stock_i).Open(i)-DATA(stock_i).Open(i-1))/DATA(stock_i).Open(i-1);
        if abs(t) > adjust_criteia
            t = 0;
        end
        DATA(stock_i).OpenA(i,1)=DATA(stock_i).OpenA(i-1,1)+(DATA(stock_i).OpenA(i-1,1)*t);
    end
    %% High
    for i=length(DATA(stock_i).HighA)+1:length(DATA(stock_i).High)
        t=(DATA(stock_i).High(i)-DATA(stock_i).High(i-1))/DATA(stock_i).High(i-1);
        if abs(t) > adjust_criteia
            t = 0;
        end
        DATA(stock_i).HighA(i,1)=DATA(stock_i).HighA(i-1,1)+(DATA(stock_i).HighA(i-1,1)*t);
    end
    %% Low
    for i=length(DATA(stock_i).LowA)+1:length(DATA(stock_i).Low)
        t=(DATA(stock_i).Low(i)-DATA(stock_i).Low(i-1))/DATA(stock_i).Low(i-1);
        if abs(t) > adjust_criteia
            t = 0;
        end
        DATA(stock_i).LowA(i,1)=DATA(stock_i).LowA(i-1,1)+(DATA(stock_i).LowA(i-1,1)*t);
    end
    
    %% Close
    for i=length(DATA(stock_i).CloseA)+1:length(DATA(stock_i).Close)
        t=(DATA(stock_i).Close(i)-DATA(stock_i).Close(i-1))/DATA(stock_i).Close(i-1);
        if abs(t) > adjust_criteia
            t = 0;
        end
        DATA(stock_i).CloseA(i,1)=DATA(stock_i).CloseA(i-1,1)+(DATA(stock_i).CloseA(i-1,1)*t);
    end
    fprintf('Adjust: %d / %d - %s - %s\n', stock_i, length(DATA), DATA(stock_i).Ticker, DATA(stock_i).Name);
end

%% Save
save('../DATA/FNC/DATA.mat','DATA');