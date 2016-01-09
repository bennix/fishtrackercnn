load('config.mat','filenamebase','database','total_frame','total_fish');
load([database '\all_segments.mat']);
% net.layers=layers;
% net.imageMean=imageMean;
fish_num=total_fish;
N=length(all_segments);
for ID=1:N
     start_frame=all_segments{ID}.segment_records(1,1);
     startx=all_segments{ID}.segment_records(1,3);
     starty=all_segments{ID}.segment_records(1,4);
     
     end_frame=all_segments{ID}.segment_records(end,1);
     endx=all_segments{ID}.segment_records(end,3);
     endy=all_segments{ID}.segment_records(end,4);
     
     [predict_id,credit,M,scores]=test_seg_ID(ID,net,all_segments,fish_num);
     fprintf('ID: %d predict as ',ID);
     fprintf('%d ',predict_id);
     fprintf('with credit  ');
     fprintf('%5.2f ',credit);
     fprintf('\n');
     pred{ID}.start_frame=start_frame;
     pred{ID}.startx=startx;
     pred{ID}.starty=starty;
     pred{ID}.end_frame=end_frame;
     pred{ID}.endx=endx;
     pred{ID}.endy=endy;
     pred{ID}.predict_id=predict_id;
     pred{ID}.credit=credit;
     
     
end
save([database '\pred'],'pred');
save([database '\fishcnn2'],'net');
