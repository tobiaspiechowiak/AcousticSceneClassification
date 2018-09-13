% getGFBMultipleCenterERBs
%
% Usage: [num, cf] = getGFBMultipleCenterERBs(cfvec, dens);
%
% cfvec  = [lcf1 ucf1] vector containing the lower and upper cutoff frequency in Hz,
%          [lcf1 ucf1 lcf2 ucf2 ... lcfN ucfN] optional cutoff frequencies in ascending order.
%          cfvec must have an even number of elements.
% dens   = density re ERB
%
% num    = number of filters
% cf     = vector containing center frequencies

function [num, cf] = getGFBMultipleCenterERBs(cfvec, dens);

if mod(length(cfvec),2) == 1
   return
end

num = 0;
cf = [];

for i=1:length(cfvec)/2
   index = (i-1)*2+1;
   [numtmp, cftmp] = getGFBCenterERBs(cfvec(index), cfvec(index+1),dens);
   num = num + numtmp;
   cf = [cf cftmp];   
end
