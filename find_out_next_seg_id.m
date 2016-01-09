function [next_pos,next_seg_id]=find_out_next_seg_id(ID,pred,compare_pos)
[filtered_pred]=GetAllcandidateSegments(ID,pred);

N=length(filtered_pred);
%distance_m=[];
%compare_id=compare_pos;

if compare_pos<N
    [distance_m]=cal_dm(filtered_pred,compare_pos);
    N=length(distance_m);
    sc=zeros(N,3);
    VERYMAX=999999999999;
    for i=1:N
        if isempty(distance_m(i).dis)
            sc(i,:)=VERYMAX;
        else
            sc(i,1)=distance_m(i).dis;
            sc(i,2)=distance_m(i).frame_diff;
            sc(i,3)=distance_m(i).seg_ID;
        end
    end
    if N>=1
        [mv1,idx1]=min(sc(:,1));
        [mv2,idx2]=min(sc(:,2));
        if  mv1~=VERYMAX && mv2~=VERYMAX
            next_seg_id=sc(idx2,3);
            next_pos=idx2;
        elseif mv1==VERYMAX || mv2==VERYMAX
            next_seg_id=-1;
            next_pos=-1;
%         else
%             next_seg_id=sc(idx1,3);
%             next_pos=idx1;
        end
    else
        next_seg_id=-1;
        next_pos=-1;
    end
else
    next_pos=-1;
    next_seg_id=-1;
end
%fprintf('Next Seg ID: %d Next Pos %d\n',[quest_SegID,quest_pos]);

