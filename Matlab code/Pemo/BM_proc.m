
function y = BM_proc(x,fs,BMfilter,CF)

if strcmp(BMfilter,'Gamma')
    
    erb = 24.7 + CF/9.265;
    beta = 1.0183*erb;
    [b,a] = gammaf1(CF,beta,4,2,fs);
    x = 2*real(filter(b,a,x));
    
    y = x;

elseif strcmp(BMfilter,'NL1') %Oxenham 1994
    
    erb = 24.7 + CF/9.265;
    beta = 1.0183*erb;
    [b,a] = gammaf1(CF,beta,4,2,fs);
    x = 2*real(filter(b,a,x));
    
    in_dB = 20 * log10(abs(x+0.000000001))+100;
    NL_dB1 = in_dB .* (in_dB <= 35) * 0.78;
    NL_dB2 = (in_dB > 35) .* ((in_dB * 0.16) + 21.7);
    NL_dB = NL_dB1 + NL_dB2;
    x = (10.0.^((NL_dB)/20.0));
    %Square
    y=x.*x;
    
elseif strcmp(BMfilter,'DRNL1') %Plack et al. 2002
 
    x = drnl_plack(x,fs,CF);
    
    %Square
    y=x.*x;

elseif strcmp(BMfilter,'none')
    y = x;
else
    error('Wrong BM filter!!');
end
