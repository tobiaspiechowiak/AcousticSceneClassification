
path = '..\..\Python\';

a = load(strcat(path,'weights_first_layer_norm_NN_756-18-7-5.txt'));
b = load(strcat(path,'weights_second_layer_norm_NN_756-18-7-5.txt'));
c = load(strcat(path,'weights_third_layer_norm_NN_756-18-7-5.txt'));


colorm = 'jet';

figure;
subplot(1,3,1)
imagesc(a); colormap(colorm); colorbar
set(gca,'YDir','normal','YTick',[1 127:126:756+1],'YTickLabel',{'Biases' 126:126:756},'fontweight','bold');
xlabel('Second (hidden) layer units');
ylabel('First (input) layer units');

subplot(1,3,2)
imagesc(b); colormap(colorm); colorbar
set(gca,'YDir','normal','fontweight','bold','YTick',[1 5 10 15 18],'YTickLabel',{'Biases' '5' '10' '15' '18'},...
    'XTick',[1 5 7]);
xlabel('Output layer units');
ylabel('Second (hidden) layer units');

subplot(1,3,3)
imagesc(c); colormap(colorm); colorbar
set(gca,'YDir','normal','fontweight','bold','YTick',[1 5 7 ],'YTickLabel',{'Biases' '5' '7'},...
    'XTick',[1 2 3 4 5],'XTickLabel',{'Babble' 'Own-voice' 'Car' 'Speech' 'Traffic'});
xlabel('Output layer units');
ylabel('Second (hidden) layer units');
