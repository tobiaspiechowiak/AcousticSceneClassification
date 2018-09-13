
path = 'x:/Steering/Recordings/Processed/';
[a,~] = audioread(strcat(path,'ERB=2_MF_01.wav'));
[b,~] = audioread(strcat(path,'ERB=2_MF_02.wav'));
[c,~] = audioread(strcat(path,'ERB=2_MF_03.wav'));

data = [a b c];

figure; 
for idx = 1: 18    
    subplot(18,1,idx); plot(data(:,5 + 7*(idx-1))); set(gca,'ylim',[-0.9 0.9],'yTickLabel','')    
end