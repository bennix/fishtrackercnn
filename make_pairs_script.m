%%Step 2
clear;
load('config.mat','filenamebase','database','total_frame','total_fish');
base_data=[database '\\fish_info_%d.mat'];
%base_data='C:\\CoreView_258\\data\\fish_info_%d.mat';
%filenamebase='C:\\CoreView_258\\Master Camera\\CoreView_258_Master_Camera_%05d.bmp';
% filenamebase='E:\\fish3\\CoreView_256\\Master Camera\\CoreView_256_Master_Camera_%05d.bmp';
% total_frame=2000;
%%
for frame=1:total_frame-1;
    filename1=sprintf(filenamebase,frame);
    fprintf('%d\n',frame);
    data_filename=sprintf(base_data,frame);
    load(data_filename);
    headimages1=fishinfo.headimages;
    headpoints1=fishinfo.headpoints;
    %frame=frame+1;
    filename2=sprintf(filenamebase,frame+1);
    data_filename=sprintf(base_data,frame+1);
    load(data_filename);
    headimages2=fishinfo.headimages;
    headpoints2=fishinfo.headpoints;
    N=size(headpoints1,1);
    M=size(headpoints2,1);
    difM=zeros(N,M);
%     for i=1:N
%         p1=(headimages1(i).patch_head);
%         [hi]=imhist(p1);
%         for j=1:M
%             p2=(headimages2(j).patch_head);
%             p2_=histeq(p2,hi);
%             C= normxcorr2(double(p1),double(p2_));
%             difM(i,j)=(max(C(:)));
%         end
%     end
    for i=1:N
        p1=im2double(headimages1(i).patch_head);
        for j=1:M
            p2=im2double(headimages2(j).patch_head);
            difM(i,j)=std2(p1-p2);
        end
    end
    
    pts1=headpoints1(:,1:2);
    pts2=headpoints2(:,1:2);
    distM=pdist2(pts1,pts2);
    angles1=headpoints1(:,3);
    angles2=headpoints2(:,3);
    match=[];
    match_images1=[];
    match_images2=[];
    N=size(distM);
    for i=1:N
        ids=find(distM(i,:)<50);
        v=difM(i,ids);
        [mv,midx]=min(v);
        t1=mod(angles1(i),360);
        t2=mod(angles2(ids(midx)),360);
        diff_angle=min(mod(t1-t2,360),mod(t2-t1,360));
        if diff_angle<30
            if mv<0.045%if mv>0.95
                if headpoints1(i,1)>210 && headpoints2(ids(midx),1)>210
                    match=[match; [i ids(midx) headpoints1(i,1) headpoints1(i,2) headpoints2(ids(midx),1) headpoints2(ids(midx),2) mv]];
%                 if isempty(match_images1)
%                     match_images1=headimages1(i).patch_head;
%                 else
%                     match_images1(:,:,end+1)=headimages1(i).patch_head;
%                 end
%                 if isempty(match_images2)
%                     match_images2=headimages2(ids(midx)).patch_head;
%                 else
%                     match_images2(:,:,end+1)=headimages2(ids(midx)).patch_head;
%                 end
                end
           end
        end
    end
    right_IDs=unique(match(:,2));
    NS=length(right_IDs);
    for ns=1:NS
        right_ID=right_IDs(ns);
        sel_m=match(match(:,2)==right_ID,:);
        if length(sel_m)>1
            sel_m=match(match(:,2)==right_ID,:);
            [~,idx]=min(sel_m(:,end));
            temp_match=sel_m(idx,:);
            match(match(:,2)==right_ID,:)=[];
            match=[match;temp_match];
        end
    end
    pairs{frame}.match=match;
%     pairs{frame}.match_images1=match_images1;
%     pairs{frame}.match_images2=match_images2;
    
end
save([database '\\recpairs'],'pairs');

