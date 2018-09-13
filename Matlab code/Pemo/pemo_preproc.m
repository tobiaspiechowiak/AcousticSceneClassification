
function [Y, nrGFChannel, nrMFChannel] = pemo_preproc(x,fs)

% Usage: Y = pemo_preproc(x,fs)
%
% Perception model with optimal detector preprocessing script
%

% parameter GF
freqRangeGF = [0 1e4];
[nrGFChannel, cfGF] = getGFBMultipleCenterERBs(freqRangeGF,2);

%parameter MF
freqRangeMF = [0 500];
style = 2; % lowpass on = 1, off = 2
den = 1;
[a,~] = mfb2(1,freqRangeMF(1),freqRangeMF(2),den,style,fs);
nrMFChannel = size(a,2);


Y = zeros(size(x,1),nrGFChannel,nrMFChannel);		% provide an adequate structure
[lp.a, lp.b] = IRIfolp(1000,fs);

for ChannelNr = 1:nrGFChannel		% GFB loop
    %ChannelNr
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% Choose 'Gamma' or 'DRNL' BMfilter in exp_pemo_cfg.m %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%% Original part without pre gammaFB downsample%%%%%%%%%%%%%%%%
    
    
    % gammatone filterbank    
    % use .m file
    y = BM_proc(x, fs,'Gamma',erbtofreq(cfGF(ChannelNr)));

    
    %haircell transformation    
    y = max(y,0);
    y = filter(lp.b,lp.a,y);        
     
    
    %non-linear adaptation loops
    y = nlal_lim(y,fs,10);
      
    
    % modulation filter bank (MFB)      
    [inf,y] = mfb2(y,freqRangeMF(1),freqRangeMF(2),den,style,fs);	% new mfb a la SE'
    y = mfbtdpp(y,inf,fs);	% postprocessing for mfb
        
    % finally add the actual channel to the internal representation matrix
    
    Y(:,ChannelNr,1:length(inf)) = y;
        
    
end


end
