function BF = BFCoeff(type,fs)

%Returns Fixed Directionality or Pinna Restoration coefficients for Berlin
%80 devices for 500 Hz bandsplit

dspFs = 20833;%Hz

switch type
    case {'PR' 'Pinna' 'Pinna Restoration'}
        %for high bandsplit = 500 Hz
        %load calibration file
        fmmNum = [0     0     0     1     0     0     0     0];
        fmmDen = [1 0];
        
        %front
        BF(:,1) = [0.08703, -0.12701, 0.02069, -0.05226, -0.18060, 0.16493, -0.53627, 0.62921, -0.67251,...
            0.55952, -0.41444, -0.25206, 0.13760, -0.73595, 0.88920, -0.48389, 1.00000, -0.77530,...
            -0.01256, -0.09953, -0.27755, 0.34932, -0.68659, 0.76541, -0.45858, 0.61266, -0.13529,...
            0.10392, -0.09101, -0.14313, 0.00000, 0.00000];
        BF(:,1) = BF(:,1) + [zeros(14,1); 1; zeros(32 - 15,1)];
        BF(:,1) = filter([0 0 0 1],1,BF(:,1));
        
        %rear
        BF(:,2) = [-0.03916, 0.11145, -0.09437, 0.26662, -0.22241, 0.49470, -0.44809,...
            0.41139, -0.16183, -0.15073, 0.52506, -0.36373, 0.95378, -0.79552, 0.62704,...
            -1.00000, 0.15487, 0.51742, -0.28236, 0.72005, -0.76868, 0.86282, -0.49210,...
            -0.04504, 0.07590, -0.45088, 0.19573, -0.11027, 0.11721, 0.11675, 0.00000, 0.00000];
        BF(:,2) = filter(fmmNum,fmmDen,BF(:,2));
        
        %RESAMPLE!!!!
        disp('Resample...');
        BF = dspFs/fs*resample(BF,fs,dspFs,100);
        
    case {'FD' 'Fixed Directionality'}
        %calibration
        fmmNum = [0     0     0     1     0     0     0     0];
        fmmDen = [1 0];
        
        %front
        BF(:,1) = [-0.03219, -0.07035, -0.07524, -0.11440, -0.10100, -0.14830, -0.15781, -0.21781,...
            -0.20595, -0.27772, -0.25812, -0.35611, -0.32334, -0.47483, -0.26244, 0.57740, 0.37318,...
            0.33612, 0.30222, 0.25100, 0.19513, 0.12712, 0.06579, 0.03908, 0.08676, 0.07733, 0.09417,...
            -0.00302, 0.01371, -0.01001, 0.00000, 0.00000];
        BF(:,1) = BF(:,1) + [zeros(14,1); 1; zeros(32 - 15,1)];
        BF(:,1) = filter([0 0 0 1],1,BF(:,1));
        
        %rear
        BF(:,2) = [0.05965, 0.07547, 0.10226, 0.12349, 0.11395, 0.16779, 0.18329, 0.24111,...
            0.23759, 0.31959, 0.27624, 0.40019, 0.37051, 0.55217, -0.52529, -0.67780,...
            -0.28544, -0.37743, -0.22400, -0.26523, -0.13633, -0.12495, -0.01250, -0.07939,...
            -0.00738, -0.05879, -0.05840, -0.00764, 0.01642, -0.00136, 0.00000, 0.00000];
        BF(:,2) = filter(fmmNum,fmmDen,BF(:,2));
        
        %RESAMPLE!!!!
        disp('Resample...');
        BF = dspFs/fs*resample(BF,fs,dspFs,100);
        
    otherwise
        error('Beamformer needs to be either Fixed Directionality or Pinna Restoration!');
end



end

