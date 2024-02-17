% Version from 2004/02/27, Herbert Jaeger

% %%%% generate training and testing time series for ESN training
% The learning-and-testing script learn.m expects data to be contained in
% two matrices named sampleinput (of size inputdim x samplelength) and
% sampleout (of size outputdim x samplelength). Such two matrices must be
% the result of calling this script.

% Note: the script learn.m does training AND testing. Training is done with
% an initial sequence of the data generated here, testing is done on
% remaining data. Therefore, the samplelength should be chosen of
% sufficient length to provide data for both training and  testing.

% in this demo example, we create such data from a simple NARMA equation.

disp('Generating Input & Output data...');

%% create random input sequence (row data)

% sampleinput = rscmn';

% test 1
% 조건: sin in cos out
% 결과: 완벽하게 하루 앞서 예측함
% sampleinput = sin(1:1000);
% sampleout(1,:) = cos(1:1000);

% test 2
% 조건: out cos 주파수를 바꿈
% 결과: 결과의 스케일 변동성 때문에 예측치의 크기에 아주 약간의 오류가 생기나, 
%       하루 앞서 peak 을 예측하는 건 여전히 완벽함
% sampleinput = sin(1:1000);
% sampleout(1,:) = cos(linspace(1,3000,1000));

% test 3
% 조건: out 을 임의의 Trend 를 가져와서 씀
% 결과: 이런 씨발. 선행성은 사라지지만 실제 indicator 들을 in 으로 넣었을 때랑
%       유사한 결과가 나타남 - 즉, ESN 자체에 문제가 있다는 것
% sampleinput = sin(1:1000);
% load('Trend.mat')
% sampleout(1,:) = Trend;

% test 4
% 조건: in 을 Trend 로, out 을 sin 으로 뒤바꿔봄
% 결과: 2번과 마찬가지 결과 - teacher 가 문제인 것인가?
% load('Trend.mat')
% sampleinput = Trend';
% sampleout(1,:) = sin(1:1000);

% test = 5;
% 조건: in 과 out 을 둘 다 Trend 로 설정함
% 결과: 병신같은 결과가 나옴.. 이런 결과가 나오는 이유는?
% load('Trend.mat')
% sampleinput = Trend';
% sampleout(1,:) = Trend';

% test = 6;
% % 조건: in=rscm, out=Trend
% % 결과: 3번과 비슷한 결과
% load('Trend.mat')
% load('rscm.mat')
% rscmn = manorm(rscm)-1;
% sampleinput = rscmn';
% sampleout(1,:) = Trend';

% test = 7;
% % 조건: in=rand, out=Trend
% % 결과: 6번과 비슷한 결과.. rscm 이나 indicator 들이 의미가 없는건가..?
% load('Trend.mat')
% sampleinput = (rand(1,1000)-.5)*2;
% sampleout(1,:) = Trend';

% test = 7;
% % 조건: in=rand, out=cos
% % 결과: 선행성은 있고, 스케일이 좀 망함 - 티쳐가 스텝 함수인게 문제인듯?
% sampleinput = (rand(1,1000)-.5)*2;
% sampleout(1,:) = cos(linspace(1,3000,1000));

% test = 8;
% % 조건: in=rand, out=Trend(spike)
% % 결과: 음...
% sampleinput = (rand(1,1000)-.5)*2;
% load('Trend2.mat');
% sampleout(1,:) = Trend';

% test = 9;
% % 조건: in=rand, out=Trend(zig-zag)
% % 결과: 음...?
% sampleinput = (rand(1,1000)-.5)*2;
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 10;
% % 조건: in=rscm, out=Trend(zig-zag)
% % 결과: 올 좀 나아진거 같기도..? (여전히 선행성이 후달리긴 하지만)
% load('rscm.mat')
% rscmn = manorm(rscm)-1;
% sampleinput = rscmn';
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 11;
% % 조건: in=rscm,rshm,rslm, out=Trend(zig-zag)
% % 결과: 좀 나아지긴 한듯... 이제 sin 을 input 으로 넣어보자.
% load('rscm.mat'); load('rshm.mat'); load('rslm.mat');
% rscmn = manorm(rscm)-1; rshmn = manorm(rshm)-1; rslmn = manorm(rslm)-1;
% sampleinput = [rscmn' ; rshmn' ; rslmn'];
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 12;
% % 조건: in=sin, out=Trend(zig-zag)
% % 결과: 좀 그지같아지지만 선행성은 오히려 더 좋음...
% %       확실히 현재 ESN 자체가 teacher 신호를 쓰는 것과 관련한 문제가 있는듯
% %       음 다시보면 11번 결과가 더 나은 것 같기도 하고... indicator 를 써보자
% sampleinput = sin(1:1000);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 13;
% % 조건: in=indicators(15), out=Trend(zig-zag)
% % 결과: 선행성 애매해지고, 스케일이 확 줄어듦. 왜 이런거지?
% load('t2t_pca.mat')
% sampleinput = t2t_pca;
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 14;
% % 조건: in=indicators(2), out=Trend(zig-zag)
% % 결과: 스케일 여전히 구리고, 선행성 없어짐
% load('t2t_pca.mat')
% sampleinput = t2t_pca(1:2,:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 15;
% % 조건: in=indicators(2), out=Trend(zig-zag)
% % 결과: 선행성, 스케일 둘 다 좀 나아짐 ㅋㅋ
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x(1:2,:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 16;
% % 조건: in=indicators(15), out=Trend(zig-zag)
% % 결과: 오히려 더 구려짐 - 아무거나 막 넣으면 안 된다!
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x;
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 17;
% % 조건: in=indicators(13), out=Trend(zig-zag)
% % 결과: 그닥 나아진 게 없는듯..
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1:2 4 6:15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 18;
% % 조건: in=indicators(4), out=Trend(zig-zag)
% % 결과: 선행성은 모르겠고, 스케일 문제는 좀 나아짐 - 0 이 많이 들어가는 in 이 문제인듯
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 13 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 19;
% % 조건: in=indicators(7), out=Trend(zig-zag)
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 5 6 7 13 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 20;
% % 조건: in=indicators(3), out=Trend(zig-zag)
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([5 6 7],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 21;
% % 조건: in=sum(pca_x), out=Trend(zig-zag)
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = sum(pca_x);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 22;
% % 조건: in=Trend(zig-zag), out=Trend(zig-zag)
% % 결과: 발산함
% load('Trend3.mat');
% sampleinput = Trend';
% sampleout(1,:) = Trend';

% test = 23;
% % 조건: in=Trend(zig-zag)+noise, out=Trend(zig-zag)
% % 결과: 발산하진 않는데 그지같음
% load('Trend3.mat');
% sampleinput = Trend' + (rand(1,1496)-.5)*2;
% sampleout(1,:) = Trend';

% test = 24;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 25;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([2],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 26;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 27;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 28;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([13],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 29;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([5],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 30;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: 구려!!!!
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([6],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 31;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([7],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 32;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% % 결과: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([8],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 33;
% % 조건: in=indicator(7), out=Trend(zig-zag)
% % 결과: 작아짐
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 7 8 13 14 15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 34;
% % 조건: in=indicator(3), out=Trend(zig-zag)
% % 결과: 음 좀 괜찮아진듯?
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 35;
% % 조건: in=indicator(6), out=Trend(zig-zag)
% % 결과: 졸라 작아짐..
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 4 5 6 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 36;
% % 조건: in=indicator(4), out=Trend(zig-zag)
% % 결과: 그지같음.. 4번이 문제인듯?
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 4 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 37;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 38;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 39;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 40;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = .5
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 41;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 1
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 42;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 2
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 43;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 5
% % 결과: 42와 차이 없음
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 44;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 5, net = 100
% % 결과: 42와 차이 없음
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 45;
% % 조건: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 42와 차이 없음
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 46;
% % 조건: in=indicator(3), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 47;
% % 조건: in=indicator(7), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 7 8 13 14 15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 47;
% % 조건: in=indicator(7), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 4 5 6 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 48;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 50;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 52;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 54;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([13],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 54;
% % 조건: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % 결과: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([4],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

test = 56;
% 조건: in=indicator(1), out=Trend(zig-zag)
%       noise = 0, connec = 2, net = 100
% 결과: 
load('pca_x.mat'); pca_x = pca_x';
sampleinput = pca_x([5],:);
load('Trend3.mat');
sampleout(1,:) = Trend';

%% use this input sequence to drive a NARMA equation
% systemorder = 10;
% sampleout = 0.1*ones(2,samplelength);
% for n = systemorder +1 : samplelength
%     % insert suitable NARMA equation on r.h.s.
% %     sampleout(1,n) = sampleinput(2,n-5) * sampleinput(2,n-10) ...
% %         + sampleinput(2,n-2) * sampleout(2,n-2);
%     sampleout(2,n) = sampleinput(2,n-1) * sampleinput(2,n-3) ...
%         + sampleinput(2,n-2) * sampleout(1,n-2);
% end

% Trend(980:1000,1) = 0;
% sampleout(1,:) = Trend'; 

%% normalize input to range [-1,1]
% for indim = 1:length(sampleinput(:,1))
%     maxVal = max(sampleinput(indim,:)); minVal = min(sampleinput(indim,:));
%     if maxVal - minVal > 0
%       sampleinput(indim,:) = ((sampleinput(indim,:) - minVal)/(maxVal - minVal)-0.5)*2;
%     end
% end

%% normalize output to range [-1,1]
% for outdim = 1:length(sampleout(:,1))
%     maxVal = max(sampleout(outdim,:)); minVal = min(sampleout(outdim,:));
%     if maxVal - minVal > 0
%        sampleout(outdim,:) = ((sampleout(outdim,:) - minVal)/(maxVal - minVal)-0.5)*2;
%     end
% end

%% plot generated sampleinput
% figure(6); clf;
% indim = length(sampleinput(:,1));
% for k = 1:indim
%     subplot(indim, 1, k);
%     plot(sampleinput(k,:));
%     if k == 1
%         title('sampleinput','FontSize',8);
%     end
% end

%% plot generated sampleout
% figure(1); clf;
% outdim = length(sampleout(:,1));
% for k = 1:outdim
%     subplot(outdim, 1, k);
%     plot(sampleout(k,:));
%     if k == 1
%         title('sampleout','FontSize',8);
%     end
% end

