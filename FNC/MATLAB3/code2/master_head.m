cccc

crtfld = dir;
    objsz = size(crtfld);

objnms=cell(objsz(1),1);
for i = 3:objsz(1)
    objnms(i) =  cellstr(crtfld(i).name);
end
%%
for ii = 3:objsz(1) 
    
    global curt_tag
%     curt_tag
    curt_tag = objnms{ii};
    load(curt_tag)
    TA_s
    

end





