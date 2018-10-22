
path = '..\..\Python\';

a = load(strcat(path,'weights_first_layer_norm_NN_108-18-5.txt'));
b = load(strcat(path,'weights_second_layer_norm_NN_108-18-5.txt'));


colorm = 'jet';

figure;
subplot(1,2,1)
imagesc(a); colormap(colorm); colorbar;
set(gca,'YDir','normal','YTick',[1 19 19+18 19+2*18 19+3*18 19+4*18 19+5*18],'YTickLabel',{'Biases' 18:18:108},'fontweight','bold');
xlabel('Second (hidden) layer units');
ylabel('First (input) layer units');

subplot(1,2,2)
imagesc(b); colormap(colorm); colorbar;
set(gca,'YDir','normal','fontweight','bold','YTick',[1 6 11 16 19],'YTickLabel',{'Biases' '5' '10' '15' '18'});
xlabel('Output layer units');
ylabel('Second (hidden) layer units');

