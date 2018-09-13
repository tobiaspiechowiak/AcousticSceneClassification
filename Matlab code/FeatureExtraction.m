fs = 44100;
refLevel = -20; %dB re. rms 1
fsDsp = 20833;
winLength = round(0.010*fs);

%% Own-voice extraction MaRiE (training set)
path = 'x:/Steering/Recordings/Audio/Own-voice recordings/';
path_external = strcat(path,'External Sound/MaRiE/');
path_own_voice = strcat(path,'Own-voice/MaRiE/');


disp('Own voice...')
for idxSubject = 1:3
    
    %first subject
    ownVoice(1).mic(1).training(idxSubject).external = resample(audioread(strcat(path_external,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(2).training(idxSubject).external = resample(audioread(strcat(path_external,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(3).training(idxSubject).external = resample(audioread(strcat(path_external,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    ownVoice(2).mic(1).training(idxSubject).external = resample(audioread(strcat(path_external,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(2).training(idxSubject).external = resample(audioread(strcat(path_external,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(3).training(idxSubject).external = resample(audioread(strcat(path_external,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    ownVoice(1).mic(1).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(2).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(1).mic(3).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    ownVoice(2).mic(1).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(2).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    ownVoice(2).mic(3).training(idxSubject).voice = resample(audioread(strcat(path_own_voice,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
           
    refRMS(idxSubject,1) = rms(ownVoice(1).mic(1).training(idxSubject).voice); %left front
    refRMS(idxSubject,2) = rms(ownVoice(2).mic(1).training(idxSubject).voice); %right front
    
    minlen(idxSubject) = min(length(ownVoice(1).mic(1).training(idxSubject).voice),length(ownVoice(1).mic(1).training(idxSubject).external));
    
end


%get levels right
for j = 1:3 %across subjects
    for i = 1:2
        for l = 1:3
            ownVoice(i).mic(l).training(j).external = 10^(refLevel/20)*ownVoice(i).mic(l).training(j).external/refRMS(j,1);
            ownVoice(i).mic(l).training(j).voice = 10^((refLevel + 3)/20)*ownVoice(i).mic(l).training(j).voice/refRMS(j,1);
            ownVoice(i).mic(l).training(j).mix = ownVoice(i).mic(l).training(j).voice(1:minlen(j)) + ownVoice(i).mic(l).training(j).external(1:minlen(j));
            %        %spectrogram
            %        spec(i,l).voice = 20*log10(abs(spectrogram(ownVoice(i).mic(l).training.mix,winLength,10,512,fs)));
        end
    end
end
%beamforming


disp('Car...')
%% Car
path = 'x:/Steering/Recordings/Audio/Car 1/';

car(1).mic(1).training(1).external = resample(audioread([path '01-Front_left_01.wav']),fsDsp,fs,100);
car(1).mic(2).training(1).external = resample(audioread([path '02-Rear_left_01.wav']),fsDsp,fs,100);
car(1).mic(3).training(1).external = resample(audioread([path '03-MiE_left_01.wav']),fsDsp,fs,100);

car(2).mic(1).training(1).external = resample(audioread([path '04-Front_right_01.wav']),fsDsp,fs,100);
car(2).mic(2).training(1).external = resample(audioread([path '05-Rear_right_01.wav']),fsDsp,fs,100);
car(2).mic(3).training(1).external = resample(audioread([path '06-MiE_right_01.wav']),fsDsp,fs,100);

refRMS(1) = rms(car(1).mic(1).training(1).external); %left front
refRMS(2) = rms(car(2).mic(1).training(1).external); %left front

for i = 1:2
    for l = 1:3
        car(i).mic(l).training(1).external = 10^(refLevel/20)*car(i).mic(l).training(1).external/refRMS(1);
        %        %spectrogram
        %        spec(i,l).car = 20*log10(abs(spectrogram(car(i).mic(l).training,winLength,10,512,fs)));
    end
end



disp('Canteen...')
%% Canteen/Restaurant
path = 'x:/Steering/Recordings/Audio/Cantine 1/';

canteen(1).mic(1).training(1).external = resample(audioread([path '01-Front_left_01.wav']),fsDsp,fs,100);
canteen(1).mic(2).training(1).external = resample(audioread([path '02-Rear_left_01.wav']),fsDsp,fs,100);
canteen(1).mic(3).training(1).external = resample(audioread([path '03-MiE_left_01.wav']),fsDsp,fs,100);

canteen(2).mic(1).training(1).external  = resample(audioread([path '04-Front_right_01.wav']),fsDsp,fs,100);
canteen(2).mic(2).training(1).external = resample(audioread([path '05-Rear_right_01.wav']),fsDsp,fs,100);
canteen(2).mic(3).training(1).external = resample(audioread([path '06-MiE_right_01.wav']),fsDsp,fs,100);

refRMS(1) = rms(canteen(1).mic(1).training(1).external); %left front
refRMS(2) = rms(canteen(2).mic(1).training(1).external); %right front

for i = 1:2
    for l = 1:3
        canteen(i).mic(l).training(1).external = 10^(refLevel/20)*canteen(i).mic(l).training(1).external/refRMS(1);
        %        %spectrogram
        %        spec(i,l).canteen = 20*log10(abs(spectrogram(canteen(i).mic(l).training,winLength,10,512,fs)));
    end
end



disp('Meeting...')
%% Meeting
path = 'x:/Steering/Recordings/Audio/Meeting/';

for idxSubject = 1:2
    
    meeting(1).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    meeting(1).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    meeting(1).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    meeting(2).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    meeting(2).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    meeting(2).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    refRMS(idxSubject,1) = rms(meeting(1).mic(1).training(idxSubject).external); %left front
    refRMS(idxSubject,2) = rms(meeting(2).mic(1).training(idxSubject).external); %right front
    
    
end

for j = 1:2
    for i = 1:2
        for l = 1:3
            meeting(i).mic(l).training(j).external = 10^(refLevel/20)*meeting(i).mic(l).training(j).external/refRMS(j,1);
            %        %spectrogram
            %        spec(i,l).meeting = 20*log10(abs(spectrogram(meeting(i).mic(l).training,winLength,10,512,fs)));
        end
    end
    
end



disp('Traffic...')
%% Traffic 
path = 'x:/Steering/Recordings/Audio/Traffic/';

for idxSubject = 1:2
    
    traffic(1).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    traffic(1).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    traffic(1).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    traffic(2).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    traffic(2).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    traffic(2).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100);
    
    refRMS(idxSubject,1) = rms(traffic(1).mic(1).training(idxSubject).external); %left front
    refRMS(idxSubject,2) = rms(traffic(2).mic(1).training(idxSubject).external); %right front
    
    
end

for j = 1:2
    for i = 1:2
        for l = 1:3
            traffic(i).mic(l).training(j).external = 10^(refLevel/20)*meeting(i).mic(l).training(j).external/refRMS(j,1);
            %        %spectrogram
            %        spec(i,l).meeting = 20*log10(abs(spectrogram(meeting(i).mic(l).training,winLength,10,512,fs)));
        end
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
save('Scenes_v2.mat','ownVoice','car','canteen','meeting','traffic');














