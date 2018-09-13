
% gammaFB.m - applies gammatone auditory filterbank
%
% Usage: [out, cfs] = gammaFB(in, lowf, uppf, fs)
%
% in = input vector 
% lowf = lower frequency boundary for filters
% uppf = upper frequency boundary for filters
%        (if lowf == uppf, only one filter is chosen)
% fs = sampling rate in Hz
%
% out = output array (columns = channels, rows = time)
% cfs = vector of center frequencies in ERB (use erbtofreq.m to convert to Hz)

function [out, cfs] = gammaFB(in, lowf, uppf, fs)

[NrChannels, cfs] = GetGammaParam(lowf, uppf, 1);

out = zeros(length(in),NrChannels);

for i = 1:NrChannels,		% gt_loop
   
   out(:,i) = gammatone_r(in, cfs(i), 1, fs)';
   
end