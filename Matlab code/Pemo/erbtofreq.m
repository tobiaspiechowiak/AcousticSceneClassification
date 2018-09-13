



% freqtoerb.m - converts to frequencyscale erbscale.
%               Uses a scaling based on the equivalent rectangular bandwidth
%               (ERB) of an auditory filter at centre frequency fc:
%               ERB(fc) = 24.7 + fc[Hz]/9.265 (Glasberg and Moore, JASA 1990).
%
% Usage: erb = freqtoerb(freq)
%
% freq = input vector in Hz
%
% erb  = erbscaled output vector

% Author: Tobias Piechowiak, Universitaet Oldenburg.
% $Revision: 1 $  $Date: 1999/11/18 12:01:37 $

function freq = erbtofreq(erb)


freq = (1/0.00437)*sign(erb).*(exp(abs(erb)/9.2645)-1);


end