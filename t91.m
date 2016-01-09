N=length(tracks);
for n=1:N
    track=tracks{n};
    M=length(track);
    pos=1;
    seg=all_segments{track(pos)};
    track_records=seg.segment_records;
    
    pos=2;
    next_seg_ID=track(pos);
    
    while next_seg_ID~=-1
         [ratio, distance,records]=link_gap(filenamebase,next_seg_ID,n,tracks,all_segments);
         if distance<=20
           fprintf('Processing Track %d at %d\n',[n,next_seg_ID]);
           gap_fill=[ records(:,end) -1*ones(size(records,1),1) records(:,1) records(:,2) -1*ones(size(records,1),1) -1*ones(size(records,1),1)];
           seg_next=all_segments{track(pos)}.segment_records;
           track_records=[track_records; gap_fill;  seg_next];
           pos=pos+1;
           next_seg_ID=track(pos);
           
         elseif ratio>0.6 && distance>300 && length(pred{next_seg_ID}.credit)>1
            fprintf('Delete Track %d at %d\n',[n,next_seg_ID]);
            track(pos)=[];
            next_seg_ID=track(pos);
         else
             fprintf('Linear fill gap of Track %d at %d\n',[n,next_seg_ID]);
             startx=track_records(end,3);
             starty=track_records(end,4);
             frame_start=track_records(end,1);
             seg_next=all_segments{track(pos)}.segment_records;
             endx=seg_next(1,3);
             endy=seg_next(1,4);
             frame_end=seg_next(1,1);
             NUM=frame_end-frame_start+1;
             gap_x=linspace(startx,endx,NUM);
             gap_y=linspace(starty,endy,NUM);
             gap_frame=linspace(frame_start,frame_end,NUM);
             gap_x=gap_x(2:end-1)';
             gap_y=gap_y(2:end-1)';
             gap_frame=gap_frame(2:end-1)';
             gap_fill= [gap_frame -2*ones(size(gap_x,1),1) gap_x gap_y -2*ones(size(gap_x,1),1) -2*ones(size(gap_x,1),1)];
             track_records=[track_records; gap_fill;  seg_next];
             pos=pos+1;
             next_seg_ID=track(pos);
         end    
             
    end
    final_trajectorys{n}.track_records=track_records;
end
save('final_trajectorys','final_trajectorys');
