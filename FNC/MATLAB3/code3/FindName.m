%%
% raw_stock_p 파일의 raw_stock_n_ed 벡터에서 타겟 종목의 위치(번호)를 찾아내서 이름변수에 입력함
%%
global thename thenumb
rscn_s=size(raw_stock_n_ed);
findn=zeros(rscn_s(1),1);
for i_fdn = 1:rscn_s(1)

    findn(i_fdn,1) = (strcmp(raw_stock_n_ed(i_fdn,1), thename));
    
end

thenumb=sum((1:rscn_s(1))'.*findn);

clear rscn_s findn i_fdn



