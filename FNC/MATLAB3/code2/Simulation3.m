global md

TA_header
ddd = raw_stock_d_ed(1,md);

% for sim3i = 1:19 
    s3var=eval(['TAT',num2str(1)]);

load([num2str(s3var),'_ESN_',num2str(3),'.mat'])

load([num2str(s3var),'_ESN_',num2str(2),'.mat'])

load([num2str(s3var),'_ESN_',num2str(1),'.mat'])


if stnm==SSE
    save(['SSE_',num2str(ddd)])
elseif stnm==SSEP
    save(['SSEP_',num2str(ddd)])
elseif stnm==HDCB
    save(['HDCB_',num2str(ddd)])
elseif stnm==DSIC
    save(['DSIC_',num2str(ddd)])
elseif stnm==LDCH
    save(['LDCH_',num2str(ddd)])
elseif stnm==GSHS
    save(['GSHS_',num2str(ddd)])
elseif stnm==GS
    save(['GS_',num2str(ddd)])
elseif stnm==LGE
    save(['LGE_',num2str(ddd)])
elseif stnm==LGEP
    save(['LGEP_',num2str(ddd)])
elseif stnm==LGD
    save(['LGD_',num2str(ddd)])
elseif stnm==SEDP
    save(['SEDP_',num2str(ddd)])
elseif stnm==KDEX
    save(['KDEX_',num2str(ddd)])
elseif stnm==SSH
    save(['SSH_',num2str(ddd)])
elseif stnm==KTRN
    save(['KTRN_',num2str(ddd)])
elseif stnm==KIA
    save(['KIA_',num2str(ddd)])
elseif stnm==HDC
    save(['HDC_',num2str(ddd)])
elseif stnm==HDD
    save(['HDD_',num2str(ddd)])
elseif stnm==SSTW
    save(['SSTW_',num2str(ddd)])
elseif stnm==NAV
    save(['NAV_',num2str(ddd)])
elseif stnm==SK
    save(['SK_',num2str(ddd)])
elseif stnm==WRF
    save(['WRF_',num2str(ddd)])
elseif stnm==SHF
    save(['SHF_',num2str(ddd)])
elseif stnm==LTS
    save(['LTS_',num2str(ddd)])
elseif stnm==HDM
    save(['HDM_',num2str(ddd)])
elseif stnm==MIM
    save(['MIM_',num2str(ddd)])
else
    save([num2str(stnm),'_test_',num2str(ddd)])
end



% end
