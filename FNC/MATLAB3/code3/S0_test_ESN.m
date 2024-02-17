cccc

crtfd = dir;
objsz = size(crtfd);

objnm = cell(objsz(1),1);
for i = 3:objsz(1)
    objnm(i) =  cellstr(crtfd(i).name);
end
% 현재 폴더에 있는 파일들의 이름을 가져옴
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
% 파일을 하나씩 불러서 header 를 실행시킴





