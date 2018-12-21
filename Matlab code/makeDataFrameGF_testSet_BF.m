
addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Scenes_mix.mat'));
den = 2;
freqRange = [0 1e4];
[nrChannel, cf] = getGFBMultipleCenterERBs([0 1e4],den);
blkSize = 32;
fsDsp = 20833;

TestingVector = [];


%% Gammatone processing mix Unilateral beamformer
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        sprintf('Mic %.2d',idxMic)
        tmp = GammaProc(FD(idxEar).ownVoice.mix,freqRange(1),freqRange(2),den,fsDsp);
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

disp('Saving wav...')
audiowrite(strcat(path,'ERB=',num2str(den),'_mixed_uniBF.wav'),TestingVector,fsDsp);%('Data_EBR=2.csv',TrainingVector);



%% Gammatone processing mix bilateral beamformer

TestingVector = [];
gamma = [];
sprintf('Ear %.2d',idxEar)
sprintf('Mic %.2d',idxMic)
tmp = GammaProc(FD(3).ownVoice.mix,freqRange(1),freqRange(2),den,fsDsp);
for idxChannel = 1:nrChannel
    sprintf('Channel voice %.2d',idxChannel)
    gamma = [gamma ...
        mean(...
        reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
        ,1)'...
        ];
end

TestingVector = [TestingVector; gamma];

disp('Saving wav...')
audiowrite(strcat(path,'ERB=',num2str(den),'_mixed_bilBF.wav'),TestingVector,fsDsp);%('Data_EBR=2.csv',TrainingVector);








