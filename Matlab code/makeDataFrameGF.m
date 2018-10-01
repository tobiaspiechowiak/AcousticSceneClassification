
addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Scenes_v3.mat'));
den = 1;
freqRange = [0 1e4];
[nrChannel, cf] = getGFBMultipleCenterERBs([0 1e4],den);
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
            tmp = GammaProc(canteen(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),den,fsDsp);
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
for idxSubjects = 1:4
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(ownVoice(idxEar).mic(idxMic).training(idxSubjects).voice,freqRange(1),freqRange(2),den,fsDsp);
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
            tmp = GammaProc(car(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),den,fsDsp);
            for idxChannel = 1:nrChannel
               sprintf('Channel car %.2d',idxChannel)
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
            tmp = GammaProc(meeting(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),den,fsDsp);
            for idxChannel = 1:nrChannel
               sprintf('Channel speech %.2d',idxChannel)
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
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(ownVoice(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),den,fsDsp);
            for idxChannel = 1:nrChannel
               sprintf('Channel speech %.2d',idxChannel)
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


%% Gammatone processing traffic
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            tmp = GammaProc(traffic(idxEar).mic(idxMic).training(idxSubjects).external,freqRange(1),freqRange(2),den,fsDsp);
            for idxChannel = 1:nrChannel
               sprintf('Channel traffic %.2d',idxChannel)
               gamma = [gamma ...
                   mean(...
                   reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                   ,1)'...
                   ];                     
            end
        end               
    end
    gamma = [gamma 5*ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



figure; 
%plot gammatone front left
for idxChannel = 1: nrChannel
   
    subplot(nrChannel,1,idxChannel);
    plot(TrainingVector(:, idxChannel)); 
    title(num2str(erbtofreq(cf(idxChannel))));
    
end

TrainingVector = single(TrainingVector);

disp('Saving wav and csv')
audiowrite(strcat(path,'ERB=',num2str(den),'.wav'),TrainingVector(:,1:end-1),fsDsp);%('Data_EBR=2.csv',TrainingVector);
csvwrite(strcat(path,'Classes_',num2str(den),'.csv'),TrainingVector(:,end));




