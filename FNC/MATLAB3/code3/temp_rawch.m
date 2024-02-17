crtfld = dir;
objsz = size(crtfld);

objnms=cell(objsz(1),1);
for i = 3:objsz(1)
    objnms(i) =  cellstr(crtfld(i).name);
end

for ii = 1:30  %3:objsz(1) 
    load(objnms{ii*3})
    ddd
    temp_321
    load(objnms{ii*3+1})
    ddd
    temp_321
    load(objnms{ii*3+2})
    ddd
    temp_321
    temp_321end
    clear
    clc
    load('objnm.mat')
%     a=size(raw_stock_d);
    
%      save(['raw_stock_p_',num2str(raw_stock_d(1,a(2)))])

end




