
addpath('Gammatone')
load('../../Recordings/Processed/Scenes.mat')
freqRange = [0 1e4];
[nrChannel, cf] = getGFBMultipleCenterERBs([1 10000],2);
blkSize = 32;
fsDsp = 20833;

TrainingVector = [];

%% Gammatone processing babble
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(canteen(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),fsDsp);
            for idxChannel = 1:nrChannel
               sprintf('Channel canteen %.2d',idxChannel)
               gamma = [gamma ...
                   mean(...
                   reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                   ,1)'...
                   ];                     
            end
        end               
    end
end

%class labeling 
gamma = [gamma ones(size(gamma,1),1)];

TrainingVector = [TrainingVector; gamma];


%% Gammatone processing own voice 
for idxSubjects = 1:3
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(ownVoice(idxEar).mic(idxMic).training(idxSubjects).voice,freqRange(1),freqRange(2),fsDsp);
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
    gamma = [gamma 2*ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing car
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(car(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),fsDsp);
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
    gamma = [gamma 3*ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing speech 
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(meeting(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),fsDsp);
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
    gamma = [gamma 4*ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end


%% Gammatone processing extra speech 
for idxSubjects = 1:3
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(ownVoice(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),fsDsp);
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
    gamma = [gamma 4*ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



figure; 
%plot gammatone front left
for idxChannel = 1:nrChannel
   
    subplot(36,1,idxChannel);
    plot(TrainingVector(:,idxChannel)); 
    title(num2str(erbtofreq(cf(idxChannel))));
    
end


disp('Saving csv')
csvwrite('TrainingSet_EBR=2.csv',TrainingVector);




