
figure; 
subplot(2,2,1); 
imagesc(spec(1,3).voice,[-50 10]); colormap('jet')
title('Own voice');
subplot(2,2,2)
imagesc(spec(1,3).car,[-50 10]); colormap('jet')
title('car');
subplot(2,2,3)
imagesc(spec(1,3).meeting,[-50 10]); colormap('jet')
title('Meeting');
subplot(2,2,4)
imagesc(spec(1,3).canteen,[-50 10]); colormap('jet')
title('Canteen');


