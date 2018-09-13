
path = '..\..\Python\';

a = load(strcat(path,'weights_first_layer_norm_NN_756-126-5.txt'));
b = load(strcat(path,'weights_second_layer_norm_NN_756-126-5.txt'));


colorm = 'jet';

figure;
subplot(1,2,1)
imagesc(a); colormap(colorm); colorbar;
set(gca,'YDir','normal','YTick',[1 127:126:756+1],'YTickLabel',{'Biases' 126:126:756},'fontweight','bold');
xlabel('Second (hidden) layer units');
ylabel('First (input) layer units');

subplot(1,2,2)
imagesc(b); colormap(colorm); colorbar;
set(gca,'YDir','normal','fontweight','bold','YTick',[1 19:18:127],'YTickLabel',{'Biases' num2str(18:18:126)});
xlabel('Output layer units');
ylabel('Second (hidden) layer units');

