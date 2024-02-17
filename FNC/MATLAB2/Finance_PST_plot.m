clear all;
close all;
clc;

%% Setting
ticker_i = 5;

load ('../DATA/FNC/DATA/DATA.mat');

if DATA(ticker_i).nPST == 0
    fprintf('There is not PST\n');
    return;
elseif  DATA(ticker_i).Update == 0 || DATA(ticker_i).Normal  == 0
    fprintf('No Update or Abnormal\n');
    return;
else
    fprintf('PST: %s - %s\n', DATA(ticker_i).Ticker, DATA(ticker_i).Name);
end

%% plot -1(buy), 1(sell) point => (x , y) with close price
x=[];
y=[];
index=0;
for i=1:length(DATA(ticker_i).PST)
    if (DATA(ticker_i).PST(i) == 1 || DATA(ticker_i).PST(i) == -1)
        index=index+1;
        x(index)=i;
        y(index)=DATA(ticker_i).CloseA(i);
    end
end

figure;
plot(DATA(ticker_i).CloseA);
hold on;
plot(x,y,'r');
axis('tight');