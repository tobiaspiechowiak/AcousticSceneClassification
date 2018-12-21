

addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Beamformed_signals.mat'));
blkSize = 32;
fsDsp = 20833;



%% unilateral beamformer

TrainingVector = [];

%% Gammatone processing babble
disp('canteen');
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)               
        [tmp,nrGF,nrMF] = pemo_preproc(FD(idxEar).canteen(idxSubjects).signal,fsDsp);
        tmp = reshape(tmp, [length(tmp), nrGF*nrMF]);
        for idxChannel = 1:nrGF*nrMF
            sprintf('Reshape channel %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
end

TrainingVector = [TrainingVector; gamma];



%% Gammatone processing own voice
disp('own Voice');
for idxSubjects = 1:4
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)        
        [tmp,nrGF,nrMF] = pemo_preproc(FD(idxEar).ownVoice(idxSubjects).signal,fsDsp);
        tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
        for idxChannel = 1:nrGF*nrMF
            sprintf('Reshape channel %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma ones(size(gamma,1),1)];
    
    TrainingVector = [TrainingVector; gamma];
    
end



%% Gammatone processing car
disp('car');
bla = [];
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)                
        [tmp,nrGF,nrMF] = pemo_preproc(FD(idxEar).car(idxSubjects).signal,fsDsp);
        tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
        for idxChannel = 1:nrGF*nrMF
            sprintf('Reshape channel %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing speech
disp('speech');
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)        
        [tmp,nrGF,nrMF] = pemo_preproc(FD(idxEar).meeting(idxSubjects).signal,fsDsp);
        tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
        for idxChannel = 1:nrGF*nrMF
            sprintf('Reshape channel %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end





%% Gammatone processing traffic
disp('traffic');
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)        
        [tmp,nrGF,nrMF] = pemo_preproc(FD(idxEar).traffic(idxSubjects).signal,fsDsp);
        tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
        for idxChannel = 1:nrGF*nrMF
            sprintf('Reshape channel %.2d',idxChannel)
            gamma = [gamma ...
                mean(...
                reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
                ,1)'...
                ];
        end
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



TrainingVector = single(TrainingVector);


disp('Saving wav and csv')
audiowrite(strcat(path,'ERB=2_MF_uniBF.wav'),TrainingVector(:,1:end-1),20833);

%classes
csvwrite(strcat(path,'Classes_MF_uniBF.csv'),TrainingVector(:,end));




%% bilateral beamformer
TrainingVector = [];

%% Gammatone processing babble
disp('canteen');
for idxSubjects = 1:1
    gamma = [];
    
    sprintf('Ear %.2d',idxEar)        
    [tmp,nrGF,nrMF] = pemo_preproc(FD(3).canteen(idxSubjects).signal,fsDsp);
    tmp = reshape(tmp, [length(tmp), nrGF*nrMF]);
    for idxChannel = 1:nrGF*nrMF
        sprintf('Reshape channel %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
end

TrainingVector = [TrainingVector; gamma];



%% Gammatone processing own voice
disp('own Voice');
for idxSubjects = 1:4
    gamma = [];         
    [tmp,nrGF,nrMF] = pemo_preproc(FD(3).ownVoice(idxSubjects).signal,fsDsp);
    tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
    for idxChannel = 1:nrGF*nrMF
        sprintf('Reshape channel %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma ones(size(gamma,1),1)];
    
    TrainingVector = [TrainingVector; gamma];
    
end



%% Gammatone processing car
disp('car');
bla = [];
for idxSubjects = 1:1
    gamma = [];           
    [tmp,nrGF,nrMF] = pemo_preproc(FD(3).car(idxSubjects).signal,fsDsp);
    tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
    for idxChannel = 1:nrGF*nrMF
        sprintf('Reshape channel %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing speech
disp('speech');
for idxSubjects = 1:2
    gamma = [];        
    [tmp,nrGF,nrMF] = pemo_preproc(FD(3).meeting(idxSubjects).signal,fsDsp);
    tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
    for idxChannel = 1:nrGF*nrMF
        sprintf('Reshape channel %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end





%% Gammatone processing traffic
disp('traffic');
for idxSubjects = 1:2
    gamma = [];        
    [tmp,nrGF,nrMF] = pemo_preproc(FD(3).traffic(idxSubjects).signal,fsDsp);
    tmp = reshape(tmp, [length(tmp) nrGF*nrMF]);
    for idxChannel = 1:nrGF*nrMF
        sprintf('Reshape channel %.2d',idxChannel)
        gamma = [gamma ...
            mean(...
            reshape(tmp(1:(blkSize * floor(numel(tmp(:,idxChannel))/blkSize)),idxChannel),blkSize,floor(numel(tmp(:,idxChannel))/blkSize))...
            ,1)'...
            ];
    end
    
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma zeros(size(gamma,1),1)];
    TrainingVector = [TrainingVector; gamma];
end



TrainingVector = single(TrainingVector);


disp('Saving wav and csv')
audiowrite(strcat(path,'ERB=2_MF_bilBF.wav'),TrainingVector(:,1:end-1),20833);

%classes
csvwrite(strcat(path,'Classes_MF_bilBF.csv'),TrainingVector(:,end));


