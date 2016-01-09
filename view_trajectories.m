load('final_trajectorys.mat')
warning off
close all
fig=figure;
for ID=1:14
    %filenamebase='E:\\CoreView_258\\Master Camera\\CoreView_258_Master_Camera_%05d.bmp';
    filenamebase='E:\\fish3\\CoreView_256\\Master Camera\\CoreView_256_Master_Camera_%05d.bmp';
    %writerObj = VideoWriter(['E:\\CoreView_258\\fish_' num2str(ID) '.avi']);
    writerObj = VideoWriter(['E:\\fish3\\CoreView_256\\fish_' num2str(ID) '.avi']);
    open(writerObj);
    
    
    
    
    records=final_trajectorys{ID}.track_records;
    N=size(records,1);
    track_x=[];
    track_y=[];
    for i=1:N
        frameno=records(i,1);
        sel_x=records(i,3);
        sel_y=records(i,4);
        track_x=[track_x;sel_x];
        track_y=[track_y;sel_y];
        strack_x=track_x(max(1,end-150):end);
        strack_y=track_y(max(1,end-150):end);
        filename=sprintf(filenamebase,frameno);
        im=imread(filename);
        imshow(im,[]);
        hold on
        plot(sel_x,sel_y,'g+');
        
        plot(strack_x,strack_y,'r-');
        hold off
        xlabel(num2str(frameno));
        drawnow();
        writeVideo(writerObj,getframe(fig));
    end
    close(writerObj);
end