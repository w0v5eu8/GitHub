%%
clear
close all
clc
%%
% header infos for controller learning, for tent map example

%%%%%%% createEmptyFigs
%%%%%%% generateNet
netDim = 100; connectivity = 0.1; inputLength = 1; outputLength = 1;
%%%%%%% generateTrainTestDataTentMap
samplelength = 5000;
%%%%%%% learnAndTest
specRad = 0.8; ofbSC = [30]; noiselevel = 0.00001; 
linearOutputUnits = 0; linearNetwork = 0; WienerHopf = 1; 
initialRunlength = 100; sampleRunlength = 1000; freeRunlength = 0; plotRunlength = 100;
inputscaling = [1]; inputshift = [0];
teacherscaling = [1]; teachershift = [-.5];
%%
run createEmptyFigs.m
run generateNet.m
run generateTrainTestDataTentMap.m
%%
run learnAndTest.m
%%
run continueRun.m
