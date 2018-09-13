% IRIfolp.m - digital first-order lowpass-filter transfer function
%          (impulse response invariance)
%
% Usage: [b,a] = folp(f0,fs)
%
% f0 = cutoff frequency of the lowpass filter in Hz
% fs = sampling rate in Hz
%
% b = [b0,b1, ... ,bN] = numerator coefficients
% a = [1,a1, ... ,aN] = denominator coefficients

function [b,a] = IRIfolp(f0,fs)

a = exp(-(2*pi*f0)/fs);
b = 1 - a;
a = [1, -a];

% eof

