load('../DATA/FNC/DATA.mat');

for i=1:length(DATA)
    if strcmp(DATA(i).Ticker,'006120')
        fprintf('%s %s %d %d\n',DATA(i).Ticker,DATA(i).Name,DATA(i).Update,DATA(i).Normal);
    end
end