% cybos plus�� �迭 ���� �ε��� ũ�Ⱑ n�̸�, �ε����� 0���� �����Ͽ� n-1���� ������.

% max_duration=1500;
% index=0;

%% �̺κ��� �߿� -- start
% �̷������� ProgID�� �̿��ؼ� �ε��ؾ� ��.
% CpDib.dll�� Dscbo1.(������Ʈ��)
% CpSysDib.dll�� CpSysDib.(������Ʈ��) 
% CpTrade.dll�� CpTrade.(������Ʈ��)
% CpUtil.dll�� CpUtil.(������Ʈ��)
csc=actxserver('CpUtil.CpStockCode');
ccm=actxserver('CpUtil.CpCodeMgr');
cbg1=actxserver('Dscbo1.CbGraph1'); % CpDib �Լ����� Dscbo1���� �ε��ؾ���.
% CbGraph1�� ���� ������ �ȵȴٴϱ� �����δ� StockChart�� �̿��ؾ� ������ ��.
%% �̺κ��� �߿� -- end

max_duration=1500; % 1000�� ������ �޾ƿ���
index=0;
for i=0:csc.GetCount()-1 % Code: 0~csc.GetCount()-1
    code = csc.GetData(0,i);
    % CONDITION 1 : control , supervision, normal, KOSPI200)
    if strcmp('CPC_CONTROL_NONE', ccm.GetStockControlKind(code)) == 1
        if strcmp('CPC_SUPERVISION_NONE', ccm.GetStockSupervisionKind(code)) == 1
            if strcmp('CPC_STOCK_STATUS_NORMAL', ccm.GetStockStatusKind(code)) == 1
                %if strcmp('CPC_KOSPI200_NONE', ccm.GetStockKospi200Kind(code)) == 0
                    % input query setting
                    cbg1.SetInputValue(0,code); % stock code
                    cbg1.SetInputValue(1,uint8('D')); % day unit
                    cbg1.SetInputValue(3,max_duration); % duration setting (+4 for average)
                    cbg1.BlockRequest(); % query
                    
                    % CONDITION 2 : duration check
                    if(cbg1.GetDataValue(0,max_duration-1)~= 0)
                        j_index=0;
                        for j=max_duration:-1:1 % % 0 is recent, max_duration-1 is past.
                            j_index=j_index+1;
                            temp_d(j_index)=cbg1.GetDataValue(0,j-1); % date
                            temp_op(j_index)=cbg1.GetDataValue(1,j-1); % opening price
                            temp_hp(j_index)=cbg1.GetDataValue(2,j-1); % high price
                            temp_lp(j_index)=cbg1.GetDataValue(3,j-1); % low price
                            temp_cp(j_index)=cbg1.GetDataValue(4,j-1); % closing price
                            temp_v(j_index)=cbg1.GetDataValue(5,j-1); % volume
                        end
                        % CONDITION 3 : no suspend days
                        if(size(find(temp_cp==0),1) ~= 0)
                            index=index+1;
                            raw_stock_codes{index,1}=code;
                            raw_stock_names{index,1}=ccm.CodeToName(code);
                            raw_stock_d(index,:)=temp_d(5:max_duration);
                            raw_stock_op(index,:)=temp_op(5:max_duration);
                            raw_stock_hp(index,:)=temp_hp(5:max_duration);
                            raw_stock_lp(index,:)=temp_lp(5:max_duration);
                            raw_stock_cp(index,:)=temp_cp(5:max_duration);
                            raw_stock_v(index,:)=temp_v(5:max_duration);
                            for j=1:size(temp_cp,2)-4
                                raw_stock_fh(index,j)=max(temp_hp(j:j+4)); % 5-Day high
                                raw_stock_fc(index,j)=sum(temp_cp(j:j+4))/5; % 5-Day close moving average
                            end
                            fprintf('Get Data Done: %i - %s\n',index,code);
                        end
                    end
                %end
            end
        end
    end
end
cc = clock;
ccc= cc(1:3);
if ccc(3) < 10 && ccc(2) > 9
    save(['raw_stock_p_',num2str(ccc(1)),num2str(ccc(2)),'0',num2str(ccc(3))])
elseif ccc(3) < 10 && ccc(2) < 10   
    save(['raw_stock_p_',num2str(ccc(1)),'0',num2str(ccc(2)),'0',num2str(ccc(3))])
elseif ccc(3) > 9 && ccc(2) < 10   
    save(['raw_stock_p_',num2str(ccc(1)),'0',num2str(ccc(2)),num2str(ccc(3))])
else    
    save(['raw_stock_p_',num2str(ccc(1)),num2str(ccc(2)),num2str(ccc(3))])
end