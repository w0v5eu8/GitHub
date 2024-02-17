clc;
tic
filename=sprintf('../../DATA/FNC/Log_%s.txt',datestr(now-1,'yyyymmdd'));
diary(filename);
diary on;

%% KRX Data Collection
% �ѱ� �ֽĽ��� �ð� 09:00 ~ 15:30
% krx ����Ʈ���� ���� ���� ���ں� �����ʹ� �������Ŀ� ���� �����Ͱ� ������Ʈ ��
% krx ����Ʈ���� ũ�Ѹ� ������ ���� ���� IP�� ���ܵǴ� ��찡 ����
% �̷����� ���� proxy ������ �����ؼ� �����ؾ� ��.
% Matlab->Ȩ->�⺻����->'MATLAB'��->'��'��->���ͳݿ��ῡ�� ����
% ���� ���Ͻ� ���� ����Ʈ HTTP Protocol�� �����ؾ� ��.
% http://www.freeproxylists.net/
FNC_01_KRX_Index_Data % ���� ���� KRX ����Ʈ�� ������Ʈ ��
FNC_01_KOSPI_KOSDAQ_Data % ���� ���� KRX ����Ʈ�� ������Ʈ ��
FNC_01_ETF_Data % �ǽð����� KRX ����Ʈ�� ������Ʈ ��

%% KRX Preprocessing: Scaling, PST 
FNC_02_Preprocessing('KRX_Index')
FNC_02_Preprocessing('KRX')
FNC_02_Preprocessing('ETF')

%% Done
toc_time=toc;
fprintf('toc time = %f min\n',toc_time/60);
diary off;