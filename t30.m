load('config.mat','filenamebase','database','total_frame','total_fish');
load([database '\pred'],'pred');
load([database '\all_segments'],'all_segments');
filenamebase=filenamebase;
for ID=1:total_fish
    seg=ID;
    fprintf('%d ',seg);
    tracks{ID}=ID;
    while seg~=-1
      [seg]=link_gap2(pred,ID,seg);
      fprintf('%d ',seg);
      tracks{ID}=[tracks{ID} seg];
    end
    fprintf('\n');
end

N=length(all_segments);
marks=zeros(N,1);
N=length(tracks);
for ID=1:N
   posi=tracks{ID};
   posi(posi==-1)=[];
   marks(posi)=marks(posi)+1;
end

for ID=1:total_fish
    track=tracks{ID};
    N=length(track);
    track_new=[];
    for n=1:N-2
        seg_begin=track(n); 
        seg_end=track(n+1);
        [filled_id]=pad_between_gap(pred,seg_begin,seg_end,marks);
        if  ~isempty(filled_id);
            if length(filled_id)==1
               track_new=[track_new seg_begin filled_id];
               fprintf('%d --ins-- %d ',[seg_begin,filled_id]);
            else
                track_new=[track_new seg_begin];
                fprintf('%d ',seg_begin);
                M=length(filled_id);
                v=zeros(M,1);
                for m=1:M
                    temp_id=filled_id(m);
                    if ismember(ID,pred{temp_id}.predict_id)
                        v(m)=pred{temp_id}.credit(pred{temp_id}.predict_id==ID);
                         
                    end
                    
                end
                
                [v_min,idx]=max(v(m));
                if v_min~=0
                   temp_id=filled_id(idx);
                   track_new=[track_new temp_id];
                   fprintf('--ins --%d ',temp_id);
                end
            end
        else
            track_new=[track_new seg_begin ];
            fprintf('%d ',seg_begin);
        end
        
    end
    fprintf('%d -1\n',seg_end);
    track_new=[track_new seg_end -1 ];
    tracks{ID}=track_new;
end

N=length(all_segments);
marks=zeros(N,1);
N=length(tracks);
for ID=1:N
   posi=tracks{ID};
   posi(posi==-1)=[];
   marks(posi)=marks(posi)+1;
end

err_seg_ids=find(marks>1);

N=length(err_seg_ids);
for i=1:N
    error_seg_id=err_seg_ids(i);
    Q=length(tracks);
    est_track_ids=[];
    for q=1:Q
       if ismember(error_seg_id, tracks{q})
         est_track_ids=[est_track_ids q];
       end
    end
    M=length(est_track_ids);
    compare_matrix=zeros(M,2);
    for m=1:M
        est_track_id=est_track_ids(m);
        [compare_matrix(m,1),compare_matrix(m,2)]=link_gap(filenamebase,error_seg_id,est_track_id,tracks,all_segments);
        fprintf('seg ID: %5d @ track ID %5d : ratio is %5.2f distance is %5.2f\n',[error_seg_id, est_track_id, compare_matrix(m,1),compare_matrix(m,2)]);
    end
    [dis_min,min_idx]=min(compare_matrix(:,2));
    if dis_min<=20
        ratio=compare_matrix(min_idx,1);
        marks=ones(length(est_track_ids),1);
        marks(min_idx)=0;
        remove_tracks_ids=est_track_ids(marks==1);
        M=length(remove_tracks_ids);
        for m=1:M
            remove_tracks_id=remove_tracks_ids(m);
            track=tracks{remove_tracks_id};
            track(track==error_seg_id)=[];
            tracks{remove_tracks_id}=track;
        end
    else
        marks=ones(length(est_track_ids),1);
        remove_tracks_ids=est_track_ids(marks==1);
        M=length(remove_tracks_ids);
        for m=1:M
            remove_tracks_id=remove_tracks_ids(m);
            track=tracks{remove_tracks_id};
            track(track==error_seg_id)=[];
            tracks{remove_tracks_id}=track;
        end
    end
    
end



