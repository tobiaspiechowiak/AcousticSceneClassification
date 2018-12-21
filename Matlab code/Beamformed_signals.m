
addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Scenes_v3.mat'));
fs = 20833;



%% unilateral beamformer signal left
% speech
for i = 1:2
FD(1).meeting(i).signal = Two_Mic_BF(meeting(1).mic(1).training(i).external,...
    meeting(1).mic(2).training(i).external,fs);

end

% car
FD(1).car(1).signal = Two_Mic_BF(car(1).mic(1).training(1).external,...
    car(1).mic(2).training(1).external,fs);

% own voice
for i = 1:4
    
    FD(1).ownVoice(i).signal = Two_Mic_BF(ownVoice(1).mic(1).training(i).voice,...
        ownVoice(1).mic(2).training(i).voice,fs);
    
end

% babble
FD(1).canteen(1).signal = Two_Mic_BF(canteen(1).mic(1).training(1).external,...
    canteen(1).mic(2).training(1).external,fs);

% traffic
for i = 1:2
   
    FD(1).traffic(i).signal = Two_Mic_BF(traffic(1).mic(1).training(i).external,...
    traffic(1).mic(2).training(i).external,fs);
    
    
end


%% unilateral beamformer signal right
%speech
for i = 1:2
    
FD(2).meeting(i).signal = Two_Mic_BF(meeting(2).mic(1).training(i).external,...
    meeting(2).mic(2).training(i).external,fs);

end

%car
FD(2).car(1).signal = Two_Mic_BF(car(2).mic(1).training(1).external,...
    car(2).mic(2).training(1).external,fs);

%own voice
for i = 1:4
    
    FD(2).ownVoice(i).signal = Two_Mic_BF(ownVoice(2).mic(1).training(i).voice,...
        ownVoice(2).mic(2).training(i).voice,fs);
    
end

%babble
FD(2).canteen(1).signal = Two_Mic_BF(canteen(2).mic(1).training(1).external,...
    canteen(2).mic(2).training(1).external,fs);


%traffic
for i = 1:2
   
    FD(2).traffic(i).signal = Two_Mic_BF(traffic(2).mic(1).training(i).external,...
    traffic(2).mic(2).training(i).external,fs);
        
end


%% bilateral beamformer signals
% speech
for i = 1:2
    
FD(3).meeting(i).signal = Four_Mic_BF(meeting(1).mic(1).training(i).external, meeting(1).mic(2).training(i).external,...
    meeting(2).mic(1).training(i).external, meeting(2).mic(2).training(i).external, fs);

end

% car
FD(3).car(1).signal = Four_Mic_BF(car(1).mic(1).training(1).external, car(1).mic(2).training(1).external,...
    car(2).mic(1).training(1).external, car(2).mic(2).training(1).external, fs);

% own voice
for i = 1:4
    
    FD(3).ownVoice(i).signal = Four_Mic_BF(ownVoice(1).mic(1).training(i).voice, ownVoice(1).mic(2).training(i).voice,...
    ownVoice(2).mic(1).training(i).voice, ownVoice(2).mic(2).training(i).voice, fs);
    
end

% babble
FD(3).canteen(1).signal = Four_Mic_BF(canteen(1).mic(1).training(1).external, canteen(1).mic(2).training(1).external,...
    canteen(2).mic(1).training(1).external, canteen(2).mic(2).training(1).external, fs);

% traffic
for i = 1:2
   
    FD(3).traffic(i).signal = Four_Mic_BF(traffic(1).mic(1).training(i).external, traffic(1).mic(2).training(i).external,...
    traffic(2).mic(1).training(i).external, traffic(2).mic(2).training(i).external, fs);
        
end



%% saving

save(strcat(path,'Beamformed_signals.mat'),'FD');