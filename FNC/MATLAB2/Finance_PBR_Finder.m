%% Clear
close all;
clear all;
clc;

%% PBR <= Finder
index=1;
load('../DATA/FNC/DATA/DATA.mat');

for i=1:length(DATA)
    if DATA(i).PBR <= 1 && DATA(i).Normal == 1 && DATA(i).Update == 1
        PBR_Finder(index).Ticker=DATA(i).Ticker;
        PBR_Finder(index).Name=DATA(i).Name;
        PBR_Finder(index).PBR=DATA(i).PBR;
        PBR_Finder(index).Close=DATA(i).Close(length(DATA(i).Close));
        PBR_Finder(index).Voulme=DATA(i).Volume(length(DATA(i).Volume));
        fprintf('%d: %s - %s PBR:%3.2f Close:%d Volume:%d\n',i, DATA(i).Ticker, DATA(i).Name, DATA(i).PBR, DATA(i).Close(length(DATA(i).Close)), DATA(i).Volume(length(DATA(i).Volume)));
        index=index+1;
    end
end

save('../DATA/FNC/DATA/PBR_Finder.mat', 'PBR_Finder');