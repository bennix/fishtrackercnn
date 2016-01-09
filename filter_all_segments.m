function [filtered_segments]=filter_all_segments(all_segments,x,y,frame,before,handles)
filtered_segments={};
frame_thres=300;
dist_thres=1000;
p=1;
if before==1
    N=length(all_segments);
    for i=1:N
       segment_records= all_segments{i}.segment_records;
       headimages_rep=all_segments{i}.headimages_rep;
       if (segment_records(end,1)<frame) && ((frame-segment_records(end,1))<frame_thres)
           x_end=segment_records(end,3);
           y_end=segment_records(end,4);
           d=sqrt((x- x_end)^2+(y- y_end)^2);
           if d<=dist_thres
               if size(segment_records,1)>5
                   if segment_records(1,end)>handles.total_fish
                      filtered_segments{p}.segment_records=segment_records;
                      filtered_segments{p}.segment_pictures=segment_pictures;
                      p=p+1;
                   end
               end
           end
       end    
    end
else
    N=length(all_segments);
    for i=1:N
       segment_records= all_segments{i}.segment_records;
       segment_pictures=all_segments{i}.segment_pictures;
       if (segment_records(1,1)>frame) && ((segment_records(1,1)-frame)<frame_thres)
           x_end=segment_records(1,3);
           y_end=segment_records(1,4);
           d=sqrt((x- x_end)^2+(y- y_end)^2);
           if d<=dist_thres
               %if size(segment_records,1)>5
               if segment_records(1,end)>handles.total_fish
                  filtered_segments{p}.segment_records=segment_records;
                  filtered_segments{p}.segment_pictures=segment_pictures;
                  p=p+1;
               end
           end
       end    
    end
end

