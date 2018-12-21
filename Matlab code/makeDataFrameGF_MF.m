

addpath('Pemo')
path = 'x:\Steering\Recordings\Processed\';
load(strcat(path,'Scenes_v3.mat'));
blkSize = 32;
fsDsp = 20833;


TrainingVector = [];

%% Gammatone processing babble 
disp('canteen');
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            [tmp,nrGF,nrMF] = pemo_preproc(canteen(idxEar).mic(idxMic).training(idxSubjects).external,fsDsp); 
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
    end  
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma ones(size(gamma,1),1)];        
end

TrainingVector = [TrainingVector; gamma];



%% Gammatone processing own voice
disp('own Voice');
for idxSubjects = 1:4
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            [tmp,nrGF,nrMF] = pemo_preproc(ownVoice(idxEar).mic(idxMic).training(idxSubjects).voice,fsDsp); 
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
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma 2*ones(size(gamma,1),1)];        
    
    TrainingVector = [TrainingVector; gamma];

end



%% Gammatone processing car
disp('car');
bla = [];
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            [tmp,nrGF,nrMF] = pemo_preproc(car(idxEar).mic(idxMic).training(idxSubjects).external,fsDsp); 
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
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma 3*ones(size(gamma,1),1)];        
    TrainingVector = [TrainingVector; gamma];
end




%% Gammatone processing speech
disp('speech');
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            [tmp,nrGF,nrMF] = pemo_preproc(meeting(idxEar).mic(idxMic).training(idxSubjects).external,fsDsp); 
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
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma 4*ones(size(gamma,1),1)];        
    TrainingVector = [TrainingVector; gamma];
end



%% Gammatone processing extra speech
disp('speech');
for idxSubjects = 1:1
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            [tmp,nrGF,nrMF] = pemo_preproc(ownVoice(idxEar).mic(idxMic).training(idxSubjects).external,fsDsp); 
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
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma 4*ones(size(gamma,1),1)];        
    TrainingVector = [TrainingVector; gamma];
end


%% Gammatone processing traffic 
disp('traffic');
for idxSubjects = 1:2
    gamma = [];
    for idxEar = 1:2
        sprintf('Ear %.2d',idxEar)
        for idxMic = 1:3
            sprintf('Mic %.2d',idxMic)
            [tmp,nrGF,nrMF] = pemo_preproc(traffic(idxEar).mic(idxMic).training(idxSubjects).external,fsDsp); 
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
    end
    %class labeling
    gamma = 1e-3*gamma;% / max(max(gamma));
    gamma = [gamma 5*ones(size(gamma,1),1)];        
    TrainingVector = [TrainingVector; gamma];
end



TrainingVector = single(TrainingVector);


disp('Saving wav and csv')
audiowrite(strcat(path,'ERB=2_MF_01.wav'),TrainingVector(:,1:256),20833);
audiowrite(strcat(path,'ERB=2_MF_02.wav'),TrainingVector(:,257:512),20833);
audiowrite(strcat(path,'ERB=2_MF_03.wav'),TrainingVector(:,513:end-1),20833);

%classes
csvwrite(strcat(path,'Classes_2_MF.csv'),TrainingVector(:,end));

