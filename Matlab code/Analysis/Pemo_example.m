
close all;
path = '../../../Data/';

addpath('../Pemo');

[data1,fs] = audioread(strcat(path,'Data.mp3'));

data = data1(60000:110000,1);

%processing pemo
% parameter GF
freqRangeGF = 1000;


%parameter MF
freqRangeMF = [0 500];
style = 2; % lowpass on = 1, off = 2
den = 1;

% lowpass filter 1000 Hz
[lp.a, lp.b] = IRIfolp(1000,fs);

% gammatone filterbank
% use .m file
y.gamma = BM_proc(data, fs,'Gamma',freqRangeGF);  %gamma at 600 Hz 


%haircell transformation
y.hc = max(y.gamma,0);
y.hc = filter(lp.b,lp.a,y.hc);


%non-linear adaptation loops
y.nl = nlal_lim(y.hc,fs,2000);



% modulation filter bank (MFB)
[inf,y.mf] = mfb2(y.nl,freqRangeMF(1),freqRangeMF(2),den,style,fs);	% new mfb a la SE'
y.mf = mfbtdpp(y.mf,inf,fs);	% postprocessing for mfb



%% plot the shit 
fig = figure;

smp = linspace(0,length(data)/fs,length(data));

subplot(5,1,1);
plot(smp,data);
set(gca,'YLim',[-0.8 0.8]);
set(gca,'XTick');
title('Word: "Auto-bahn"');
ylabel('Amplitude');
subplot(5,1,2);
plot(smp,y.gamma);
title('Gammatone filter @2000 Hz');
ylabel('Amplitude');
set(gca,'YLim',[-0.8 0.8]);
subplot(5,1,3);
plot(smp,y.hc);
title('Envelope extraction');
set(gca,'YLim',[-0.8 0.8]);
ylabel('Amplitude');
subplot(5,1,4);
plot(smp,y.nl);
title('Adaptation loops');
set(gca,'YLim',[-100 1.1e4 ]);
ylabel('Modeling units');
subplot(5,1,5);
plot(smp,y.mf(:,3));
title('Modulation filter @10 Hz');
set(gca,'YLim',[-100 500]);
ylabel('Modeling units');
xlabel('Samples');


