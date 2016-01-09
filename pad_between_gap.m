function [filled_id]=pad_between_gap(pred,seg_begin,seg_end,marks)
startx=pred{seg_begin}.endx;
starty=pred{seg_begin}.endy;
start_frame=pred{seg_begin}.end_frame;

endx=pred{seg_end}.startx;
endy=pred{seg_end}.starty;
end_frame=pred{seg_end}.start_frame;

avialiable_seg_ids=find(marks==0);

N=length(avialiable_seg_ids);
filled_id=[];
for i=1:N
    id=avialiable_seg_ids(i);
    sx=pred{id}.startx;
    sy=pred{id}.starty;
    sframe=pred{id}.start_frame;
    ex=pred{id}.endx;
    ey=pred{id}.endy;
    eframe=pred{id}.end_frame;
    if sframe> start_frame && eframe<end_frame
       begin_dist=sqrt((sx-startx)^2+(sy-starty)^2);
       end_dist=sqrt((ex-endx)^2+(ey-endy)^2);
       if begin_dist<=500 || end_dist<=500
           filled_id=[filled_id id];
           
       end
    end
    
end
