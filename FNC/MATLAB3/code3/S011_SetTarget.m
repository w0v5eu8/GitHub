global md

% load('raw_stock_p_20131023.mat'); % raw_stock_p_00000000 파일 호출

md = 1000; % 기간변수 md 설정    

%% find target by name

global thename thenumb

    thename='LG디스플레이'; FindName; LGD=thenumb; TAT1=LGD;     
    thename='삼성전자'; FindName; SSE=thenumb; TAT2=SSE; 
    thename='삼성전자우'; FindName; SSEP=thenumb; TAT3=SSEP;   
    thename='기아차'; FindName; KIA=thenumb; TAT4=KIA;
    thename='LG전자'; FindName; LGE=thenumb; TAT5=LGE;
    thename='LG전자우'; FindName; LGEP=thenumb; TAT6=LGEP;
    thename='현대차'; FindName; HDC=thenumb; TAT7=HDC; 
    thename='현대차2우B'; FindName; HDCB=thenumb; TAT8=HDCB;
    thename='삼성중공업'; FindName; SSH=thenumb; TAT9=SSH;
    thename='GS'; FindName; GS=thenumb;TAT10=GS;
    thename='두산인프라코어'; FindName; DSIC=thenumb; TAT11=DSIC;
    thename='GS홈쇼핑'; FindName; GSHS=thenumb; TAT12=GSHS;
    thename='삼성테크윈'; FindName; SSTW=thenumb; TAT13=SSTW; 
    thename='NAVER'; FindName; NAV=thenumb; TAT14=NAV;
    thename='SK'; FindName; SK=thenumb; TAT15=SK;     
    thename='신한지주'; FindName; SHF=thenumb; TAT16=SHF;
    thename='우리금융'; FindName; WRF=thenumb; TAT17=WRF;
    thename='롯데쇼핑'; FindName; LTS=thenumb; TAT18=LTS;
    thename='현대모비스'; FindName; HDM=thenumb; TAT19=HDM;   
    clear thename thenumb
% cr= ...
% TAT16 ;      sf = cr - 9; sl = cr + 9; [raw_stock_names(sf:sl) num2cell(sf:sl)']

% raw_stock_n_ed([LGD SSE SSEP KIA LGE LGEP HDC HDCB SSH GS DSIC GSHS SSTW NAV SK SHF WRF LTS HDM])
%%
DHM =  1;  % 동화약품 **
CJDT = 1;  % CJ대한통운
SKH  = 1;  % SK하이닉스
KOL  = 1;  % 코오롱 **
NXT  = 1;  % 넥센타이어
KCC  = 1;  % KCC
SBB  = 1;  % 세방전지 **
MIM  = 1;  % 매일유업 x
LDCH = 1;  % 롯데케미칼
HDMB = 1;  % 현대모비스
KHO  = 1;  % 금호석유
HDE  = 1;  % 현대엘리베이터
KGIN = 1;  % KG이니시스
SSBR = 1;  % 상신브레이크
LGL  = 1;  % LG생활건강
LGCP = 1;  % LG화학우
KDEX = 1;  % KODEX200
HDD  = 1;  % 현대백화점
KTRN = 1;  % 켐트로닉스
SEDP = 1;  % 상신이디피
