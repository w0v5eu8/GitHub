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
% ����: sin in cos out
% ���: �Ϻ��ϰ� �Ϸ� �ռ� ������
% sampleinput = sin(1:1000);
% sampleout(1,:) = cos(1:1000);

% test 2
% ����: out cos ���ļ��� �ٲ�
% ���: ����� ������ ������ ������ ����ġ�� ũ�⿡ ���� �ణ�� ������ ���⳪, 
%       �Ϸ� �ռ� peak �� �����ϴ� �� ������ �Ϻ���
% sampleinput = sin(1:1000);
% sampleout(1,:) = cos(linspace(1,3000,1000));

% test 3
% ����: out �� ������ Trend �� �����ͼ� ��
% ���: �̷� ����. ���༺�� ��������� ���� indicator ���� in ���� �־��� ����
%       ������ ����� ��Ÿ�� - ��, ESN ��ü�� ������ �ִٴ� ��
% sampleinput = sin(1:1000);
% load('Trend.mat')
% sampleout(1,:) = Trend;

% test 4
% ����: in �� Trend ��, out �� sin ���� �ڹٲ㺽
% ���: 2���� �������� ��� - teacher �� ������ ���ΰ�?
% load('Trend.mat')
% sampleinput = Trend';
% sampleout(1,:) = sin(1:1000);

% test = 5;
% ����: in �� out �� �� �� Trend �� ������
% ���: ���Ű��� ����� ����.. �̷� ����� ������ ������?
% load('Trend.mat')
% sampleinput = Trend';
% sampleout(1,:) = Trend';

% test = 6;
% % ����: in=rscm, out=Trend
% % ���: 3���� ����� ���
% load('Trend.mat')
% load('rscm.mat')
% rscmn = manorm(rscm)-1;
% sampleinput = rscmn';
% sampleout(1,:) = Trend';

% test = 7;
% % ����: in=rand, out=Trend
% % ���: 6���� ����� ���.. rscm �̳� indicator ���� �ǹ̰� ���°ǰ�..?
% load('Trend.mat')
% sampleinput = (rand(1,1000)-.5)*2;
% sampleout(1,:) = Trend';

% test = 7;
% % ����: in=rand, out=cos
% % ���: ���༺�� �ְ�, �������� �� ���� - Ƽ�İ� ���� �Լ��ΰ� �����ε�?
% sampleinput = (rand(1,1000)-.5)*2;
% sampleout(1,:) = cos(linspace(1,3000,1000));

% test = 8;
% % ����: in=rand, out=Trend(spike)
% % ���: ��...
% sampleinput = (rand(1,1000)-.5)*2;
% load('Trend2.mat');
% sampleout(1,:) = Trend';

% test = 9;
% % ����: in=rand, out=Trend(zig-zag)
% % ���: ��...?
% sampleinput = (rand(1,1000)-.5)*2;
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 10;
% % ����: in=rscm, out=Trend(zig-zag)
% % ���: �� �� �������� ���⵵..? (������ ���༺�� �Ĵ޸��� ������)
% load('rscm.mat')
% rscmn = manorm(rscm)-1;
% sampleinput = rscmn';
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 11;
% % ����: in=rscm,rshm,rslm, out=Trend(zig-zag)
% % ���: �� �������� �ѵ�... ���� sin �� input ���� �־��.
% load('rscm.mat'); load('rshm.mat'); load('rslm.mat');
% rscmn = manorm(rscm)-1; rshmn = manorm(rshm)-1; rslmn = manorm(rslm)-1;
% sampleinput = [rscmn' ; rshmn' ; rslmn'];
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 12;
% % ����: in=sin, out=Trend(zig-zag)
% % ���: �� �������������� ���༺�� ������ �� ����...
% %       Ȯ���� ���� ESN ��ü�� teacher ��ȣ�� ���� �Ͱ� ������ ������ �ִµ�
% %       �� �ٽú��� 11�� ����� �� ���� �� ���⵵ �ϰ�... indicator �� �Ẹ��
% sampleinput = sin(1:1000);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 13;
% % ����: in=indicators(15), out=Trend(zig-zag)
% % ���: ���༺ �ָ�������, �������� Ȯ �پ��. �� �̷�����?
% load('t2t_pca.mat')
% sampleinput = t2t_pca;
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 14;
% % ����: in=indicators(2), out=Trend(zig-zag)
% % ���: ������ ������ ������, ���༺ ������
% load('t2t_pca.mat')
% sampleinput = t2t_pca(1:2,:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 15;
% % ����: in=indicators(2), out=Trend(zig-zag)
% % ���: ���༺, ������ �� �� �� ������ ����
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x(1:2,:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 16;
% % ����: in=indicators(15), out=Trend(zig-zag)
% % ���: ������ �� ������ - �ƹ��ų� �� ������ �� �ȴ�!
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x;
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 17;
% % ����: in=indicators(13), out=Trend(zig-zag)
% % ���: �״� ������ �� ���µ�..
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1:2 4 6:15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 18;
% % ����: in=indicators(4), out=Trend(zig-zag)
% % ���: ���༺�� �𸣰ڰ�, ������ ������ �� ������ - 0 �� ���� ���� in �� �����ε�
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 13 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 19;
% % ����: in=indicators(7), out=Trend(zig-zag)
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 5 6 7 13 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 20;
% % ����: in=indicators(3), out=Trend(zig-zag)
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([5 6 7],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 21;
% % ����: in=sum(pca_x), out=Trend(zig-zag)
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = sum(pca_x);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 22;
% % ����: in=Trend(zig-zag), out=Trend(zig-zag)
% % ���: �߻���
% load('Trend3.mat');
% sampleinput = Trend';
% sampleout(1,:) = Trend';

% test = 23;
% % ����: in=Trend(zig-zag)+noise, out=Trend(zig-zag)
% % ���: �߻����� �ʴµ� ��������
% load('Trend3.mat');
% sampleinput = Trend' + (rand(1,1496)-.5)*2;
% sampleout(1,:) = Trend';

% test = 24;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 25;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([2],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 26;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 27;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 28;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([13],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 29;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([5],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 30;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: ����!!!!
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([6],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 31;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([7],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 32;
% % ����: in=indicator(1), out=Trend(zig-zag)
% % ���: not bad
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([8],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 33;
% % ����: in=indicator(7), out=Trend(zig-zag)
% % ���: �۾���
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 7 8 13 14 15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 34;
% % ����: in=indicator(3), out=Trend(zig-zag)
% % ���: �� �� ����������?
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 35;
% % ����: in=indicator(6), out=Trend(zig-zag)
% % ���: ���� �۾���..
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 4 5 6 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 36;
% % ����: in=indicator(4), out=Trend(zig-zag)
% % ���: ��������.. 4���� �����ε�?
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 4 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 37;
% % ����: in=indicator(2), out=Trend(zig-zag)
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 38;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 39;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 40;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = .5
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 41;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 1
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 42;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 2
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 43;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 5
% % ���: 42�� ���� ����
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 44;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 5, net = 100
% % ���: 42�� ���� ����
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 45;
% % ����: in=indicator(2), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 42�� ���� ����
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 46;
% % ����: in=indicator(3), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 47;
% % ����: in=indicator(7), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 2 7 8 13 14 15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 47;
% % ����: in=indicator(7), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1 4 5 6 7 14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 48;
% % ����: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([1],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 50;
% % ����: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([14],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 52;
% % ����: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([15],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 54;
% % ����: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([13],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

% test = 54;
% % ����: in=indicator(1), out=Trend(zig-zag)
% %       noise = 0, connec = 2, net = 100
% % ���: 
% load('pca_x.mat'); pca_x = pca_x';
% sampleinput = pca_x([4],:);
% load('Trend3.mat');
% sampleout(1,:) = Trend';

test = 56;
% ����: in=indicator(1), out=Trend(zig-zag)
%       noise = 0, connec = 2, net = 100
% ���: 
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

