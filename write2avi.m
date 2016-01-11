load('config.mat','filenamebase','database','total_frame','total_fish');
writerObj = VideoWriter([database '\\fish.avi']);
open(writerObj);
h = waitbar(0,'Please wait...');
M=total_frame;
for frame=1:M
    filename_org_base=filenamebase;
    filename=sprintf(filename_org_base,frame);
    im=imread(filename);
    fprintf('%05d\n',frame);
    writeVideo(writerObj,im);
    waitbar(frame / M, h, sprintf('write frame %5d',frame));
end
close(h);
close(writerObj);