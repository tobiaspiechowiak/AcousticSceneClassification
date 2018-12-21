
addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Beamformed_signals.mat'));
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
        tmp = GammaProc(FD(idxEar).canteen(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
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

%class labeling
gamma = [gamma zeros(size(gamma,1),1)];

TrainingVector = [TrainingVector; gamma];


%% Gammatone processing own voice
for idxSubjects = 1:4
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        tmp = GammaProc(FD(idxEar).ownVoice(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
        for idxChannel = 1:nrChannel
            sprintf('Channel voice %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    gamma = [gamma ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing car
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        tmp = GammaProc(FD(idxEar).car(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
        for idxChannel = 1:nrChannel
            sprintf('Channel car %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



%% Gammatone processing speech
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        tmp = GammaProc(FD(idxEar).meeting(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
        for idxChannel = 1:nrChannel
            sprintf('Channel speech %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



%% Gammatone processing traffic
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        tmp = GammaProc(FD(idxEar).traffic(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
        for idxChannel = 1:nrChannel
            sprintf('Channel traffic %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    gamma = [gamma zeros(size(gamma,1),1)];
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
audiowrite(strcat(path,'ERB=',num2str(den),'uni_BF.wav'),TrainingVector(:,1:end-1),fsDsp);%('Data_EBR=2.csv',TrainingVector);
csvwrite(strcat(path,'Classes_',num2str(den),'uni_BF.csv'),TrainingVector(:,end));




%% bilateral beamformer

TrainingVector = [];

%% Gammatone processing babble
for idxSubjects = 1:1
    gamma = [];
    tmp = GammaProc(FD(3).canteen(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
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
gamma = [gamma zeros(size(gamma,1),1)];

TrainingVector = [TrainingVector; gamma];


%% Gammatone processing own voice
for idxSubjects = 1:3
    gamma = [];
    tmp = GammaProc(FD(3).ownVoice(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
    for idxChannel = 1:nrChannel
        sprintf('Channel voice %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    gamma = [gamma ones(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing car
for idxSubjects = 1:1
    gamma = [];
    tmp = GammaProc(FD(3).car(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
    for idxChannel = 1:nrChannel
        sprintf('Channel car %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



%% Gammatone processing speech
for idxSubjects = 1:2
    gamma = [];
    tmp = GammaProc(FD(3).meeting(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
    for idxChannel = 1:nrChannel
        sprintf('Channel speech %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



%% Gammatone processing traffic
for idxSubjects = 1:2
    gamma = [];
    tmp = GammaProc(FD(3).traffic(idxSubjects).signal,freqRange(1),freqRange(2),den,fsDsp);
    for idxChannel = 1:nrChannel
        sprintf('Channel traffic %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    gamma = [gamma zeros(size(gamma,1),1)];
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
audiowrite(strcat(path,'ERB=',num2str(den),'bil_BF.wav'),TrainingVector(:,1:end-1),fsDsp);%('Data_EBR=2.csv',TrainingVector);
csvwrite(strcat(path,'Classes_',num2str(den),'bil_BF.csv'),TrainingVector(:,end));





