% Create a ESN network. Call of this script returns: 
% 1. intWM0, sparse weight matrix of reservoir scaled to spectral radius 1, 
% 2. inWM random matrix of input-to-reservoir weights, 
% 3. ofbWM, output feedback weight matrix, 
% 4. initialOutWM all-zero initial weight matrix of reservoir-to-output units (is replaced
% by learnt weights as result of learning)

% note that variables netDim, inputLength, outputLength, connectivity must
% be set before this script is run (preferably by calling headers.m)


totalDim = netDim + inputLength + outputLength;

disp('Generating Network...');


% the following creation of intWM0 is tried three times 
% because the call of myeigs sometimes (about every 20th time) 
% fails with randomly created matrices. minusPoint5 is a little helper
% function that subtracts 0.5 from entries of a sparse matrix.
% myeigs is actually essentially the same as the Matlab "eigs" function,
% which I modified a bit by suppressing output; "eigs" is sometimes very
% verbose.

rng('default')

try,
    intWM0 = sprand(netDim, netDim, connectivity);
    intWM0 = spfun(@minusPoint5,intWM0);
    maxval1 = max(abs(eigs(intWM0,1)));
    intWM0 = intWM0/maxval1;
catch,
%     try,
%         intWM0 = sprand(netDim, netDim, connectivity);
%         intWM0 = spfun(@minusPoint5,intWM0);
%         maxval2 = max(abs(eigs(intWM0,1)));
%         intWM0 = intWM0/maxval2;
%     catch,
%         try,
%             intWM0 = sprand(netDim, netDim, connectivity);
%             intWM0 = spfun(@minusPoint5,intWM0);
%             maxval3 = max(abs(eigs(intWM0,1)));
%             intWM0 = intWM0/maxval3;
%         catch,
%         end
%     end
end

% intWM0 = rand(netDim, netDim);

%     intWM0 = spfun(@minusPoint5,intWM0);
%     maxval = max(abs(myeigs(intWM0,1)));
%     intWM0 = intWM0/maxval;


%% input weight matrix has weight vectors per input unit in colums

rng('default')

% inWM = 2.0 * rand(netDim, inputLength) - 1.0;
inWM_m1 = [(rand(netDim)*2-1)*1]; % [ones(netDim*0.2, 1); -ones(netDim*0.2, 1); zeros(netDim*0.6, 1)];
inWM_m2 = inWM_m1(:,1); inWM_m3 = inWM_m1(:,1); inWM_m4 = inWM_m1(:,1);
inWM_m5 = inWM_m1(:,1); inWM_m6 = inWM_m1(:,1); inWM_m7 = inWM_m1(:,1);
inWM_m8 = inWM_m1(:,1); inWM_m9 = inWM_m1(:,1); inWM_m10 = inWM_m1(:,1);
inWM_m11 = inWM_m1(:,1); inWM_m12 = inWM_m1(:,1); inWM_m13 = inWM_m1(:,1);
inWM_m14 = inWM_m1(:,1); inWM_m15 = inWM_m1(:,1); inWM_m16 = inWM_m1(:,1);
inWM_m17 = inWM_m1(:,1); inWM_m18 = inWM_m1(:,1); inWM_m19 = inWM_m1(:,1);
inWM_m20 = inWM_m1(:,1); inWM_m21 = inWM_m1(:,1); inWM_m22 = inWM_m1(:,1);
inWM_m23 = inWM_m1(:,1); inWM_m24 = inWM_m1(:,1); inWM_m25 = inWM_m1(:,1);


ord1 = randperm(netDim)'; ord2 = randperm(netDim)'; ord3 = randperm(netDim)'; 
ord4 = randperm(netDim)'; ord5 = randperm(netDim)'; ord6 = randperm(netDim)';
ord7 = randperm(netDim)'; ord8 = randperm(netDim)'; ord9 = randperm(netDim)'; 
ord10 = randperm(netDim)'; ord11 = randperm(netDim)'; ord12 = randperm(netDim)';
ord13 = randperm(netDim)'; ord14 = randperm(netDim)'; ord15 = randperm(netDim)';
ord16 = randperm(netDim)'; ord17 = randperm(netDim)'; ord18 = randperm(netDim)';
ord19 = randperm(netDim)'; ord20 = randperm(netDim)'; ord21 = randperm(netDim)';
ord22 = randperm(netDim)'; ord23 = randperm(netDim)'; ord24 = randperm(netDim)';
ord25 = randperm(netDim)';

inWM(:,1) = inWM_m1(ord1); inWM(:,2) = inWM_m2(ord2); inWM(:,3) = inWM_m3(ord3);
inWM(:,4) = inWM_m4(ord4); inWM(:,5) = inWM_m5(ord5); inWM(:,6) = inWM_m6(ord6);
inWM(:,7) = inWM_m7(ord7); inWM(:,8) = inWM_m8(ord8); inWM(:,9) = inWM_m9(ord9);
inWM(:,10) = inWM_m10(ord10); inWM(:,11) = inWM_m11(ord11); inWM(:,12) = inWM_m12(ord12);
inWM(:,13) = inWM_m13(ord13); inWM(:,14) = inWM_m14(ord14); inWM(:,15) = inWM_m15(ord15);
inWM(:,16) = inWM_m16(ord16); inWM(:,17) = inWM_m17(ord17); inWM(:,18) = inWM_m18(ord18);
inWM(:,19) = inWM_m19(ord19); inWM(:,20) = inWM_m20(ord20); inWM(:,21) = inWM_m21(ord21);
inWM(:,22) = inWM_m22(ord22); inWM(:,23) = inWM_m23(ord23); inWM(:,24) = inWM_m24(ord24);
inWM(:,25) = inWM_m25(ord25); % inWM(:,26) = inWM_m26(ord26); inWM(:,27) = inWM_m27(ord27);

inWM = inWM(:,1:inputLength);

%% output weight matrix has weights for output units in rows
% includes weights for input-to-output connections
% 입력에서 직접 출력으로 연결되는 부분을 포함하고 있음

initialOutWM = zeros(outputLength, netDim + inputLength + outputLength); 

%% output feedback weight matrix has weights in columns

rng('default')

ofbWM0 = (2.0 * rand(netDim, outputLength)- 1.0);

