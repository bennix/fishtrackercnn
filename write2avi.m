writerObj = VideoWriter('F:\fish3\CoreView_256\\fish.avi');
open(writerObj);
h = waitbar(0,'Please wait...');
M=2000;
for frame=1:M
    filename_org_base='F:\\fish3\\CoreView_256\\Master Camera\\CoreView_256_Master_Camera_%05d.bmp';
    filename=sprintf(filename_org_base,frame);
    im=imread(filename);
    fprintf('%05d\n',frame);
    writeVideo(writerObj,im);
    waitbar(frame / M, h, sprintf('write frame %5d',frame));
end
close(h);
close(writerObj);