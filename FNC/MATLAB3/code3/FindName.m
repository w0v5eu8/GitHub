%%
% raw_stock_p ������ raw_stock_n_ed ���Ϳ��� Ÿ�� ������ ��ġ(��ȣ)�� ã�Ƴ��� �̸������� �Է���
%%
global thename thenumb
rscn_s=size(raw_stock_n_ed);
findn=zeros(rscn_s(1),1);
for i_fdn = 1:rscn_s(1)

    findn(i_fdn,1) = (strcmp(raw_stock_n_ed(i_fdn,1), thename));
    
end

thenumb=sum((1:rscn_s(1))'.*findn);

clear rscn_s findn i_fdn



