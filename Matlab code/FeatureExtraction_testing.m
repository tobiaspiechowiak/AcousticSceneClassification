fs = 44100;
refLevel = -20; %dB re. rms 1
fsDsp = 20833;
winLength = round(0.010*fs);

%% Own-voice extraction MaRiE (training set)
path = 'x:/Steering/Recordings/Audio/Own-voice recordings/';
path_external = strcat(path,'External Sound/MaRiE/');
path_own_voice = strcat(path,'Own-voice/MaRiE/');


disp('Own voice...')
idxSubject = 3;


ownVoice(1).mic(1).testing = resample(audioread(strcat(path_own_voice,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
ownVoice(1).mic(2).testing = resample(audioread(strcat(path_own_voice,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
ownVoice(1).mic(3).testing = resample(audioread(strcat(path_own_voice,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);

ownVoice(2).mic(1).testing = resample(audioread(strcat(path_own_voice,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
ownVoice(2).mic(2).testing = resample(audioread(strcat(path_own_voice,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
ownVoice(2).mic(3).testing = resample(audioread(strcat(path_own_voice,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);

refRMS(1) = rms(ownVoice(1).mic(1).testing); %left front
refRMS(2) = rms(ownVoice(2).mic(1).testing); %right front

minlen(idxSubject) = min(length(ownVoice(1).mic(1).testing),length(ownVoice(1).mic(1).testing));


%get levels right

for i = 1:2
    for l = 1:3
        ownVoice(i).mic(l).testing = 10^((refLevel + 3)/20)*ownVoice(i).mic(l).testing/refRMS(1);
    end
end


idxSubject = 1;
disp('Car...')
%% Car
path = 'x:/Steering/Recordings/Audio/Car 1/';

car(1).mic(1).testing = resample(audioread([path '01-Front_left_01.wav']),fsDsp,fs,100);
car(1).mic(2).testing = resample(audioread([path '02-Rear_left_01.wav']),fsDsp,fs,100);
car(1).mic(3).testing = resample(audioread([path '03-MiE_left_01.wav']),fsDsp,fs,100);

car(2).mic(1).testing = resample(audioread([path '04-Front_right_01.wav']),fsDsp,fs,100);
car(2).mic(2).testing = resample(audioread([path '05-Rear_right_01.wav']),fsDsp,fs,100);
car(2).mic(3).testing = resample(audioread([path '06-MiE_right_01.wav']),fsDsp,fs,100);

refRMS(1) = rms(car(1).mic(1).testing); %left front
refRMS(2) = rms(car(2).mic(1).testing); %left front

for i = 1:2
    for l = 1:3
        car(i).mic(l).testing  = 10^(refLevel/20)*car(i).mic(l).testing /refRMS(1);
        %        %spectrogram
        %        spec(i,l).car = 20*log10(abs(spectrogram(car(i).mic(l).training,winLength,10,512,fs)));
    end
end

len(:,1) = length(car(i).mic(l).testing)
len(:,2) = length(ownVoice(i).mic(l).testing)

%add the two streams
for i = 1:2
    for l = 1:3
      mix(i).mic(l).testing = 10^(-5/20)*car(i).mic(l).testing(1:min(len))  + ownVoice(i).mic(l).testing(1:min(len));
    end
end

% %% beamforming
% BF = BFCoeff('FD',fsDsp);
%
%
% %beamformer signal left
% meeting(3).training(1).external = conv(BF(:,1),meeting(1).mic(1).training(1).external)...
%     +  conv(BF(:,2),meeting(1).mic(2).training(1).external);
%
% car(3).training(1).external = conv(BF(:,1),car(1).mic(1).training(1).external)...
%     +  conv(BF(:,2),car(1).mic(2).training(1).external);
%
% for i = 1:3
%
%     ownVoice(3).training(i).mix = conv(BF(:,1),ownVoice(1).mic(1).training(i).mix)...
%         +  conv(BF(:,2),ownVoice(1).mic(2).training(i).mix);
%
% end
%
% canteen(3).training(1).external = conv(BF(:,1),canteen(1).mic(1).training(1).external)...
%     +  conv(BF(:,2),canteen(1).mic(2).training(1).external);
%
%
%
% %beamformer signal right
% meeting(4).training(1).external = conv(BF(:,1),meeting(2).mic(1).training(1).external)...
%     +  conv(BF(:,2),meeting(2).mic(2).training(1).external);
%
% car(4).training(1).external = conv(BF(:,1),car(2).mic(1).training(1).external)...
%     +  conv(BF(:,2),car(2).mic(2).training(1).external);
%
% for i = 1:3
%
%     ownVoice(4).training(i).mix = conv(BF(:,1),ownVoice(2).mic(1).training(i).mix)...
%         +  conv(BF(:,2),ownVoice(2).mic(2).training(i).mix);
%
% end
%
% canteen(4).training(1).external = conv(BF(:,1),canteen(2).mic(1).training(1).external)...
%     +  conv(BF(:,2),canteen(2).mic(2).training(1).external);
%

disp('Save...')
save('Scenes_testing.mat','mix');














