
path = '..\..\Python\';
a = load(strcat(path,'weights_first_layer_norm_NN_108-18-2_ownVoice.txt'));
b = load(strcat(path,'weights_second_layer_norm_NN_108-18-2_ownVoice.txt'));

colorm = 'jet';

figure;
subplot(1,2,1)
imagesc(a); colormap(colorm); colorbar
set(gca,'YDir','normal','YTick',[1 19 37],'YTickLabel',{'Biases' '18' '36'},'fontweight','bold');
xlabel('Second (hidden) layer units');
ylabel('First (input) layer units');

subplot(1,2,2)
imagesc(b); colormap(colorm); colorbar
set(gca,'YDir','normal','fontweight','bold','YTick',[1 4 9 14 19],'YTickLabel',{'Biases' '5' '10' '15' '18'},...
    'XTick',[1 2],'XTickLabel',{'No own voice' 'Own Voice'});
xlabel('Output layer units');
ylabel('Second (hidden) layer units');

