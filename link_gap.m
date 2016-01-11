function [ratio, distance,records]=link_gap(filenamebase,check_seg_id,check_tracks_id,tracks,all_segments)
ratio=0;
distance=999999999;
records=[];
if ismember(check_seg_id, tracks{check_tracks_id}) && check_seg_id~=-1
    idx=find(tracks{check_tracks_id}==check_seg_id);
    idx=idx-1;
    if idx>=1
        seg_id=tracks{check_tracks_id}(idx);
        compared_frame_no=all_segments{check_seg_id}.segment_records(1,1);
        compared_x=all_segments{check_seg_id}.segment_records(1,3);
        compared_y=all_segments{check_seg_id}.segment_records(1,4);
        %opticFlow = opticalFlowFarneback;
        %reset(opticFlow)
        w=25;
        frameno=all_segments{seg_id}.segment_records(end,1);
        filename=sprintf(filenamebase,frameno);
        frameGray = imread(filename);
        startx=all_segments{seg_id}.segment_records(end,3);
        starty=all_segments{seg_id}.segment_records(end,4);
        patch_im=frameGray(starty-w:starty+w,startx-w:startx+w);
        %flow = estimateFlow(opticFlow,frameGray);
        frame1  = gpuArray(frameGray);
        %figure;
        records=[];
        while frameno<=compared_frame_no
            frameno=frameno+1;
            fprintf('.');
            filename=sprintf(filenamebase,frameno);
            frameGray = imread(filename);
            frame2  = gpuArray(frameGray);
            [Vx,Vy]=FarnebackOpticalFlow_GPU(frame1,frame2);
            Vx=gather(Vx);
            Vy=gather(Vy);
            
            Magnitude=sqrt(Vx.^2+Vy.^2);
            Orientation=atan2(Vy,Vx);
            % flow = estimateFlow(opticFlow,frameGray);
            Vx_patch=Vx(starty-w:starty+w,startx-w:startx+w);
            Vy_patch=Vy(starty-w:starty+w,startx-w:startx+w);
            theta_patch=Orientation(starty-w:starty+w,startx-w:startx+w);
            mag_patch=Magnitude(starty-w:starty+w,startx-w:startx+w);
            bw=mag_patch>1;
            %         bw2= mag_patch;
            %         bw2(:)=0;
            %         bw2(w+1-10:w+1+10,w+1-10:w+1+10)=1;
            %         bw2=~bw2;
            %         bw=bw2;
            sel_thetap=theta_patch(bw==1);
            sel_theta=sel_thetap(:);
            [c,cx]=hist(sel_theta,10);
            c=c/length(sel_theta);
            [c_max,c_idx]=max(c);
            rang=cx(end)-cx(end-1);
            max_p=cx(c_idx);
            left_upper=max_p-rang/2;
            right_upper=max_p+rang/2;
            sel_theta=sel_theta(sel_theta>= left_upper & sel_theta<=right_upper);
            main_theta=mean(sel_theta);
            
            
            if ~isnan(main_theta)
                lin=1:w-1;
                lin_x=w+1+round(lin.*cos(main_theta));
                lin_y=w+1+round(lin.*sin(main_theta));
                mag_sel=mag_patch(sub2ind(size(mag_patch),lin_y,lin_x));
                R=max(mag_sel);
                l=[0 R];
                lx=l.*cos(main_theta);
                ly=l.*sin(main_theta);
                lx=lx+startx;
                ly=ly+starty;
            end
            
            small_patch=frameGray(starty-2:starty+2,startx-2:startx+2);
            dist_temp=sqrt((startx-compared_x)^2+(starty-compared_y)^2);
            records=[records; [startx,starty,dist_temp,c_max,frameno]];
            
            if ~isnan(main_theta)
                startx=round(lx(2));
                starty=round(ly(2));
            end
            
            frame1=frame2;
        end
        fprintf('\n');
        if ~isempty(records)
            ratio=sum(records(:,4)>0.5)/size(records,1);
            %distance=sqrt((compared_x-startx)^2+(compared_y-starty)^2);
            %distance=min(records(:,3));
            distance=min(records(round(size(records,1)/2):end,3));
            records(records(:,end)>=compared_frame_no,:)=[];
        end
        
    end
    
end
