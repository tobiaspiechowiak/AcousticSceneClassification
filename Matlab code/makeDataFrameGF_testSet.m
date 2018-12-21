
addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Scenes_testing.mat'));
den = 1;
freqRange = [0 1e4];
[nrChannel, cf] = getGFBMultipleCenterERBs([0 1e4],den);
blkSize = 32;
fsDsp = 20833;

TestingVector = [];


%% Gammatone processing mix
gamma = [];
for idxEar = 1:2
    sprintf('Ear %.2d',idxEar)
    for idxMic = 1:3
        sprintf('Mic %.2d',idxMic)
        tmp = GammaProc(mix(idxEar).mic(idxMic).testing,freqRange(1),freqRange(2),den,fsDsp);
        for idxChannel = 1:nrChannel
            sprintf('Channel voice %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
end
TestingVector = [TestingVector; gamma];


TestingVector = single(TestingVector);

disp('Saving wav and csv')
audiowrite(strcat(path,'ERB=',num2str(den),'_mixed.wav'),TestingVector,fsDsp);%('Data_EBR=2.csv',TrainingVector);








