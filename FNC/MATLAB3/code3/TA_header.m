% cc = clock;
% ccc= cc(1:3);
% if ccc(3) < 10 && ccc(2) > 9
%     aaa=(['raw_stock_p_',num2str(ccc(1)),num2str(ccc(2)),'0',num2str(ccc(3))]);
% elseif ccc(3) < 10 && ccc(2) < 10   
%     aaa=(['raw_stock_p_',num2str(ccc(1)),'0',num2str(ccc(2)),'0',num2str(ccc(3))]);
% elseif ccc(3) > 9 && ccc(2) < 10   
%     aaa=(['raw_stock_p_',num2str(ccc(1)),'0',num2str(ccc(2)),num2str(ccc(3))]);
% else    
%     aaa=(['raw_stock_p_',num2str(ccc(1)),num2str(ccc(2)),num2str(ccc(3))]);
% end
% load(aaa)

% global md thename thenumb

% md = max_duration;

global curt_tag
curt_tag
load(curt_tag)
%     LGD  = 819;   % LG���÷��� ***    
%     SSE  = 340;   SSEP = SSE+1; % �Ｚ����,��    
%     KIA  = 24;    % ����ڵ���
%     LGE  = 1213;  LGEP = LGE+1; % LG����,��
%     HDC  = 311;   HDCB = HDC+2; % ������,2��B
%     SSH  = 476;   % �Ｚ�߰���
%     GS   = 1308;  % GS
%     DSIC = 959;   % �λ��������ھ�
%     GSHS = 746;   % GSȨ����
%     SSTW = 533;   % �Ｚ��ũ��
%     NAV  = 835;   % NAVER
%     SK   = 221;   % SK
%     SHF  = 1122;  % ��������
%     WRF  = 1081;  % �츮����
%     LTS  = 676;   % �Ե�����
%     HDM  = 529;   % ������

%     thename='LG���÷���'; findname; LGD=thenumb;      
%     thename='�Ｚ����'; findname; SSE=thenumb;
%     thename='�Ｚ���ڿ�'; findname; SSEP=thenumb;    
%     thename='�����'; findname; KIA=thenumb;
%     thename='LG����'; findname; LGE=thenumb;
%     thename='LG���ڿ�'; findname; LGEP=thenumb; % LGEP = LGE+1; % LG����,��
%     thename='������'; findname; HDC=thenumb;
%     thename='������2��B'; findname; HDCB=thenumb;
%     thename='�Ｚ�߰���'; findname; SSH=thenumb;
%     thename='GS'; findname; GS=thenumb;
%     thename='�λ��������ھ�'; findname; DSIC=thenumb;
%     thename='GSȨ����'; findname; GSHS=thenumb;
%     thename='�Ｚ��ũ��'; findname; SSTW=thenumb;
%     thename='NAVER'; findname; NAV=thenumb;
%     thename='SK'; findname; SK=thenumb;    
%     thename='��������'; findname; SHF=thenumb;
%     thename='�츮����'; findname; WRF=thenumb;
%     thename='�Ե�����'; findname; LTS=thenumb;
%     thename='������'; findname; HDM=thenumb;    
    
TAT1=LGD; TAT2=SSE; TAT3=KIA; TAT4=LGE; TAT5=HDC; TAT6=SSH; 
TAT7=GS; TAT8=DSIC; TAT9=GSHS; TAT10=SSTW; TAT11=NAV; TAT12=SK; 
TAT14=WRF; TAT13=SHF; TAT15=LTS; TAT16=HDM; TAT17=SSEP; TAT18=LGEP; TAT19=HDCB;

% cr= ...
% TAT16 ;      sf = cr - 9; sl = cr + 9; [raw_stock_names(sf:sl) num2cell(sf:sl)']

% raw_stock_n_ed([LGD SSE SSEP KIA LGE LGEP HDC HDCB SSH GS DSIC GSHS SSTW NAV SK SHF WRF LTS HDM])

%% �ָ�
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