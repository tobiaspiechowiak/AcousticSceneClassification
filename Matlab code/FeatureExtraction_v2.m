fs = 44100;
refLevel = -20; %dB re. rms 1
fsDsp = 20833;
winLength = round(0.010*fs);

load('maxi.mat');

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
              
    
    minlen(idxSubject) = min(length(ownVoice(1).mic(1).training(idxSubject).voice),length(ownVoice(1).mic(1).training(idxSubject).external));
    
end


%get levels right
for j = 1:3 %across subjects
    for i = 1:2
        for l = 1:3
            ownVoice(i).mic(l).training(j).mix = ownVoice(i).mic(l).training(j).voice(1:minlen(j)) + ownVoice(i).mic(l).training(j).external(1:minlen(j));
            ownVoice(i).mic(l).training(j).mix = ownVoice(i).mic(l).training(j).mix / max_maxi;                        
        end
    end
end
%beamforming


disp('Car...')
%% Car
path = 'x:/Steering/Recordings/Audio/Car 1/';

car(1).mic(1).training(1).external = resample(audioread([path '01-Front_left_01.wav']),fsDsp,fs,100)/max_maxi;
car(1).mic(2).training(1).external = resample(audioread([path '02-Rear_left_01.wav']),fsDsp,fs,100)/max_maxi;
car(1).mic(3).training(1).external = resample(audioread([path '03-MiE_left_01.wav']),fsDsp,fs,100)/max_maxi;

car(2).mic(1).training(1).external = resample(audioread([path '04-Front_right_01.wav']),fsDsp,fs,100)/max_maxi;
car(2).mic(2).training(1).external = resample(audioread([path '05-Rear_right_01.wav']),fsDsp,fs,100)/max_maxi;
car(2).mic(3).training(1).external = resample(audioread([path '06-MiE_right_01.wav']),fsDsp,fs,100)/max_maxi;


% for i = 1:2
%     for l = 1:3
%         maxi = [maxi; max(car(i).mic(l).training(1).external)];
%     end
% end



disp('Canteen...')
%% Canteen/Restaurant
path = 'x:/Steering/Recordings/Audio/Cantine 1/';

canteen(1).mic(1).training(1).external = resample(audioread([path '01-Front_left_01.wav']),fsDsp,fs,100)/max_maxi;
canteen(1).mic(2).training(1).external = resample(audioread([path '02-Rear_left_01.wav']),fsDsp,fs,100)/max_maxi;
canteen(1).mic(3).training(1).external = resample(audioread([path '03-MiE_left_01.wav']),fsDsp,fs,100)/max_maxi;

canteen(2).mic(1).training(1).external  = resample(audioread([path '04-Front_right_01.wav']),fsDsp,fs,100)/max_maxi;
canteen(2).mic(2).training(1).external = resample(audioread([path '05-Rear_right_01.wav']),fsDsp,fs,100)/max_maxi;
canteen(2).mic(3).training(1).external = resample(audioread([path '06-MiE_right_01.wav']),fsDsp,fs,100)/max_maxi;

refRMS(1) = rms(canteen(1).mic(1).training(1).external); %left front
refRMS(2) = rms(canteen(2).mic(1).training(1).external); %right front

% for i = 1:2
%     for l = 1:3
%         maxi = [maxi; max(canteen(i).mic(l).training(1).external)];
%         
%     end
% end



disp('Meeting...')
%% Meeting
path = 'x:/Steering/Recordings/Audio/Meeting/';

for idxSubject = 1:2
    
    meeting(1).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    meeting(1).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    meeting(1).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    
    meeting(2).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    meeting(2).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    meeting(2).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
       
    
end

% for j = 1:2
%     for i = 1:2
%         for l = 1:3
%             maxi = [maxi; max(meeting(i).mic(l).training(j).external)];           
%         end
%     end
%     
% end



disp('Traffic...')
%% Traffic 
path = 'x:/Steering/Recordings/Audio/Traffic/';

for idxSubject = 1:2
    
    traffic(1).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'01-Front_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    traffic(1).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'02-Rear_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    traffic(1).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'03-MiE_left_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    
    traffic(2).mic(1).training(idxSubject).external = resample(audioread(strcat(path,'04-Front_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    traffic(2).mic(2).training(idxSubject).external = resample(audioread(strcat(path,'05-Rear_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    traffic(2).mic(3).training(idxSubject).external = resample(audioread(strcat(path,'06-MiE_right_',sprintf('%0.2d',idxSubject),'.wav')),fsDsp,fs,100)/max_maxi;
    
   
    
    
end

% for j = 1:2
%     for i = 1:2
%         for l = 1:3
%             maxi = [maxi; max(traffic(i).mic(l).training(j).external)];
%             
%         end
%     end
%     
% end


%max_maxi = max(maxi);


disp('Save...')
save('Scenes_v3.mat','ownVoice','car','meeting','canteen','traffic');














