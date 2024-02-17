
% rscmn = tsmovavg(rscm, 's', 10, 1)  ;
% rscmn = boxcox(rscm, );
% rscmn = msnorm(rscm, );

% rscmn2 = rscm/norm(rscm);
% hold on; plot(rscmn2, 'r');
rscmn = manorm(rscm)-1;
rshmn = manorm(rshm)-1;
rslmn = manorm(rslm)-1;

plot(rscmn)
