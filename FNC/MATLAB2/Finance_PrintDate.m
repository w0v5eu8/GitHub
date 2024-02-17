function Finance_PrintDate(index)

load('../DATA/FNC/DATA.mat');

for i=1:length(DATA(index).Date)
    fprintf('%s   ', datestr(DATA(index).Date(i)));
    if mod(i,5) == 0
        fprintf('\n');
    end
end

fprintf('\n');

fprintf('Start:\t%s\nEnd:\t%s\n', datestr(DATA(index).Date(1)),datestr(DATA(index).Date(length(DATA(index).Date))));

end