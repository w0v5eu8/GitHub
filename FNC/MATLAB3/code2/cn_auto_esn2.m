crtfld = dir;
objsz = size(crtfld);

objnms=cell(objsz(1)-2,1);
for i = 1:objsz(1)-2
    objnms(i) =  cellstr(crtfld(i+2).name);
end
objnmss=objnms;
%     final=zeros(3,20)';

for i2 = 1:objsz(1)-2
    load(objnmss{i2})
    indx=i2;
    cn_sowhat
end

%%
ff1(1:60,1)=final1(1,1:60);
ff1(2:61,2)=final1(2,1:60);
ff1(3:62,3)=final1(3,1:60);

ff2(1:60,1)=final2(1,1:60);
ff2(2:61,2)=final2(2,1:60);
ff2(3:62,3)=final2(3,1:60);

ff3(1:60,1)=final3(1,1:60);
ff3(2:61,2)=final3(2,1:60);
ff3(3:62,3)=final3(3,1:60);
%%
% close
% figure; hold on; 
% plot(rscm(md-61:md) + ff1(:,3)*200,'o', 'color',  'r'); 
% plot(rscm(md-61:md-1) + ff1(1:61,2)*200,'o', 'color',  'g');
% plot(rscm(md-61:md-2) + ff1(1:60,1)*200,'o', 'color',  'b');
% plot(rscm(md-61:md) + ff2(:,3)*200,'o', 'color',  'r'); 
% plot(rscm(md-61:md-1) + ff2(1:61,2)*200,'o', 'color',  'g');
% plot(rscm(md-61:md-2) + ff2(1:60,1)*200,'o', 'color',  'b');
% plot(rscm(md-61:md) + ff3(:,3)*200,'o', 'color',  'r'); 
% plot(rscm(md-61:md-1) + ff3(1:61,2)*200,'o', 'color',  'g');
% plot(rscm(md-61:md-2) + ff3(1:60,1)*200,'o', 'color',  'b');
% plot(rscm(md-61:md), 'k'); 
% % plot(rscm(md-61:md), 'o', 'color', 'k'); 

%%
close
mf1=mean(ff1')';
% mf1(61,1)=ff1(61,2);
mf1(62,1)=ff1(62,3);
mf1(61,1)=mean(ff1(61,2:3));

mf2=mean(ff2')';
% mf2(61,1)=ff2(61,2);
mf2(62,1)=ff2(62,3);
mf2(61,1)=mean(ff2(61,2:3));

mf3=mean(ff3')';
% mf3(61,1)=ff3(61,2);
mf3(62,1)=ff3(62,3);
mf3(61,1)=mean(ff3(61,2:3));

%%
fa1 = (ff1(:,1) + ff2(:,1) + ff3(:,1))/3;
fa2 = (ff1(:,2) + ff2(:,2) + ff3(:,2))/3;


%%
close
figure('name', 'esn_test_mix', 'Position', [50,50,1200,600]);
plot(rscm(md-61:md), 'k'); hold on;
plot(rshm(md-61:md), 'k:');
plot(rslm(md-61:md), 'k:');
% plot(rscm(md-61:md)+mf1(:,1)*2000, 'r');
% plot(rscm(md-61:md)+mf2(:,1)*2000, 'r');
% plot(rscm(md-61:md)+mf3(:,1)*2000, 'r');
mf123=mean( [mf1(:,1) mf2(:,1) mf3(:,1)], 2);
mfcm=rscm(md-61:md)+mf123*5000;
% plot(mfcm, 'g');
facm1=rscm(md-61:md)+fa1*1000;
plot(facm1, 'o', 'color', [0 1 0]);
facm2=rscm(md-61:md)+fa2*1000;
plot(facm2, 'o', 'color', [.2 .5 .3]);
% plot(rscm(md-61:md)+mf1*1000, 'g');
% plot(rscm(md-61:md)+mf2*1000, 'g');
% plot(rscm(md-61:md)+mf3*1000, 'g');
% [mf123 mf1 mf2 mf3]
% 
hold on;
bns=zeros(62,1);
for i=4:62
if facm2(i-2) < facm2(i-1) %fa1(i-2) > 0 && fa2(i-1) > 0 && fa1(i-3) < fa1(i-2) ...
         
    %facm2(i-2) < rslm(md-61+i-3) ... 
%         && facm1(i-1) < rscm(md-61+i-2) ...
%         && facm1(i-2) < facm1(i-1) ...
%         && facm1(i-1) > rslm(md-61+i-2)*.8 
           
    bns(i)=-1;
elseif facm2(i-2) > facm2(i-1) %fa1(i-2) < 0 && fa2(i-1) < 0 && fa1(i-3) > fa1(i-2) ...
          
    %facm2(i-2) > rshm(md-61+i-3) ... 
%         && facm1(i-1) > rshm(md-61+i-2) && fa1(i-1) > +.5
           
    bns(i)=+1;
else
    bns(i)=0;
end

end
plot(rscm(md-61:md).*bns, 'o', 'color', 'b');
plot(rscm(md-61:md).*(-bns), 'o', 'color', 'r');
plot(rscm(md-61:md)+(Trend(md-61:md).*1000), 'm');

axis([-Inf Inf mean(rscm(md-61:md))*0.8 mean(rscm(md-61:md))*1.2])
%%
close; 
figure('name', 'esn_test_mix', 'Position', [50,0,2000,900]);
hold on; plot(ones(62,1)*.4, 'k:'); plot(ones(62,1)*(-.4), 'k:');
% plot(fa1, 'g'), plot(fa2, 'color', [0 .7 .2])
% fa12=fa1;%-fa2; 
% fa12(61:62,1)=0; fa12(1:2,1)=0;
% fa12f=zeros(62,1);
% fa12f(5:62)=fa12(3:60);
fa12=fa2;%-fa2; 
fa12(62,1)=0; fa12(1:2,1)=0;
fa12f=zeros(62,1);
fa12f(4:62)=fa12(3:61);

plot(fa12f, 'o', 'color', 'b')
plot(fa12f, 'b:')
plot(Trend(md-61:md), 'm') 
plot((rscm(md-61:md)-mean(rscm(md-61:md)))/std(rscm(md-61:md)), 'k-.')
plot((rscm(md-61:md)-mean(rscm(md-61:md)))/std(rscm(md-61:md)), 'o', 'color', 'k')
% plot((rslm(md-61:md)-mean(rslm(md-61:md)))/std(rslm(md-61:md)), 'k:')
% plot((rshm(md-61:md)-mean(rshm(md-61:md)))/std(rshm(md-61:md)), 'k:')


%%
% hold off;

% for i=4:62
% if mf123(i-2)<0 ...
%         && (mf123(i-3) > mf123(i-2)) ...
%         && (mf123(i-2) > mf123(i-1)) ...
%         && (mf123(i-1) < mf123(i))
%     bns(i)=-1;
% elseif mf123(i-2)>0 ...
%         && (mf123(i-3) < mf123(i-2)) ...
%         && (mf123(i-2) < mf123(i-1)) ...
%         && (mf123(i-1) > mf123(i))
%     bns(i)=+1;
% else
%     bns(i)=0;
% end
% end
% for i=5:62
% if mf123(i-2)<0 ...
%         && (mf123(i-4) > mf123(i-3)) ...
%         && (mf123(i-3) > mf123(i-2)) ...
%         && (mf123(i-2) < mf123(i-1))
%     bns(i-1)=-1;
% elseif mf123(i-2)>0 ...
%         && (mf123(i-4) < mf123(i-3)) ...
%         && (mf123(i-3) < mf123(i-2)) ...
%         && (mf123(i-2) > mf123(i-1))
%     bns(i-1)=+1;
% else
%     bns(i-1)=0;
% end
% end
% for i=5:62
% if mf123(i-2) < 0 && mf123(i-1) < 0 ... 
%         && (mf123(i-4) > mf123(i-3)) ...
%         && (mf123(i-3) > mf123(i-2)) ...
%         && (mf123(i-2) < mf123(i-1))
%     bns(i-1)=-1;
% elseif mf123(i-2) > 0 && mf123(i-1) > 0 ... 
%         && (mf123(i-4) < mf123(i-3)) ...
%         && (mf123(i-3) < mf123(i-2)) ...
%         && (mf123(i-2) > mf123(i-1))
%     bns(i-1)=+1;
% else
%     bns(i-1)=0;
% end
% end
%%
% hold on;
% bns=zeros(62,1);
% for i=5:62
% if mf123(i-2) < rslm(md-61+i-3) && mf123(i-1) < rslm(md-61+i-2)  ... 
%         && (mf123(i-4) > mf123(i-3)) ...
%         && (mf123(i-3) > mf123(i-2)) ...
%         && (mf123(i-2) < mf123(i-1))
%     bns(i-1)=-1;
% elseif mf123(i-2) > rshm(md-61+i-3) && mf123(i-1) > rshm(md-61+i-2) ... 
%         && (mf123(i-4) < mf123(i-3)) ...
%         && (mf123(i-3) < mf123(i-2)) ...
%         && (mf123(i-2) > mf123(i-1))
%     bns(i-1)=+1;
% else
%     bns(i-1)=0;
% end
% end
% plot(rscm(md-61:md).*bns, 'o', 'color', 'b');
% plot(rscm(md-61:md).*(-bns), 'o', 'color', 'r');
% axis([-Inf Inf mean(rscm(md-61:md))*0.8 mean(rscm(md-61:md))*1.2])
% hold on;
% bns=zeros(62,1);
% for i=3:62
% if mfcm(i-2) < rshm(md-61+i-3) ... 
%         && mfcm(i-1) >= rshm(md-61+i-2)*.9 
%     bns(i)=+1;
% elseif mfcm(i-2) > rslm(md-61+i-3) ... 
%         && mfcm(i-1) <= rslm(md-61+i-2)*1.1 
%     bns(i)=-1;
% else
%     bns(i)=0;
% end
% end
% plot(rscm(md-61:md).*bns, 'o', 'color', 'c');
% plot(rscm(md-61:md).*(-bns), 'o', 'color', 'r');
% axis([-Inf Inf mean(rscm(md-61:md))*0.8 mean(rscm(md-61:md))*1.2])

%%
% close
% figure('name', 'esn_test_2day', 'Position', [100,150,1200,600]);
% plot(rscm(md-61:md), 'k'); hold on;
% % plot(rscm(md-61:md)+ff1(:,1)*1000,'o', 'color', 'r');
% % plot(rscm(md-61:md)+ff2(:,1)*1000,'o', 'color', 'g');
% % plot(rscm(md-61:md)+ff3(:,1)*1000,'o', 'color', 'b');
% % mf123=mean(ff1(:,2)+ff2(:,2)+ff3(:,2), 2);
% mf123=ff3(:,1)*5;
% plot(rscm(md-61:md)+mf123*1000, 'r');
% for i=1:62
% if mf123(i)<=0.5 && mf123(i)>=-0.5;
%     mf123c(i)=1;
% else
%     mf123c(i)=0;
% end
% end
% plot(rscm(md-61:md).*mf123c', 'o', 'color', 'b');
% axis([-Inf Inf mean(rscm(md-61:md))-10000 mean(rscm(md-61:md))+10000])
% 
% hold off;
%%
% close
% figure('name', 'esn_test_1day', 'Position', [100,150,1200,600]);
% plot(rscm(md-61:md), 'k'); hold on;
% plot(rscm(md-61:md)+ff1(:,2)*1000,'o', 'color', 'r');
% plot(rscm(md-61:md)+ff2(:,2)*1000,'o', 'color', 'g');
% plot(rscm(md-61:md)+ff3(:,2)*1000,'o', 'color', 'b');
% hold off;
% %%
% figure;
% plot(rscm(md-61:md)+mf1*1000, 'r');
% plot(rscm(md-61:md)+mf2*1000, 'b');
% plot(rscm(md-61:md)+mf3*1000, 'g');


%%



