function [predict_id,credit,M,scores]=test_seg_ID(ID,net,all_segments,fish_num)
frames_no=all_segments{ID}.segment_records(:,1);
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
[hi,cx_]=hist(scores,1:fish_num);
hi=hi/M;
predict_id=find(hi>0.25);
credit=hi(predict_id);
% [mcount,midx]=max(hi);
% predict_id=midx;
% credit=mcount/M;