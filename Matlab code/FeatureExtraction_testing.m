
fs = 44100;
refLevel = -20; %dB re. rms 1
fsDsp = 20833;
winLength = round(0.010*fs);

%% Own-voice extraction MaRiE (training set)
path = 'x:/Steering/Recordings/Audio/';
path = strcat(path,'mix/');

nrSubjects = 1;
scene = 'OW+Car';

disp('Own voice...')
for idxSubject = 1:nrSubjects
    
    %first subject
    ownVoice(1).mic(1).testing(idxSubject).mix = resample(audioread(strcat(path_external,'01-Front_left_',scene,'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(2).testing(idxSubject).mix = resample(audioread(strcat(path_external,'02-Rear_left_',scene,'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(3).testing(idxSubject).mix = resample(audioread(strcat(path_external,'03-MiE_left_',scene,'.wav')),fsDsp,fs,100);
    
    ownVoice(2).mic(1).testing(idxSubject).mix = resample(audioread(strcat(path_external,'04-Front_right_',scene,'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(2).testing(idxSubject).mix = resample(audioread(strcat(path_external,'05-Rear_right_',scene,'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(3).testing(idxSubject).mix = resample(audioread(strcat(path_external,'06-MiE_right_',scene,'.wav')),fsDsp,fs,100);
    
    
    refRMS(idxSubject,1) = rms(ownVoice(1).mic(1).testing(idxSubject).mix); %left front
    refRMS(idxSubject,2) = rms(ownVoice(2).mic(1).testing(idxSubject).mix); %right front
    
end


%get levels right
for j = 1:nrSubjects %across subjects
    for i = 1:2
        for l = 1:3
            ownVoice(i).mic(l).testing(j).mix = 10^(refLevel/20)*ownVoice(i).mic(l).training(j).external/refRMS(j,1);
        end
    end
end

%beamforming
for i = 1:nrSubjects
    %left
    FD(1).ownVoice(i).mix = Two_Mic_BF(ownVoice(1).mic(1).testing(i).mix,...
        ownVoice(1).mic(2).testing(i).mix,fsDSP);
    
    %right
    FD(2).ownVoice(i).mix = Two_Mic_BF(ownVoice(2).mic(1).testing(i).mix,...
        ownVoice(2).mic(2).testing(i).mix,fsDSP);
    
end





%save shit
disp('Save...')
save('Scenes_testing.mat','ownVoice','FD');









