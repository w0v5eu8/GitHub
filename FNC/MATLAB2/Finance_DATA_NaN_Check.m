load('../DATA/FNC/DATA/DATA.mat');

total=0;
for i=1:length(DATA)
    t=sum(isnan(DATA(i).Open));
    if t > 0
        fprintf('%d: %s - %s NaN: %d, n:%d \n',i, DATA(i).Ticker, DATA(i).Name, t, length(DATA(i).Open));
        total=total+1;
    end
end

fprintf('NaN Total = %d\n', total);