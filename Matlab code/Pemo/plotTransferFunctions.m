
addpath('Pemo')
fs = 2000;

freq = linspace(0, fs/2,512)';

fig1 = figure;

delta = [zeros(1000,1); 1; zeros(fs * 0.2,1)];

%% Modulation filterbank

[bla, out] = mfb2(delta,0,500,1,2,fs);

for idx = 1:size(out,2)
   
    [H(:,idx),w(:,idx)] = freqz(out(:,idx));
    H_mag(:,idx) = 20*log10(abs(H(:,idx)));
    hold on; 
    plot(freq,H_mag(:,idx),'Linewidth',2);    
end

set(gca,'YLim',[-20 5],'XLim',[0 700],...
    'XTick',0:100:700,'XScale','lin');

hold on; 
plot([0 700],[0 0],'k--','Linewidth',2);

legend({'0 Hz' '4 Hz' '10.4 Hz' '27.4 Hz' '71.7 Hz' '187.9 Hz' '491.9 Hz'});

xlabel('Hz'); ylabel('dB');

title('Modulation Filterbank Magnitude');

%% Gammatone filterbank

fs = 30000;

delta = [zeros(100,1); 1; zeros(fs * 0.2,1)];

freq = linspace(0, fs/2,512)';

fig2 = figure;

[out, cfs] = GammaProc(delta, 0, 1e4, 2, fs);
cfs = erbtofreq(cfs); 

%ERB = 2
subplot(2,1,1);

for idx = 1:size(out,2)
   
    [H(:,idx),w(:,idx)] = freqz(out(:,idx));
    H_mag(:,idx) = 20*log10(abs(H(:,idx)));
    hold on; 
    plot(freq,H_mag(:,idx),'Linewidth',2);    
end


set(gca,'YLim',[-10 5],'XLim',[0 1.1*1e4],...
    'XTick',0:1000:1.1*1e4,'XScale','log');

hold on; 
plot([0 1.1*1e4],[0 0],'k--','Linewidth',2);

%legend({'0 Hz' '4 Hz' '10.4 Hz' '27.4 Hz' '71.7 Hz' '187.9 Hz' '491.9 Hz'});

xlabel('Hz'); ylabel('dB');

title('Gammtone Magnitude Density = 1 ERB');


%ERB = 1

[out, cfs] = GammaProc(delta, 0, 1e4, 1, fs);
cfs = erbtofreq(cfs); 

subplot(2,1,2);

for idx = 1:size(out,2)
   
    [H(:,idx),w(:,idx)] = freqz(out(:,idx));
    H_mag(:,idx) = 20*log10(abs(H(:,idx)));
    hold on; 
    plot(freq,H_mag(:,idx),'Linewidth',2);    
end


set(gca,'YLim',[-10 5],'XLim',[0 1.1*1e4],...
    'XTick',0:1000:1.1*1e4,'XScale','log');

hold on; 
plot([0 1.1*1e4],[0 0],'k--','Linewidth',2);

%legend({'0 Hz' '4 Hz' '10.4 Hz' '27.4 Hz' '71.7 Hz' '187.9 Hz' '491.9 Hz'});

xlabel('Hz'); ylabel('dB');

title('Gammtone Magnitude Density = 2 ERB');



