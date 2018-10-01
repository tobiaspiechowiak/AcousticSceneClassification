
addpath('Pemo')
fs = 44100;
refLevel = -20; %dB re. rms 1
fsDsp = 20833;
winLength = round(0.010*fs);
den = 2;
freqRange = [0 1e4];
[nrChannel, cf] = getGFBMultipleCenterERBs([0 1e4],den);
blkSize = 32;

%% Own-voice extraction MaRiE (training set)
path = 'x:/Steering/Recordings/Audio/Own-voice recordings/';
path_own_voice = strcat(path,'Own-voice/MaRiE/');

TrainingVector = [];

disp('Own voice...')
for idxSubject = 1:4
    
    ownVoice(1).mic(1).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(2).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(3).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    ownVoice(2).mic(1).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(2).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(3).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    refRMS(idxSubject,1) = rms(ownVoice(1).mic(1).training(idxSubject).voice); %left front
    refRMS(idxSubject,2) = rms(ownVoice(2).mic(1).training(idxSubject).voice); %right front
    
    minlen(idxSubject) = length(ownVoice(1).mic(1).training(idxSubject).voice);
    
end


%get levels right
for j = 1:4 %across subjects
    for i = 1:2
        for l = 1:3
            ownVoice(i).mic(l).training(j).voice = 10^((refLevel)/20)*ownVoice(i).mic(l).training(j).voice/refRMS(j,1);
        end
    end
end

%own voice beamforming
for i = 1:4
    
    %left
    FD(1).ownVoice(i).signal = Two_Mic_BF(ownVoice(1).mic(1).training(i).voice,...
        ownVoice(1).mic(2).training(i).voice,fs);
    
    %right
    FD(2).ownVoice(i).signal = Two_Mic_BF(ownVoice(2).mic(1).training(i).voice,...
        ownVoice(2).mic(2).training(i).voice,fs);
    
end


% gammatone filtering
%% Gammatone processing babble
for idxSubjects = 1:4
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)        
        tmp = GammaProc(FD(idxEar).ownVoice(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
        for idxChannel = 1:nrChannel
            sprintf('Channel canteen %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];            
        end
        
    end
    %class labeling
    gamma = [gamma (idxSubjects * ones(size(gamma,1),1))];
    TrainingVector = [TrainingVector; gamma];
end


audiowrite(strcat('ERB=',num2str(den),'_uni_OwnVoice.wav'),TrainingVector(:,1:end-1),fsDsp);%('Data_EBR=2.csv',TrainingVector);
csvwrite(strcat('Classes_',num2str(den),'_uni_OwnVoice.csv'),TrainingVector(:,end));
