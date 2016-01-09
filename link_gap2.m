function  [next_seg_id]=link_gap2(pred,ID,seg)
ex=pred{seg}.endx;
ey=pred{seg}.endy;
eframe=pred{seg}.end_frame;
N=length(pred);
rec=[];
for i=1:N
   if ismember(ID, pred{i}.predict_id)
       dif_frame=pred{i}.start_frame-eframe;
       distance=sqrt((pred{i}.startx-ex)^2+(pred{i}.starty-ey)^2);
       seg_id=i;
       
       credit=pred{i}.credit(pred{i}.predict_id==ID);
       rec=[rec;[dif_frame distance seg_id credit]];
   end
end
rec(rec(:,1)<0,:)=[];
sp_rec=rec(rec(:,1)<100,:);
%sp_rec(sp_rec(:,end)<0.5,:)=[];
if ~isempty(sp_rec)
     
     [~,idx_dis]=min(sp_rec(:,2));
     [~,idx_frame]=min(sp_rec(:,1));
     if idx_dis==1 && idx_frame==idx_dis
         next_seg_id=sp_rec(1,3);
     else 
         next_seg_id=sp_rec(idx_dis,3);
     end
else
   if ~isempty(rec) 
       sp_rec=rec(rec(:,4)>0.6,:);
       if  ~isempty(sp_rec)
          next_seg_id=sp_rec(1,3);
       else
          next_seg_id=-1;
       end
   else
       next_seg_id=-1;
   end
end