cccc

crtfd = dir;
objsz = size(crtfd);

objnm = cell(objsz(1),1);
for i = 3:objsz(1)
    objnm(i) =  cellstr(crtfd(i).name);
end
% ���� ������ �ִ� ���ϵ��� �̸��� ������
clear i crtfd

%%
for ii = 3:objsz(1) 
    
    crttg = objnm{ii};
    load(crttg)
    stnm = 824;
    rng('default')
    S1_preESN
    S2_header
    clear T* c* r* n* i* s* t* p* S* m* a* j* b* or* of* ou* 
    
end
% ������ �ϳ��� �ҷ��� header �� �����Ŵ





