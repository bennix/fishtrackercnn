function [imdb,V,frame_thres]=grab_samples(net,all_segments,frame_thres)
% net.layers=layers;
% net.imageMean=imageMean;
MIDs{1}=[1 17 20 22 23 28 31 35 39 53 65 69 70 73 87 113];
MIDs{2}=[2 29 34 59 62 93 96 111];
MIDs{3}=[3 16 57 60 67 90 104 106 110];
MIDs{4}=[4 15 41 52 64 74 80 82 107];
MIDs{5}=[5 43 56 72 103 108];
MIDs{6}=[6 45 48 83 86];
MIDs{7}=[7 75 79 91 97 100 105];
MIDs{8}=[8 19 42 49 68 77 84 88 99];
MIDs{9}=[9 26 51 61 91 97 100 105];
MIDs{10}=[10 40 101];
MIDs{11}=[11 18 25 32 37 46 58 85 95 102];
MIDs{12}=[12 30 36 47 54 81 92 112];
MIDs{13}=[13 50];
MIDs{14}=[14 21 24 33 38 44 55 63 66 71 76 78 94 98 109];
max_ID=0;
for i=1:14
    max_ID=max(max_ID,max(MIDs{i}));
end    
for i=1:14
    V{i}=[];
    flagV{i}=[];
    CreditV{i}=[];
    segment_records_num(i)=0;
end
for ID=1:length(all_segments)
    fprintf('ID: %d\n',ID);
    frames_no=all_segments{ID}.segment_records(:,1);
    if any(frames_no>=frame_thres)
        flag=1;
    else
        flag=0;
    end
    pictures=all_segments{ID}.segment_pictures;
    M=length(pictures);
    scores=zeros(M,1);
    for m=1:M
        im=pictures(m).patch_head;
        im=single(im);
        im=im-net.imageMean;
        res = vl_simplenn(net, im) ;
        res2=res(end).x(:);
        [~,midx]=max(res2);
        scores(m)=midx;
    end
    [hi,cx_]=hist(scores,1:14);
    [mcount,midx]=max(hi);
    predict_id=midx;
    credit=mcount/M;
    
    if credit>0.7 && ID>max_ID
        V{predict_id}=[V{predict_id} ID];
        flagV{predict_id}=[flagV{predict_id} flag];
        CreditV{predict_id}=[CreditV{predict_id} credit];
        segment_records_num(predict_id)=all_segments{ID}.segment_records(end,1);
    end
    
    N=length(flagV);
    sp=0;
    for i=1:N
        F=flagV{i};
        if any(F==1)
            sp=sp+1;
        end
    end
    if sp>=14
        break
    end
end

N=length(flagV);

for i=1:N
    IDs=V{i};
    credits=CreditV{i};
    fprintf('ID %d: ' ,i) 
    M=length(IDs);
    for m=1:M
      fprintf('%d [%5.2f] ',[IDs(m)  credits(m)]);
      %fprintf('%d ',[IDs(m)]);
    end
    fprintf('\n');
end



for i=1:N
    IDs=V{i};
    V{i}=union(IDs,MIDs{i});
end

for i=1:N
    IDs=V{i};
    M=length(IDs);
    sample_pictures=[];
    for m=1:M
        sel_ID=IDs(m);
        segment_pictures=all_segments{sel_ID}.segment_pictures;
        sample_pictures=[sample_pictures segment_pictures ];
    end
    IDX=randperm(length(sample_pictures));
    cut_points=round(length(sample_pictures)*0.8);
    trained_picture=sample_pictures(IDX(1:cut_points));
    vali_picture=sample_pictures(IDX(cut_points+1:end));
    trained_pictures{i}=trained_picture;
    vali_pictures{i}=vali_picture;
    trained_ids{i}.ids=ones(1,length(trained_picture))*i;
    vali_ids{i}.ids=ones(1,length(vali_picture))*i;
    
end

N=length(trained_pictures);
data=zeros(61,61,1,1);
labels=zeros(1,1);
set=zeros(1,1);
for i=1:N
    trained_picture_temp=trained_pictures{i};
    trained_ids_temp=trained_ids{i}.ids;
    M=length(trained_picture_temp);
    for m=1:M
        data(:,:,1,end+1)=single(trained_picture_temp(m).patch_head);
        labels(1,end+1)=trained_ids_temp(m);
        set(1,end+1)=1;
    end
    
end
data(:,:,:,1)=[];
labels(1)=[];
set(1)=[];

N=size(data,4);
IDX=randperm(N);
traindata=data(:,:,:,IDX);
trainlabels=labels(:,IDX);
trainsets=set(:,IDX);


N=length(vali_pictures);
data=zeros(61,61,1,1);
labels=zeros(1,1);
set=zeros(1,1);
for i=1:N
    valid_picture_temp=vali_pictures{i};
    valid_ids_temp=vali_ids{i}.ids;
    M=length(valid_picture_temp);
    for m=1:M
        data(:,:,1,end+1)=single(valid_picture_temp(m).patch_head);
        labels(1,end+1)=valid_ids_temp(m);
        set(1,end+1)=3;
    end
    
end
data(:,:,:,1)=[];
labels(1)=[];
set(1)=[];

N=size(data,4);
IDX=randperm(N);
validdata=data(:,:,:,IDX);
validlabels=labels(:,IDX);
validsets=set(:,IDX);

data=cat(4,traindata,validdata);
labels=cat(2,trainlabels,validlabels);
set=cat(2,trainsets,validsets);

dataMean = mean(data(:,:,:,set == 1), 4);
data = bsxfun(@minus, data, dataMean) ;

imdb.images.data = single(data) ;
imdb.images.labels = labels ;
imdb.images.dataMean = dataMean;
imdb.images.set = set;
imdb.meta.sets = {'train', 'val', 'test'} ;
imdb.meta.classes = arrayfun(@(x)sprintf('%d',x),1:14,'uniformoutput',false) ;


frame_thres=min(segment_records_num);