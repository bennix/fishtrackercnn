
clear;
%filenamebase='~/fish2/CoreView_52_Master_Camera_%05d.bmp';
%filenamebase='F:\\fish2\\CoreView_52_Master_Camera_%05d.bmp';
%filenamebase='F:\\fish3\\CoreView_256\\Master Camera\\CoreView_256_Master_Camera_%05d.bmp';
%filenamebase='~/fish3/CoreView_256/Master Camera/CoreView_256_Master_Camera_%05d.bmp';
%filenamebase='F:\\fish_15\\CoreView_255_Master_Camera_%04d.bmp';
%filenamebase='D:\\ffish\\CoreView_258\\Master Camera\\CoreView_258_Master_Camera_%05d.bmp';
filenamebase='F:\\CoreView_258\\Master Camera\\CoreView_258_Master_Camera_%05d.bmp';

%06690
% 04835
% 02405
% 05847
% 01190
% 03620
frame=12;
[headpoints,headimages]=detect_fish_head2(filenamebase,frame);

filename=sprintf(filenamebase,frame);
im=imread(filename);
figure;
imshow(im,[]);hold on
plot(headpoints(:,1),headpoints(:,2),'r+');
hold off
N=length(headimages);
figure;
for i=1:N
    subplot(6,5,i);
    patch=headimages(i).patch_head;
    imshow(patch,[])
   
end