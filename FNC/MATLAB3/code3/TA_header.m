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
%     LGD  = 819;   % LG디스플레이 ***    
%     SSE  = 340;   SSEP = SSE+1; % 삼성전자,우    
%     KIA  = 24;    % 기아자동차
%     LGE  = 1213;  LGEP = LGE+1; % LG전자,우
%     HDC  = 311;   HDCB = HDC+2; % 현대차,2우B
%     SSH  = 476;   % 삼성중공업
%     GS   = 1308;  % GS
%     DSIC = 959;   % 두산인프라코어
%     GSHS = 746;   % GS홈쇼핑
%     SSTW = 533;   % 삼성테크윈
%     NAV  = 835;   % NAVER
%     SK   = 221;   % SK
%     SHF  = 1122;  % 신한지주
%     WRF  = 1081;  % 우리금융
%     LTS  = 676;   % 롯데쇼핑
%     HDM  = 529;   % 현대모비스

%     thename='LG디스플레이'; findname; LGD=thenumb;      
%     thename='삼성전자'; findname; SSE=thenumb;
%     thename='삼성전자우'; findname; SSEP=thenumb;    
%     thename='기아차'; findname; KIA=thenumb;
%     thename='LG전자'; findname; LGE=thenumb;
%     thename='LG전자우'; findname; LGEP=thenumb; % LGEP = LGE+1; % LG전자,우
%     thename='현대차'; findname; HDC=thenumb;
%     thename='현대차2우B'; findname; HDCB=thenumb;
%     thename='삼성중공업'; findname; SSH=thenumb;
%     thename='GS'; findname; GS=thenumb;
%     thename='두산인프라코어'; findname; DSIC=thenumb;
%     thename='GS홈쇼핑'; findname; GSHS=thenumb;
%     thename='삼성테크윈'; findname; SSTW=thenumb;
%     thename='NAVER'; findname; NAV=thenumb;
%     thename='SK'; findname; SK=thenumb;    
%     thename='신한지주'; findname; SHF=thenumb;
%     thename='우리금융'; findname; WRF=thenumb;
%     thename='롯데쇼핑'; findname; LTS=thenumb;
%     thename='현대모비스'; findname; HDM=thenumb;    
    
TAT1=LGD; TAT2=SSE; TAT3=KIA; TAT4=LGE; TAT5=HDC; TAT6=SSH; 
TAT7=GS; TAT8=DSIC; TAT9=GSHS; TAT10=SSTW; TAT11=NAV; TAT12=SK; 
TAT14=WRF; TAT13=SHF; TAT15=LTS; TAT16=HDM; TAT17=SSEP; TAT18=LGEP; TAT19=HDCB;

% cr= ...
% TAT16 ;      sf = cr - 9; sl = cr + 9; [raw_stock_names(sf:sl) num2cell(sf:sl)']

% raw_stock_n_ed([LGD SSE SSEP KIA LGE LGEP HDC HDCB SSH GS DSIC GSHS SSTW NAV SK SHF WRF LTS HDM])

%% 애매
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