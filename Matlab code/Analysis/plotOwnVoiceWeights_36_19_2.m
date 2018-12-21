
path = '..\..\Python\';
a = load(strcat(path,'weights_first_layer_norm_NN_36-19-2_ownVoice_1-chan_MF.txt'));
b = load(strcat(path,'weights_second_layer_norm_NN_36-19-2_ownVoice_1-chan_MF.txt'));

colorm = 'jet';

figure;
subplot(1,2,1)
imagesc(a); colormap(colorm); colorbar
set(gca,'YDir','normal','YTick',1:18:37,'YTickLabel',{'Biases' 18:18:36},'fontweight','bold');
xlabel('Second (hidden) layer units');
ylabel('First (input) layer units');
caxis([-1 1]);

subplot(1,2,2)
imagesc(b); colormap(colorm); colorbar
set(gca,'YDir','normal','fontweight','bold','YTick',[1  11  20 ],'YTickLabel',{'Biases' '10' '19'},...
    'XTick',[1 2],'XTickLabel',{'No own voice' 'Own Voice'});
xlabel('Output layer units');
ylabel('Second (hidden) layer units');
caxis([-1 1]);
