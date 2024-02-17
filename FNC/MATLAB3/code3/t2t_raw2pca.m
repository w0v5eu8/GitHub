clear global t2t_pca
global t2t_pca rscm rshm rslm

t2t_cp_m = double(rscm');
t2t_hp_m = double(rshm');
t2t_lp_m = double(rslm');

% min_t2t_cp_m = min(t2t_cp_m);
% min_t2t_hp_m = min(t2t_hp_m);
% min_t2t_lp_m = min(t2t_lp_m);
% 
% max_t2t_cp_m = max(t2t_cp_m);
% max_t2t_hp_m = max(t2t_hp_m);
% max_t2t_lp_m = max(t2t_lp_m);
% 
% t2t_cp=zeros(md,2000);
% t2t_hp=zeros(md,2000);
% t2t_lp=zeros(md,2000);
% 
%     rscmm0 = zeros(md,1);
%     rscmm1 = zeros(md,1);
%     rscmm2 = zeros(md,1);
%     rscmm3 = zeros(md,1);
%     rscmm4 = zeros(md,1);
%     rscmm5 = zeros(md,1);
%     rscmm6 = zeros(md,1);
%     rscmm7 = zeros(md,1);
%     rscmm8 = zeros(md,1);
    
%%        
for stm = stnm; % stock_num;
    
%     for i_t2t = 1:md
%         t2t_cp(i_t2t,stm) = ((t2t_cp_m(i_t2t,stm) - min_t2t_cp_m(stm))/(max_t2t_cp_m(stm) - min_t2t_cp_m(stm)) - 0.5)*2;
%         t2t_hp(i_t2t,stm) = ((t2t_hp_m(i_t2t,stm) - min_t2t_hp_m(stm))/(max_t2t_hp_m(stm) - min_t2t_hp_m(stm)) - 0.5)*2;
%         t2t_lp(i_t2t,stm) = ((t2t_lp_m(i_t2t,stm) - min_t2t_lp_m(stm))/(max_t2t_lp_m(stm) - min_t2t_lp_m(stm)) - 0.5)*2;
%     end

%     ddd=4;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm0(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=9;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm1(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%         
%     ddd=19;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm2(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
% 
%     ddd=29;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm3(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=39;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm4(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=49;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm5(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end    
%     
%     ddd=99;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm6(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=149;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm7(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=199;
%     
%     for inpm2 = 1+ddd:length(t2t_cp(:,1))
%         maxVal = max(t2t_cp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_cp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rscmm8(inpm2,stm) = ((t2t_cp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%%    
%     ddd=9;
%     
%     for inpm2 = 1+ddd:length(t2t_hp(:,1))
%         maxVal = max(t2t_hp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_hp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rshmm1(inpm2,stm) = ((t2t_hp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=19;
%     
%     for inpm2 = 1+ddd:length(t2t_hp(:,1))
%         maxVal = max(t2t_hp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_hp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rshmm2(inpm2,stm) = ((t2t_hp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=29;
%     
%     for inpm2 = 1+ddd:length(t2t_hp(:,1))
%         maxVal = max(t2t_hp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_hp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rshmm3(inpm2,stm) = ((t2t_hp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
% 
%     ddd=9;
%     
%     for inpm2 = 1+ddd:length(t2t_lp(:,1))
%         maxVal = max(t2t_lp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_lp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rslmm1(inpm2,stm) = ((t2t_lp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=19;
%     
%     for inpm2 = 1+ddd:length(t2t_lp(:,1))
%         maxVal = max(t2t_lp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_lp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rslmm2(inpm2,stm) = ((t2t_lp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     ddd=29;
%     
%     for inpm2 = 1+ddd:length(t2t_lp(:,1))
%         maxVal = max(t2t_lp(inpm2-ddd:inpm2,stm)); minVal = min(t2t_lp(inpm2-ddd:inpm2,stm));
%         if maxVal - minVal > 0
%             rslmm3(inpm2,stm) = ((t2t_lp(inpm2,stm) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
    
%     plot(rscmm2(:,stm)) 
 
pca_x = [t2t_RSI_a(:,stm) t2t_RC_a(:,stm) t2t_MTM_a(:,stm)  ...
         t2t_CC1_a(:,stm) t2t_CC2_a(:,stm) t2t_CC3_a(:,stm) t2t_MA_a(:,stm) ...
         t2t_SS_a(:,stm) t2t_VR_a(:,stm) t2t_PL_a(:,stm) t2t_MFI_a(:,stm) ...
         t2t_PNVI_a(:,stm) t2t_CCI_a(:,stm) t2t_WR_a(:,stm) t2t_DMI_a(:,stm)]; % ... t2t_cp(:,stm)

% pca_x = [ ... rscmm0(:,stm) rscmm1(:,stm) rscmm2(:,stm)
%             rscmm3(:,stm) rscmm4(:,stm) rscmm5(:,stm) ...
%             rscmm6(:,stm) rscmm7(:,stm) rscmm8(:,stm) ];
ta_coef = pca(pca_x);
t2t_pca2 = pca_x*ta_coef; 
t2t_pca = [t2t_pca2'];
% t2t_pca = [pca_x'];

% ; ...
%             rscmm0(:,stm)' ; rscmm1(:,stm)' ; rscmm2(:,stm)' ; ...
%             rscmm3(:,stm)' ; rscmm4(:,stm)' ; rscmm5(:,stm)' ; ...
%             rscmm6(:,stm)' ; rscmm7(:,stm)' ; rscmm8(:,stm)' ; ...  
%             t2t_cp(:,stm)' ; -t2t_hp(:,stm)' ; -t2t_lp(:,stm)' ; ...
%             -rshmm1(:,stm)' ; -rshmm2(:,stm)' ; -rshmm3(:,stm)' ; ...
%             -rslmm1(:,stm)' ; -rslmm2(:,stm)' ; -rslmm3(:,stm)'];

% cc=clock;
% ccc=cc(2:5);
% save(['t2t_',num2str(stm),'_',num2str(ccc)])

end

%%


%     
%     for inpm = 1:length(rscmm3(:,1))
%         maxVal = max(rscmm3(:,:)); minVal = min(rscmm3(:,:));
%         if maxVal - minVal > 0
%             rscmm(inpm,:) = ((rscmm3(inpm,:) - minVal)/(maxVal - minVal)-0.5)*2;
%         end
%     end
%     
%     plot(rscmm)
