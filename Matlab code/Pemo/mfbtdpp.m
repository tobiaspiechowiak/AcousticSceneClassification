% mfbtdpp.m - post processing for modulation filterbank 'mfbtd.m' (Dau et al. 1997) output.
%				  Gets the real part for centerfrequencies <= 10 Hz and the absolute value
%				  otherwise.
%
% Usage: out = mfbtdpp(in,inf,fs)
%
% in    = input matrix from mfbtd.m.
% inf   = center frequency info vector
% fs	= sampling rate in Hz
%
% [out1,out2, ...,outn] = output matrix
%
% copyright (c) 1999 Universitaet Oldenburg

function out = mfbtdpp(in,inf,fs)

out=in;
% % inf
% for i=1:length(inf)
%    if inf(i) <= 10
%       out(:,i) = real(out(:,i));
%    else
%       out(:,i) = abs(out(:,i));
%    end
% end

% for i=1:length(inf) % As in MSc by Morten
%    if inf(i) <= 5
%        if inf(i) == 0
%            out(:,i) = 1*real(out(:,i));
%        else
% %            out(:,i) = real(out(:,i));
%            out(:,i) = 1/sqrt(2)*real(out(:,i));
%        end
%    else
% %       out(:,i) = abs(out(:,i));
%       out(:,i) = 1/sqrt(2)*abs(out(:,i));
%    end
% end

% current version
for i=1:length(inf) % v2 MJ 17. oct 2006
   if inf(i) <= 10
          out(:,i) = 1*real(out(:,i));
   else
      out(:,i) = 1/sqrt(2)*abs(out(:,i));
      %out(:,i) = 1*real(out(:,i));
      %out(:,i) = abs(out(:,i));
       
   end
end


% end of mfbtdpp.m








