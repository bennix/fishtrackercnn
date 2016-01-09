figure;
grid on;
hold on
id_tracker_frame=[];
for frame=1:1999
    id_tracker_frame=[id_tracker_frame frame];
end
for fish_id=1:14
    proposed_x=-1*ones(1999,1);
    proposed_y=-1*ones(1999,1);
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
    plot3(proposed_x,proposed_y,id_tracker_frame,'-');
end