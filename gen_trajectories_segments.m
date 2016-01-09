%%Step 3
%function gen_trajectories_segments(handles)
clear;
load('config.mat','filenamebase','database','total_frame','total_fish');
% total_frame=2000;
handles.total_length=total_frame;
load([database '\\recpairs.mat']);
%load('C:\\CoreView_258\\data\\recpairs.mat');

[frame,id]=first_available_frame_id(pairs);
p=1;
while frame~=-1
    
    [segment_records,pairs]=extract_id_segment(pairs,frame,id,handles.total_length);
    segment_records(:,end+1)=p;
    all_segments{p}.segment_records=segment_records;
    fprintf('found %d  track segment with length of %5d\n',[p,size(segment_records,1)]);  
    [frame,id]=first_available_frame_id(pairs);
    p=p+1;
end
N=length(all_segments);

p=1;
for i=1:N
    if size(all_segments{i}.segment_records,1)>2
       new_all_segments{p}=all_segments{i};
       all_segments{i}.segment_records(:,end)=p;
       p=p+1;
    end
end
all_segments=new_all_segments;
N=length(all_segments);
p=1;
for i=1:N
    if size(all_segments{i}.segment_records,1)>=3
        all_segments2{p}=all_segments{i};
        p=p+1;
    end
end
all_segments=all_segments2;
N=length(all_segments);
for i=1:N
    all_segments{i}.segment_records(:,end)=i;
end
fprintf('found %d  track segments\n',length(all_segments)); 
%save('C:\\CoreView_258\\data\\all_segments','all_segments');
save([database '\\all_segments'],'all_segments');
load([database '\\all_segments']);
%load('C:\\CoreView_258\\data\\all_segments.mat')
N=length(all_segments);
for id=1:N
    fprintf('%05d\n',id);
    segment_records=all_segments{id}.segment_records;
    M=size(segment_records,1);
    segment_pictures=[];
    for i=1:M
        frame=segment_records(i,1);
        idx=segment_records(i,2);
        %load(sprintf('C:\\CoreView_258\\data\\fish_info_%d.mat',frame));
        load(sprintf([database '\\fish_info_%d.mat'],frame));
        segment_pictures(i).patch_head=fishinfo.headimages(idx).patch_head;
    end
    all_segments{id}.segment_pictures=segment_pictures;
end
%save('C:\\CoreView_258\\data\\all_segments','all_segments');
save([database '\\all_segments'],'all_segments')