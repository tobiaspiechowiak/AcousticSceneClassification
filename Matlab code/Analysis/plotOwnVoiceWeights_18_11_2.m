
path = '..\..\Python\';
a = load(strcat(path,'weights_first_layer_norm_NN_18-10-2_ownVoice_1-chan_MF.txt'));
b = load(strcat(path,'weights_second_layer_norm_NN_18-10-2_ownVoice_1-chan_MF.txt'));

colorm = 'jet';

figure;
subplot(1,2,1)
imagesc(a); colormap(colorm); colorbar
set(gca,'YDir','normal','YTick',1:18:19,'YTickLabel',{'Biases' 18:18:18},'fontweight','bold');
xlabel('Second (hidden) layer units');
ylabel('First (input) layer units');
caxis([-1 1]);

subplot(1,2,2)
imagesc(b); colormap(colorm); colorbar
set(gca,'YDir','normal','fontweight','bold','YTick',[1 12],'YTickLabel',{'Biases' '11'},...
    'XTick',[1 2],'XTickLabel',{'No own voice' 'Own Voice'});
xlabel('Output layer units');
ylabel('Second (hidden) layer units');
caxis([-1 1]);
