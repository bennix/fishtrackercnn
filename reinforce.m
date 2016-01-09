count_all=length(all_segments);
count_train=0;
N=length(tracks);
for n=1:N
    count_train=count_train+length(tracks{n});
end
count_train/count_all

load('E:\fish3\CoreView_256\data\pred','pred');
load('tracks_training.mat')
N=length(pred);
for n=1:N
    if length(pred{n}.credit)==1 && (pred{n}.credit==1)
        tracks{pred{n}.predict_id}=[ tracks{pred{n}.predict_id} n];
    end
end
N=length(tracks);
for n=1:N
    tracks{n}=unique(tracks{n});
end

count_train=0;
N=length(tracks);
for n=1:N
    count_train=count_train+length(tracks{n});
end
count_train/count_all

save('tracks_training2.mat','tracks');