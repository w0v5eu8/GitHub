global md

% load('raw_stock_p_20131023.mat'); % raw_stock_p_00000000 ���� ȣ��

md = 1000; % �Ⱓ���� md ����    

%% find target by name

global thename thenumb

    thename='LG���÷���'; FindName; LGD=thenumb; TAT1=LGD;     
    thename='�Ｚ����'; FindName; SSE=thenumb; TAT2=SSE; 
    thename='�Ｚ���ڿ�'; FindName; SSEP=thenumb; TAT3=SSEP;   
    thename='�����'; FindName; KIA=thenumb; TAT4=KIA;
    thename='LG����'; FindName; LGE=thenumb; TAT5=LGE;
    thename='LG���ڿ�'; FindName; LGEP=thenumb; TAT6=LGEP;
    thename='������'; FindName; HDC=thenumb; TAT7=HDC; 
    thename='������2��B'; FindName; HDCB=thenumb; TAT8=HDCB;
    thename='�Ｚ�߰���'; FindName; SSH=thenumb; TAT9=SSH;
    thename='GS'; FindName; GS=thenumb;TAT10=GS;
    thename='�λ��������ھ�'; FindName; DSIC=thenumb; TAT11=DSIC;
    thename='GSȨ����'; FindName; GSHS=thenumb; TAT12=GSHS;
    thename='�Ｚ��ũ��'; FindName; SSTW=thenumb; TAT13=SSTW; 
    thename='NAVER'; FindName; NAV=thenumb; TAT14=NAV;
    thename='SK'; FindName; SK=thenumb; TAT15=SK;     
    thename='��������'; FindName; SHF=thenumb; TAT16=SHF;
    thename='�츮����'; FindName; WRF=thenumb; TAT17=WRF;
    thename='�Ե�����'; FindName; LTS=thenumb; TAT18=LTS;
    thename='������'; FindName; HDM=thenumb; TAT19=HDM;   
    clear thename thenumb
% cr= ...
% TAT16 ;      sf = cr - 9; sl = cr + 9; [raw_stock_names(sf:sl) num2cell(sf:sl)']

% raw_stock_n_ed([LGD SSE SSEP KIA LGE LGEP HDC HDCB SSH GS DSIC GSHS SSTW NAV SK SHF WRF LTS HDM])
%%
DHM =  1;  % ��ȭ��ǰ **
CJDT = 1;  % CJ�������
SKH  = 1;  % SK���̴н�
KOL  = 1;  % �ڿ��� **
NXT  = 1;  % �ؼ�Ÿ�̾�
KCC  = 1;  % KCC
SBB  = 1;  % �������� **
MIM  = 1;  % �������� x
LDCH = 1;  % �Ե��ɹ�Į
HDMB = 1;  % ������
KHO  = 1;  % ��ȣ����
HDE  = 1;  % ���뿤��������
KGIN = 1;  % KG�̴Ͻý�
SSBR = 1;  % ��ź극��ũ
LGL  = 1;  % LG��Ȱ�ǰ�
LGCP = 1;  % LGȭ�п�
KDEX = 1;  % KODEX200
HDD  = 1;  % �����ȭ��
KTRN = 1;  % ��Ʈ�δн�
SEDP = 1;  % ����̵���
