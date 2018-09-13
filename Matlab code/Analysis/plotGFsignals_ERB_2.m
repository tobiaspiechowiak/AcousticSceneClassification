path = 'x:/Steering/Recordings/Processed/';
[data,~] = audioread(strcat(path,'ERB=2.wav'));


[NrChannels, cfs] = getGFBMultipleCenterERBs([0 1e4], 2);
cf = erbtofreq(cfs);

figure; 
len = 18;
for idx = 1:len
    subplot(len,1,idx); plot(data(:,idx)); set(gca,'ylim',[-0.4 0.4],'yTickLabel','','YScale','linear'); 
    title([num2str(cf(idx)) 'Hz']);
end