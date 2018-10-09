
path = '../../Data/';
fsDSP = 20833;
blkSize = 32;


close all;

blkFreq = floor(fsDSP / blkSize);
winLength = round(0.010*blkFreq);

%load the signals
[Mix(1).data,fs] = audioread(strcat(path,'Voice+Cantine.wav'));
[Mix(2).data,~] = audioread(strcat(path,'Cantine.wav'));
[Mix(3).data,~] = audioread(strcat(path,'Silence.wav'));



for idx = 1:3
    Mix(idx).data = resample(Mix(idx).data,fsDSP,fs,50);   
    for i = 1:length(Mix(idx).data)/blkSize - 1
        Mix(idx).blkmean(i,1) = mean(Mix(idx).data((i-1)*blkSize + 1 : i*blkSize,:));
    end
    Mix(idx).max = max(Mix(idx).blkmean);
    Mix(idx).rms = rms(Mix(idx).blkmean);
    Mix(idx).spec = 20*log10(abs(spectrogram(Mix(idx).data,200,100,512,fsDSP)));
    Mix(idx).t = linspace(0,floor(length(Mix(idx).blkmean))/blkFreq,floor(length(Mix(idx).blkmean)));
end

    
f = linspace(0,fsDSP/2,512/2 +1);


figure;

scale = [-70 10];

subplot(2,3,1);
plot(Mix(1).t,Mix(1).blkmean);
set(gca,'YLim',[-0.6 0.6],'XLim',[0 Mix(1).t(end)]);
title('Own Voice in Cantine');
ylabel('Amplitude');

subplot(2,3,2);
plot(Mix(2).t,Mix(2).blkmean);
set(gca,'YLim',[-0.6 0.6],'XLim',[0 Mix(2).t(end)]);
title('Cantine');

subplot(2,3,3);
plot(Mix(3).t,Mix(3).blkmean);
set(gca,'YLim',[-0.6 0.6],'XLim',[0 Mix(3).t(end)]);
title('Silence');


subplot(2,3,4);
imagesc(Mix(1).t,f,Mix(1).spec,scale);
set(gca, 'YDir','normal');
xlabel('Time (sec)');
ylabel('Freq (Hz)');

subplot(2,3,5);
imagesc(Mix(2).t,f,Mix(2).spec,scale);
set(gca, 'YDir','normal');
xlabel('Time (sec)');

subplot(2,3,6);
imagesc(Mix(3).t,f,Mix(3).spec,scale); colorbar;
set(gca, 'YDir','normal');
xlabel('Time (sec)');

colormap('parula')









