function out = Four_Mic_BF(frontLeft, rearLeft, frontRight, rearRight, fs)

%out = Four_Mic_BF(frontLeft, rearLeft, frontRight, rearRight, fs)
%Input:   frontLeft = front left microphone 
%         rearLeft = rear left microphone  
%         frontRight = front right microphone 
%         rearRight = rear right microphone 
%         fs = sampling rate (Hz)
%Output:  out = Beamformed signal (mono); column vector @ fs sampling rate
%FIR filter length = 30 samples @ 20833 Hz

%% check if input is numeric
if(~(isnumeric(frontLeft) && isnumeric(rearLeft)...
        && isnumeric(frontRight) && isnumeric(rearRight)))
   error('Inputs are not numeric!!')    
end

%% check if front and rear have same length; take the min length of both
frontLeft = frontLeft(:); rearLeft = rearLeft(:); frontRight = frontRight(:); rearRight = rearRight(:);
tmp = min(min(size(frontLeft,1),size(rearLeft,1)),min(size(frontRight,1),size(rearRight,1)));
sig(:,1) = frontLeft(1:tmp,1);
sig(:,2) = rearLeft(1:tmp,1);
sig(:,3) = frontRight(1:tmp,1);
sig(:,4) = rearRight(1:tmp,1);
clear tmp frontLeft rearLeft rearLeft rearRight;

%% beamform
%left side unilateral 
tmp(:,1) = Two_Mic_BF(sig(:,1),sig(:,2),fs);
%right side unilateral 
tmp(:,2) = Two_Mic_BF(sig(:,3),sig(:,4),fs);

%(L + R)/2
out = (tmp(:,1) + tmp(:,2))/2; 
clear tmp;

end

