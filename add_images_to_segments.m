load('E:\\fish3\\CoreView_256\\data\\all_segments');
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
        load(sprintf('E:\\fish3\\CoreView_256\\data\\fish_info_%d.mat',frame));
        segment_pictures(i).patch_head=fishinfo.headimages(idx).patch_head;
    end
    all_segments{id}.segment_pictures=segment_pictures;
end
%save('C:\\CoreView_258\\data\\all_segments','all_segments');
save('E:\\fish3\\CoreView_256\\data\\all_segments','all_segments')