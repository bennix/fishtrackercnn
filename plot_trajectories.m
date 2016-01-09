ground_truth_id=14;
pairs= [1,10;2,13;3,1;4,6;5,2;6,12;7,8;8,7;9,11;10,9;11,4;12,3;13,14;14,5];

%pairs=[1,10;2,19;3,4;4,16;5,17;6,3;7,14;8,18;9,13;10,20;11,15;12,5;13,12;14,1;15,7;16,23;17,21;25,25;19,2;20,11;21,9;22,6;23,22;24,24;18,8];

id_tracker_id=pairs(pairs(:,2)==ground_truth_id,1);
%id_tracker_id=25;
figure;
grid on;
hold on
ground_x=[];
ground_y=[];
frame_z=[];
id_tracker_x=[];
id_tracker_y=[];
id_tracker_frame=[];
proposed_x=-1*ones(1999,1);
proposed_y=-1*ones(1999,1);

for frame=1:1999
    ground_x=[ground_x ground_truth_xy{ground_truth_id}.x(frame)];
    ground_y=[ground_y ground_truth_xy{ground_truth_id}.y(frame)];
    frame_z=[frame_z frame];
    
    id_tracker_x=[id_tracker_x trajectories(frame,id_tracker_id,1)];
    id_tracker_y=[id_tracker_y trajectories(frame,id_tracker_id,2)];
    id_tracker_frame=[id_tracker_frame frame];
    
end

N=size(final_trajectorys{ground_truth_id}.track_records,1);
for n=1:N
       frameno=final_trajectorys{ground_truth_id}.track_records(n,1);
       x=final_trajectorys{ground_truth_id}.track_records(n,3);
       y=final_trajectorys{ground_truth_id}.track_records(n,4);
       proposed_x(frameno)=x;
       proposed_y(frameno)=y;
       
end
proposed_x(proposed_x==-1)=NaN;
proposed_y(proposed_y==-1)=NaN;


plot3(ground_x,ground_y,frame_z,'g--','LineWidth',2);
plot3(id_tracker_x,id_tracker_y,id_tracker_frame,'b:','LineWidth',1.5);
plot3(proposed_x+1,proposed_y+1,id_tracker_frame,'r-','LineWidth',1.5);
view([-112 6]);
legend('Ground Truth','idTracker','Proposed');