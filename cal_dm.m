function [distance_m]=cal_dm(filtered_pred,compare_pos)
N=length(filtered_pred);
distance_m=[];
compare_id=compare_pos;
for i=1:N
    if filtered_pred{i}.start_frame-filtered_pred{compare_id}.end_frame>0
        if filtered_pred{i}.start_frame-filtered_pred{compare_id}.end_frame<1000
            if sqrt((filtered_pred{i}.startx-filtered_pred{compare_id}.endx)^2+ ...
                    (filtered_pred{i}.starty-filtered_pred{compare_id}.endy)^2) < 2000
                distance_m(i).dis=sqrt((filtered_pred{i}.startx-filtered_pred{compare_id}.endx)^2+ ...
                    (filtered_pred{i}.starty-filtered_pred{compare_id}.endy)^2);
                distance_m(i).seg_ID=filtered_pred{i}.seg_ID;
                distance_m(i).credit= filtered_pred{i}.credit;
                distance_m(i).frame_diff=filtered_pred{i}.start_frame-filtered_pred{compare_id}.end_frame;
                distance_m(i).frame_size= filtered_pred{i}.end_frame-filtered_pred{i}.start_frame;
            end
        end
    end
end