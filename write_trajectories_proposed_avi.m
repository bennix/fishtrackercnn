load('config.mat','filenamebase','database','total_frame','total_fish');
% filenamebase='E:\\CoreView_258\\Master Camera\\CoreView_258_Master_Camera_%05d.bmp';
% database='E:\CoreView_258\data';
% total_fish=25;
% total_frame=5000;
load('final_trajectorys.mat')
writerObj = VideoWriter([database '\\fish_track_result.avi']);

open(writerObj);
id_tracker_frame=[];
for frame=1:total_frame-1
    id_tracker_frame=[id_tracker_frame frame];
end
for fish_id=1:total_fish
    proposed_x=-1*ones(total_frame-1,1);
    proposed_y=-1*ones(total_frame-1,1);
    N=size(final_trajectorys{fish_id}.track_records,1);
    for n=1:N
        frameno=final_trajectorys{fish_id}.track_records(n,1);
        x=final_trajectorys{fish_id}.track_records(n,3);
        y=final_trajectorys{fish_id}.track_records(n,4);
        proposed_x(frameno)=x;
        proposed_y(frameno)=y;
        
    end
    proposed_x(proposed_x==-1)=NaN;
    proposed_y(proposed_y==-1)=NaN;
    proposed_xy{fish_id}.proposed_x=proposed_x;
    proposed_xy{fish_id}.proposed_y=proposed_y;
    
    %plot3(proposed_x,proposed_y,id_tracker_frame,'-');
end
figure;
for frame=1:total_frame-1
    filename_org_base=filenamebase;
    filename=sprintf(filename_org_base,frame);
    im=imread(filename);
    cla;
    imshow(im,[]);
    hold on
    for fish_id=1:total_fish
        x=proposed_xy{fish_id}.proposed_x(frame);
        y=proposed_xy{fish_id}.proposed_y(frame);
        strack_x=proposed_xy{fish_id}.proposed_x(max(1,frame-150):frame);
        strack_y=proposed_xy{fish_id}.proposed_y(max(1,frame-150):frame);
        plot(strack_x,strack_y,'-');
        text(x+5,y+5,num2str(fish_id),'FontSize',14,'Color','r');
    end
    text(size(im,2)-400,size(im,1)-50,['Frame #:' num2str(frame)],'FontSize',14,'Color','g'); 
    hold off
    F=getframe(gcf);
    writeVideo(writerObj,F);
end
close(writerObj);