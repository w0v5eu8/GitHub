clear global buy_esn sell_esn prr_esn no no_ss prr_bnh
% initialRunlength: initial update cycles where network is driven by
% teacher data; internal signals obtained here are discarded before
% learning (= washout of initial transients)
% ��Ʈ��ũ�� 'Ƽ��' �����Ϳ� ���� ���ư��� �ʱ� ������Ʈ ����Ŭ
% ���⼭ ����� �ʱ� ��ȣ�� �н� ���� ������

% number of update steps used for computing output weights
% sampleRunlength = 1000;
% �ƿ�ǲ ����ġ�� ����ϱ� ���� ���Ǵ� ���� ������Ʈ Ƚ��

% plotRunlength is the length of the testing sequence. Data from this
% sequence are used for generating various result plots and for computing
% test performance statistics
% plotRunlength = 100;
% ����� �׽�Ʈ�� ���� �κ�

plotStates = [1 2 3 4]; % plot internal network states of ...
% units indicated in row vector; maximally 4 are plotted.
% Data from plotRunlength are plotted

% inputscaling is column vector of dimension of input
% inputscaling = [0.1;0.5];
% % inputshift is column vector of dimension of input
% inputshift = [0;1];

% % teacherscaling is column vector of dimension of output
% teacherscaling = [0.3;0.3];
% % teachershift is column vector of dimension of output
% teachershift = [-.2;-0.2];

disp('Learning...');
% disp(sprintf('netDim = %g   specRad =  %g   noise = %g    ',...
%     netDim, specRad, noiselevel));
% disp(sprintf('output feedback Scaling = %s', num2str(ofbSC')));
% disp(sprintf('inSC = %s', num2str(inputscaling')));
% disp(sprintf('inShift = %s', num2str(inputshift')));
% disp(sprintf('teacherSC = %s', num2str(teacherscaling')));
% disp(sprintf('teachershift = %s', num2str(teachershift')));
% disp(sprintf('WienerHopf = %g   linearOuts = %g   linearNet = %g',...
%     WienerHopf,linearOutputUnits, linearNetwork));
% disp(sprintf('initRL = %g  sampleRL = %g  plotRL = %g  ',...
%     initialRunlength, sampleRunlength, plotRunlength));


totalstate = zeros(totalDim,1); totalstate_sim = zeros(totalDim,1);
internalState = totalstate(1:netDim); internalState_sim = totalstate(1:netDim);

intWM = intWM0 * specRad;
ofbWM = ofbWM0 * diag(ofbSC);
outWM = initialOutWM;

stateCollectMat = zeros(sampleRunlength, netDim + inputLength + outputLength);
stateCollectMat_sim = zeros(sampleRunlength, netDim + inputLength + outputLength);
% ���ü���ŭ ��Ʈ��ũ+�Է�'+���'���κ��� ���� ����
teachCollectMat = zeros(sampleRunlength, outputLength);
teachCollectMat_sim = zeros(sampleRunlength, outputLength);
% ���ü���ŭ ������κ��� ���� ����

teacherPL = zeros(outputLength, plotRunlength); % ������ �÷�(2x100)
netOutPL = zeros(outputLength, plotRunlength); % �� ��� �÷�(2x100) --> ���߿� ������ �÷԰� ����
if inputLength > 0
    inputPL = zeros(inputLength, plotRunlength); % �Է� �÷�(2x100)
end
statePL = zeros(length(plotStates),plotRunlength); % ���� �÷�(4x100)
plotindex = 0;

msetest = zeros(1,outputLength); msetrain = zeros(1,outputLength);
msetest_sim = zeros(1,outputLength); msetrain_sim = zeros(1,outputLength);

netOut = zeros(1,outputLength);
netOut_sim = zeros(1,outputLength);

sampleout_ori = sampleout;

howlon = 30;

for i0_esn = 2:initialRunlength + sampleRunlength + freeRunlength + plotRunlength
    
    sampleout = sampleout_ori;
    
    if abs(round(sampleout(i0_esn - 1))) == 1 && i0_esn > simt
        
        sampleout(i0_esn:initialRunlength + sampleRunlength + freeRunlength + plotRunlength) = 0;
        simn = i0_esn;
        
        if i0_esn < initialRunlength + sampleRunlength + freeRunlength + plotRunlength - howlon
            
            for i_esn = 1:i0_esn + howlon; % initialRunlength + sampleRunlength + freeRunlength + plotRunlength
                
                
                if i_esn > 40
                    ifff =  buy(i_esn-1) ==1 || sell(i_esn-1) ==1 || buy(i_esn-2) ==1 || sell(i_esn-2) ==1 || ...
                        buy(i_esn-3) ==1 || sell(i_esn-3) ==1 || buy(i_esn-4) ==1 || sell(i_esn-4) ==1 || ...
                        buy(i_esn-5) ==1 || sell(i_esn-5) ==1 || buy(i_esn-6) ==1 || sell(i_esn-6) ==1 || ...
                        buy(i_esn-7) ==1 || sell(i_esn-7) ==1 || buy(i_esn-8) ==1 || sell(i_esn-8) ==1 || ...
                        buy(i_esn-9) ==1 || sell(i_esn-9) ==1 || buy(i_esn-10) ==1 || sell(i_esn-10) ==1 || ...
                        buy(i_esn-11) ==1 || sell(i_esn-11) ==1 || buy(i_esn-12) ==1 || sell(i_esn-12) ==1 || ...
                        buy(i_esn-13) ==1 || sell(i_esn-13) ==1 || buy(i_esn-14) ==1 || sell(i_esn-14) ==1 || ...
                        buy(i_esn-15) ==1 || sell(i_esn-15) ==1 || buy(i_esn-16) ==1 || sell(i_esn-16) ==1 || ...
                        buy(i_esn-17) ==1 || sell(i_esn-17) ==1 || buy(i_esn-18) ==1 || sell(i_esn-18) ==1 || ...
                        buy(i_esn-19) ==1 || sell(i_esn-19) ==1 || buy(i_esn-20) ==1 || sell(i_esn-20) ==1 || ...
                        buy(i_esn-21) ==1 || sell(i_esn-21) ==1 || buy(i_esn-22) ==1 || sell(i_esn-22) ==1 || ...
                        buy(i_esn-23) ==1 || sell(i_esn-23) ==1 || buy(i_esn-24) ==1 || sell(i_esn-24) ==1 || ...
                        buy(i_esn-25) ==1 || sell(i_esn-25) ==1 || buy(i_esn-26) ==1 || sell(i_esn-26) ==1 || ...
                        buy(i_esn-27) ==1 || sell(i_esn-27) ==1 || buy(i_esn-28) ==1 || sell(i_esn-28) ==1 || ...
                        buy(i_esn-29) ==1 || sell(i_esn-29) ==1 || buy(i_esn-30) ==1 || sell(i_esn-30) ==1 || ...
                        buy(i_esn-31) ==1 || sell(i_esn-31) ==1 || buy(i_esn-32) ==1 || sell(i_esn-32) ==1 || ...
                        buy(i_esn-33) ==1 || sell(i_esn-33) ==1 || buy(i_esn-34) ==1 || sell(i_esn-34) ==1 || ...
                        buy(i_esn-35) ==1 || sell(i_esn-35) ==1 || buy(i_esn-36) ==1 || sell(i_esn-36) ==1 || ...
                        buy(i_esn-37) ==1 || sell(i_esn-37) ==1 || buy(i_esn-38) ==1 || sell(i_esn-38) ==1 || ...
                        buy(i_esn-39) ==1 || sell(i_esn-39) ==1 || buy(i_esn-40) ==1 || sell(i_esn-40) ==1;
                    
                end
                
                
                %% in & teach
                % �� �κ��� in �� teach �� �����ϸ�, ������ �����ϸ� �� �� ����Ʈ ��Ŵ
                % in �� �����Է¿� ���� �����Ǹ� teach �� ������¿� ���� ������
                
                if inputLength > 0
                    in = sampleinput(:,i_esn);  % in is column vector
                else in = [];
                end
                
                if i_esn <= initialRunlength + sampleRunlength - 1
                    teach = sampleout(:,i_esn + 1);  % teach is column vector
                    teach_f = sampleout(:,i_esn);
                end
                
                totalstate(netDim+inputLength+1 : netDim+inputLength+outputLength) = teach_f;
                if i_esn >= i0_esn
                    totalstate(netDim+inputLength+1 : netDim+inputLength+outputLength) = netOut;
                end
                
                
                %% write input into totalstate
                
                if inputLength > 0
                    totalstate(netDim+1:netDim+inputLength) = in;
                end
                
                
                %% update totalstate except at input positions
                % i�� 1100�� ������ ������
                % ���λ��¸� (�� ����*[����,�Է�,����ǵ�� ����ġ])�� ���� ��ġ�� ������
                
                internalState = 1 ./ ( 1 + (exp( -2*([intWM, inWM, ofbWM]*totalstate)   ...
                    + noiselevel * 2.0 * (rand(netDim,1) - 0.5)) ) );
                
                
                %% totalstate (updates internalState)
                
                totalstate = [internalState ; in ; netOut];
                
                
                %% stateCollect & teachCollectMat
                
                if (i_esn > initialRunlength) && i_esn < i0_esn - 1
                    
                    collectIndex = i_esn - initialRunlength; % ��ȣ �̷� �����!
                    
                    stateCollectMat(collectIndex,:) = [internalState' in' netOut'];
                    
                    teachCollectMat(collectIndex,:) = teach';
                    
                end % collect states
                
                
                %% update msetest
                
                if i_esn >= i0_esn
                    for j = 1:outputLength
                        msetest(1,j) = msetest(1,j) + (teach_f(j,1)- netOut(j,1))^2;
                    end
                end
                
                
                %% compute new model --> outWM
                
                outWM = (pinv(stateCollectMat) * teachCollectMat)';
                
                
                %% netOut
                % �� ����� ���λ��¿� in�� ��°���ġ�� �ݿ��� ������ �����Ǹ�
                % [���λ���;in;�� ���]�� �� ���¸� ������
                % �н��� ���ȿ��� �� ��� ��� teach �� ����!
                
                netOut = (outWM * [internalState ; in ; netOut]);
                
                thresh = 1.2;
                if netOut > thresh
                    netOut = thresh;
                elseif netOut < -thresh
                    netOut = -thresh;
                end
                
                
                %% compute mean square errors on the training data using the newly computed weights
                
                for j = 1:outputLength
                    if i_esn > simt && i_esn < i0_esn
                        msetrain(1,j) = sum((teachCollectMat(:,j) - ...
                            (stateCollectMat * outWM(j,:)')).^2);
                    end
                    msetrain(1,j) = msetrain(1,j) / i0_esn - simt; % ��/n=���
                end
                
                
                %% check results
                
                %     sc(i_esn,simn) = sum(stateCollectMat);
                %     tc(i_esn,simn) = teachCollectMat;
                %     is(i_esn,simn) = internalState;
                %     ts(i_esn,simn) = totalstate;
                no(i_esn,simn) = netOut;
                %     ow(i_esn,simn) = outWM;
            end
            
            
        elseif i0_esn >= initialRunlength + sampleRunlength + freeRunlength + plotRunlength - howlon
            
            for rd = 1:howlon
                if i0_esn == initialRunlength + sampleRunlength + freeRunlength + plotRunlength - rd
                    for i_esn = 1:i0_esn + rd; % initialRunlength + sampleRunlength + freeRunlength + plotRunlength
                        
                        
                        if i_esn > 40
                            ifff =  buy(i_esn-1) ==1 || sell(i_esn-1) ==1 || buy(i_esn-2) ==1 || sell(i_esn-2) ==1 || ...
                                buy(i_esn-3) ==1 || sell(i_esn-3) ==1 || buy(i_esn-4) ==1 || sell(i_esn-4) ==1 || ...
                                buy(i_esn-5) ==1 || sell(i_esn-5) ==1 || buy(i_esn-6) ==1 || sell(i_esn-6) ==1 || ...
                                buy(i_esn-7) ==1 || sell(i_esn-7) ==1 || buy(i_esn-8) ==1 || sell(i_esn-8) ==1 || ...
                                buy(i_esn-9) ==1 || sell(i_esn-9) ==1 || buy(i_esn-10) ==1 || sell(i_esn-10) ==1 || ...
                                buy(i_esn-11) ==1 || sell(i_esn-11) ==1 || buy(i_esn-12) ==1 || sell(i_esn-12) ==1 || ...
                                buy(i_esn-13) ==1 || sell(i_esn-13) ==1 || buy(i_esn-14) ==1 || sell(i_esn-14) ==1 || ...
                                buy(i_esn-15) ==1 || sell(i_esn-15) ==1 || buy(i_esn-16) ==1 || sell(i_esn-16) ==1 || ...
                                buy(i_esn-17) ==1 || sell(i_esn-17) ==1 || buy(i_esn-18) ==1 || sell(i_esn-18) ==1 || ...
                                buy(i_esn-19) ==1 || sell(i_esn-19) ==1 || buy(i_esn-20) ==1 || sell(i_esn-20) ==1 || ...
                                buy(i_esn-21) ==1 || sell(i_esn-21) ==1 || buy(i_esn-22) ==1 || sell(i_esn-22) ==1 || ...
                                buy(i_esn-23) ==1 || sell(i_esn-23) ==1 || buy(i_esn-24) ==1 || sell(i_esn-24) ==1 || ...
                                buy(i_esn-25) ==1 || sell(i_esn-25) ==1 || buy(i_esn-26) ==1 || sell(i_esn-26) ==1 || ...
                                buy(i_esn-27) ==1 || sell(i_esn-27) ==1 || buy(i_esn-28) ==1 || sell(i_esn-28) ==1 || ...
                                buy(i_esn-29) ==1 || sell(i_esn-29) ==1 || buy(i_esn-30) ==1 || sell(i_esn-30) ==1 || ...
                                buy(i_esn-31) ==1 || sell(i_esn-31) ==1 || buy(i_esn-32) ==1 || sell(i_esn-32) ==1 || ...
                                buy(i_esn-33) ==1 || sell(i_esn-33) ==1 || buy(i_esn-34) ==1 || sell(i_esn-34) ==1 || ...
                                buy(i_esn-35) ==1 || sell(i_esn-35) ==1 || buy(i_esn-36) ==1 || sell(i_esn-36) ==1 || ...
                                buy(i_esn-37) ==1 || sell(i_esn-37) ==1 || buy(i_esn-38) ==1 || sell(i_esn-38) ==1 || ...
                                buy(i_esn-39) ==1 || sell(i_esn-39) ==1 || buy(i_esn-40) ==1 || sell(i_esn-40) ==1;
                        end
                        
                        
                        %% in & teach
                        % �� �κ��� in �� teach �� �����ϸ�, ������ �����ϸ� �� �� ����Ʈ ��Ŵ
                        % in �� �����Է¿� ���� �����Ǹ� teach �� ������¿� ���� ������
                        
                        if inputLength > 0
                            in = sampleinput(:,i_esn);  % in is column vector
                        else in = [];
                        end
                        
                        if i_esn <= initialRunlength + sampleRunlength - 1
                            teach = sampleout(:,i_esn + 1);  % teach is column vector
                            teach_f = sampleout(:,i_esn);
                        end
                        
                        totalstate(netDim+inputLength+1 : netDim+inputLength+outputLength) = teach_f;
                        if i_esn >= i0_esn
                            totalstate(netDim+inputLength+1 : netDim+inputLength+outputLength) = netOut;
                        end
                        
                        
                        %% write input into totalstate
                        
                        if inputLength > 0
                            totalstate(netDim+1:netDim+inputLength) = in;
                        end
                        
                        
                        %% update totalstate except at input positions
                        % i�� 1100�� ������ ������
                        % ���λ��¸� (�� ����*[����,�Է�,����ǵ�� ����ġ])�� ���� ��ġ�� ������
                        
                        internalState = 1 ./ ( 1 + (exp( -2*([intWM, inWM, ofbWM]*totalstate)   ...
                            + noiselevel * 2.0 * (rand(netDim,1) - 0.5)) ) );
                        
                        if i_esn >= i0_esn
                            internalState = 1 ./ ( 1 + (exp( -2*([intWM, inWM, ofbWM]*totalstate)   ...
                                + noiselevel * 2.0 * (rand(netDim,1) - 0.5)) ) );
                        end
                        
                        
                        %% totalstate (updates internalState)
                        
                        totalstate = [internalState ; in ; netOut];
                        
                        
                        %% collect states and results for later use in learning procedure
                        
                        if (i_esn > initialRunlength) && i_esn < i0_esn - 1 % (i_esn <= initialRunlength + sampleRunlength)
                            
                            collectIndex = i_esn - initialRunlength; % ��ȣ �̷� �����!
                            
                            stateCollectMat(collectIndex,:) = [internalState' in' netOut']; %fill a row
                            
                            teachCollectMat(collectIndex,:) = teach';
                            
                        end % collect states
                        
                        
                        %% update msetest
                        
                        if i_esn >= i0_esn % initialRunlength + sampleRunlength + freeRunlength
                            for j = 1:outputLength
                                msetest(1,j) = msetest(1,j) + (teach_f(j,1)- netOut(j,1))^2;
                            end
                        end
                        
                        
                        %% compute new model --> outWM
                        % '��� ����ġ'�� ���������� ����/���� ���������κ��� ����
                        
                        %     if i == initialRunlength + sampleRunlength
                        %     �� �κ��� �򰥸� --> �� (�ʱ�+)�н����� ������ �������� outWM�� ����ϴ°�???
                        
                        outWM = (pinv(stateCollectMat) * teachCollectMat)';
                        
                        
                        %% netOut
                        % �� ����� ���λ��¿� in�� ��°���ġ�� �ݿ��� ������ �����Ǹ�
                        % [���λ���;in;�� ���]�� �� ���¸� ������
                        % �н��� ���ȿ��� �� ��� ��� teach �� ����!
                        
                        netOut = (outWM * [internalState ; in ; netOut]);
                        
                        thresh = 1.2;
                        if netOut > thresh
                            netOut = thresh;
                        elseif netOut < -thresh
                            netOut = -thresh;
                        end
                        
                        
                        %% compute mean square errors on the training data using the newly computed weights
                        
                        for j = 1:outputLength
                            if i_esn > simt && i_esn < i0_esn
                                msetrain(1,j) = sum((teachCollectMat(:,j) - ...
                                    (stateCollectMat * outWM(j,:)')).^2);
                            end
                            msetrain(1,j) = msetrain(1,j) / i0_esn - simt; % ��/n=���
                        end
                        
                        
                        %% check results
                        
                        %     sc(i_esn,simn) = sum(stateCollectMat);
                        %     tc(i_esn,simn) = teachCollectMat;
                        %     is(i_esn,simn) = internalState;
                        %     ts(i_esn,simn) = totalstate;
                        no(i_esn,simn) = netOut;
                        %     ow(i_esn,simn) = outWM;
                    end
                end
            end
            
        end
        
    end
end
%end of the great do-loop

sampleout = sampleout_ori;


% print diagnostics in terms of normalized RMSE (root mean square error)

msetestresult = msetest / (sampleRunlength + plotRunlength);
teacherVariance = var(teacherPL');
% disp(sprintf('train NRMSE = %s', num2str(sqrt(msetrain ./ teacherVariance))));
% disp(sprintf('test NRMSE = %s', num2str(sqrt(msetestresult ./ teacherVariance))));
disp(sprintf('average output weights = %s', num2str(mean(abs(outWM')))));


%% save

cc=clock;
ccc=cc(2:5);
% save(['ESNed_',num2str(stm),'_',num2str(ccc)])
