function [segment_records,pairs]=extract_id_segment(pairs,startframe,in_frame_id,total_frameno)
startid=in_frame_id;
frame=startframe;
cm=pairs{frame}.match;
x1=cm(cm(:,1)==startid,3);
y1=cm(cm(:,1)==startid,4);

next_id=cm(cm(:,1)==startid,2);
score=cm(cm(:,1)==startid,end);
cm(cm(:,1)==startid,:)=[];
pairs{frame}.match=cm;
segment_records=[frame startid x1 y1 score];

while ~isempty(next_id)
    
    frame=frame+1;
    if frame>total_frameno-1
        break;
    end
    cm=pairs{frame}.match;
    if isempty(cm)
        break;
    end
    x1=cm(cm(:,1)==next_id,3);
    y1=cm(cm(:,1)==next_id,4);
    score1=cm(cm(:,1)==next_id,end);
    fprintf('%5d %5d %5d %5d\n',frame,next_id,x1,y1);
    if ~isempty(x1) && ~isempty(y1)
       segment_records=[segment_records; [frame next_id x1 y1 score1]];
       temp=next_id;
        next_id=cm(cm(:,1)==next_id,2);
        cm(cm(:,1)==temp,:)=[];
        pairs{frame}.match=cm;
    else
        break
    end
end
    