clc;
tic
filename=sprintf('../../DATA/FNC/Log_E_%s.txt',datestr(now-1,'yyyymmdd'));
diary(filename);
diary on;

%% �ؿ��ֽ� Data Collection �̱� �ֽĽ��� �ð� (�ѱ��ð�) 23:30 ~ 06:00
% new date �����͸� ������Ʈ
% FNC_01_SP500_yahoo_Data

% ���� �ְ� �ݿ��� ���ؼ� ��ü �����͸� ���� �޾� ��.
FNC_01_SP500_yahoo_Data_Replace 

%% Preprocessing: Scaling, PST
FNC_02_Preprocessing('SP500')

%% Done
toc_time=toc;
fprintf('toc time = %f min\n',toc_time/60);
diary off;

%% exmple
% struct find
% find([SP500.Update]==0)