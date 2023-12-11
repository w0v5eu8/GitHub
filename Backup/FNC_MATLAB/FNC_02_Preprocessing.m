function FNC_02_Preprocessing(Type)

%% ������ �ε�
cmd=sprintf('load(''../../DATA/FNC/%s.mat''); DATA=%s;', Type, Type);
eval(cmd)

%% KOSPI KOSDAQ�� �ð��Ѿ�, �������� ������ �������� ���� ���� ���� ������ �����ϸ�
% KOSPI KOSDAQ ��� ���� ���ڰ� ������ ������ �ް��ϰ� ���� �� �����Ƿ� �ð��Ѿ��� �������� ��.
% A1 -> z-score with mean 0 and standard deviation 1
% A2 -> [0 1] : �̰� PST�� ���� �߳���.
% A3 -> [-1 1]

%% KRX_Index Scaling
for i=1:length(DATA)
    DATA(i).A1=normalize(DATA(i).Price);
    DATA(i).A2=normalize(DATA(i).Price,'range',[0 1]);
    DATA(i).A3=normalize(DATA(i).Price,'range',[-1 1]);
    fprintf('%s Scaling: %d / %d - %s Done.\n', Type, i, length(DATA), DATA(i).codeName);
end

%% �ְ��� Target���� ����� Price_Series_Transform
% ��������� �ְ��� T, P�� �������� smooting

%% PST �Ķ���� ����
T=5; % time interval
P=0.05; % percentage

%% PST
for j=1:length(DATA)
    % nPST=0 means there is no BUY and SELL point by PST
    if isempty(DATA(j).A2) || length(DATA(j).A2) <= 10
        % too short time series to calculate pst
        DATA(j).PST=[];
        DATA(j).nPST=0;
    else
        [DATA(j).PST, DATA(j).nPST] = FNC_Func_PST(T,P,DATA(j).A2);
    end
    
    fprintf('%s PST: %d / %d - %s Done.\n', Type, j, length(DATA), DATA(j).codeName);
end

%% Save
cmd=sprintf('%s=DATA; save(''../../DATA/FNC/%s_%s.mat'',''%s''); save(''../../DATA/FNC/%s.mat'',''%s'');', ...
    Type, Type, num2str(DATA(1).Date(length(DATA(1).Date))), Type, Type, Type);
eval(cmd)
fprintf('FNC_02_Preprocessing Done.\n');