function out = Two_Mic_BF(front, rear, fs)

%out = Two_Mic_BF(front, rear, fs)
%Input:   front = front microphone  
%         rear = rear microphone  
%         fs = sampling rate of inputs (Hz)
%Output:  out = Beamformed signal (mono); column vector @ fs sampling rate
%FIR filter length = 30 samples @ 20833 Hz


%% check if input is numeric
if(~(isnumeric(front) && isnumeric(rear)))
   error('Inputs are not numeric!!')    
end

%% check if front and rear have same length; take the min length of both
front = front(:);rear = rear(:);
tmp = min(size(front,1),size(rear,1));
sig(:,1) = front(1:tmp,1);
sig(:,2) = rear(1:tmp,1);
clear tmp front rear;


%% filter coefficients Fixed Unilateral Dir
%front
tmp(:,1) = [0.08703, -0.12701, 0.02069, -0.05226, -0.18060, 0.16493, -0.53627, 0.62921, -0.67251,...
            0.55952, -0.41444, -0.25206, 0.13760, -0.73595, 0.88920, -0.48389, 1.00000, -0.77530,...
            -0.01256, -0.09953, -0.27755, 0.34932, -0.68659, 0.76541, -0.45858, 0.61266, -0.13529,...
            0.10392, -0.09101, -0.14313];
%Parallel delay
tmp(:,1) = tmp(:,1) +  [zeros(14,1); 1; zeros(30 - 15,1)];    
%
tmp(:,1) = filter([0 0 0 1],1,tmp(:,1));
%rear                
tmp(:,2) = [-0.03916, 0.11145, -0.09437, 0.26662, -0.22241, 0.49470, -0.44809,...
            0.41139, -0.16183, -0.15073, 0.52506, -0.36373, 0.95378, -0.79552, 0.62704,...
            -1.00000, 0.15487, 0.51742, -0.28236, 0.72005, -0.76868, 0.86282, -0.49210,...
            -0.04504, 0.07590, -0.45088, 0.19573, -0.11027, 0.11721, 0.11675];
tmp(:,2) = filter([0 0 0 1 0 0 0 0],[1 0],tmp(:,2));               

%% resampling filter coefficients
clc
disp('resample FIR filters...')
A(:,1) = 20833/fs * resample(tmp(:,1),fs,20833,50);
A(:,2) = 20833/fs * resample(tmp(:,2),fs,20833,50);
clear tmp;

%% beamform 
out = conv(A(:,1),sig(:,1)) + ...
    conv(A(:,2),sig(:,2));
clear sig fs; 

end


