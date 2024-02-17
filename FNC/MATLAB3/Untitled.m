cccc
load('pca_x');
pca_x(:,5:7)=-pca_x(:,5:7);
pcas=sum(pca_x(:,[1 7 14]), 2); 
% pcan=(pcas)/norm(pcas)*10;
% plot(pcan);
hold on; 
%%
load('rscm');
sell=zeros(1000,1); buy=zeros(1000,1);
for i = 1:1000
if pcas(i) > 1.5
    sell(i)=1;
elseif pcas(i) < -1.5
    buy(i)=1;
end
end
plot(rscm, 'k')
hold on;
 
bbuy = rscm(:,1).*buy; 
ssell = rscm(:,1).*sell;

for i=1:1000
    if buy(i) ~= 0
        plot(i,bbuy(i), 'o', 'color', 'r');
    elseif sell(i) ~= 0 
        plot(i,ssell(i), 'o', 'color', 'b');
    end
end
hold off
x=100; y=x+50;
axis([x y mean(rscm(x:y))*.8 mean(rscm(x:y))*1.2])
