function imdb = getFishImdb(opts)
% --------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
load('config.mat','filenamebase','database','total_frame','total_fish');

basedir=[database '\train2\'];
percent=0.8;
percent2=0.9;

for class_id=1:opts.fishnum

   l=dir([basedir num2str(class_id) '\*.bmp']);
   N=length(l);
   cut_point=round(N*percent);
   cut_point2=round(N*percent2);
   ids=randperm(N);
   train_ids{class_id}=ids(1:cut_point);
   validate_ids{class_id}=ids(cut_point+1:cut_point2);
   test_ids{class_id}=ids(cut_point2+1:end);
end

p=1;

for class_id=1:opts.fishnum
    l=dir([basedir num2str(class_id) '\*.bmp']);
    sel_ids=train_ids{class_id};
    M=length(sel_ids);
    for m=1:M
        sel_id=sel_ids(m);
        filename=[basedir num2str(class_id) '\' l(sel_id).name];
        fprintf('%s\n',filename);
        im=imread(filename);
        image_struct(p).data=single(im);
        image_struct(p).label=class_id;
        image_struct(p).set=1;
        p=p+1;
    end
    
    
end

p=1;
for class_id=1:opts.fishnum
    l=dir([basedir num2str(class_id) '\*.bmp']);
    sel_ids=validate_ids{class_id};
    M=length(sel_ids);
    for m=1:M
        sel_id=sel_ids(m);
        filename=[basedir num2str(class_id) '\' l(sel_id).name];
        fprintf('%s\n',filename);
        im=imread(filename);
        image_struct2(p).data=single(im);
        image_struct2(p).label=class_id;
        image_struct2(p).set=3;
        p=p+1;
    end
    
    
end

p=1;

for class_id=1:opts.fishnum
    l=dir([basedir num2str(class_id) '\*.bmp']);
    sel_ids=test_ids{class_id};
    M=length(sel_ids);
    for m=1:M
        sel_id=sel_ids(m);
        filename=[basedir num2str(class_id) '\' l(sel_id).name];
        fprintf('%s\n',filename);
        im=imread(filename);
        image_struct3(p).data=single(im);
        image_struct3(p).label=class_id;
        image_struct3(p).set=2;
        p=p+1;
    end
end

N=length(image_struct);

sample_idxs=randperm(N);

for i=1:N
    sel_id=sample_idxs(i);
    if i==1
       data=image_struct(sel_id).data;
       
    else
       data(:,:,1,end+1)= image_struct(sel_id).data;
    end
    labels(i)=image_struct(sel_id).label;
    set(i)=image_struct(sel_id).set;
end

N=length(image_struct2);

sample_idxs=randperm(N);

for i=1:N
    sel_id=sample_idxs(i);
    data(:,:,1,end+1)= image_struct2(sel_id).data;

    labels(end+1)=image_struct2(sel_id).label;
    set(end+1)=image_struct2(sel_id).set;
end

N=length(image_struct3);

sample_idxs=randperm(N);

for i=1:N
    sel_id=sample_idxs(i);
    data(:,:,1,end+1)= image_struct3(sel_id).data;

    labels(end+1)=image_struct3(sel_id).label;
    set(end+1)=image_struct3(sel_id).set;
end

%set(round(0.9*data_length):end)=3;

dataMean = mean(data(:,:,:,set == 1), 4);
% remove mean in any case
data = bsxfun(@minus, data, dataMean) ;

% normalize by image mean and std as suggested in `An Analysis of
% Single-Layer Networks in Unsupervised Feature Learning` Adam
% Coates, Honglak Lee, Andrew Y. Ng
% N=size(data,4);
% if opts.contrastNormalization
%   z = reshape(data,[],N) ;
%   z = bsxfun(@minus, z, mean(z,1)) ;
%   n = std(z,0,1) ;
%   z = bsxfun(@times, z, mean(n) ./ max(n, 40)) ;
%   data = reshape(z, 61, 61, 1, []) ;
% end
% 
% if opts.whitenData
%   z = reshape(data,[],N) ;
%   W = z(:,set == 1)*z(:,set == 1)'/N ;
%   [V,D] = eig(W) ;
%   % the scale is selected to approximately preserve the norm of W
%   d2 = diag(D) ;
%   en = sqrt(mean(d2)) ;
%   z = V*diag(en./max(sqrt(d2), 14))*V'*z ;
%   data = reshape(z, 61, 61, 1, []) ;
% end

%clNames = load(fullfile(unpackPath, 'batches.meta.mat'));

imdb.images.data = data ;
imdb.images.labels = labels ;
imdb.images.dataMean = dataMean;
imdb.images.set = set;
imdb.meta.sets = {'train', 'val', 'test'} ;
imdb.meta.classes = arrayfun(@(x)sprintf('%d',x),1:opts.fishnum,'uniformoutput',false) ;
