% gammaFB.m - applies gammatone auditory filterbank
%
% Usage: [out, cfs] = GammaProc(in, lowf, uppf, fs)
%
% in = input vector 
% lowf = lower frequency boundary for filters
% uppf = upper frequency boundary for filters
%        (if lowf == uppf, only one filter is chosen)
% fs = sampling rate in Hz
%
% out = output array (columns = channels, rows = time)
% cfs = vector of center frequencies in ERB (use erbtofreq.m to convert to Hz)

function [out, cfs] = GammaProc(in, lowf, uppf, den, fs)

[NrChannels, cfs] = getGFBMultipleCenterERBs([lowf uppf], den);

out = zeros(length(in),NrChannels);


for i = 1:NrChannels,		% gt_loop
   
   out(:,i) = BM_proc(in, fs,'Gamma',erbtofreq(cfs(i)))';
   
end