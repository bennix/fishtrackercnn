function [filtered_pred]=GetAllcandidateSegments(ID,pred)
N=length(pred);

p=1;
filtered_pred=[];
for i=1:N
    if ismember(ID,pred{i}.predict_id)
        filtered_pred{p}=pred{i};
        filtered_pred{p}.seg_ID=i;
        p=p+1;

    end
end
    
% N=length(filtered_pred);
% marks=zeros(N,1);
% for i=1:N-1
%     marks(i,2)=filtered_pred{i}.seg_ID;
%     if filtered_pred{i}.end_frame>filtered_pred{i+1}.start_frame
%         if length(filtered_pred{i}.predict_id)>1
%            marks(i,1)=1;
%            marks(i,2)=filtered_pred{i}.seg_ID;
%         else
%            marks(i,1)=0;
%            marks(i,2)=filtered_pred{i}.seg_ID;
%         end
%     end
% end
% marks(N,2)=filtered_pred{N}.seg_ID;
% filtered_pred(marks(:,1)==1)=[];
