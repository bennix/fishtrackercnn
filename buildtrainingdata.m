load('config.mat','filenamebase','database','total_frame','total_fish');

load([database '\all_segments.mat'])
load([database '\tracks.mat']);

LT=length(tracks);
for lt=1:LT
    IDs=tracks{lt};
    fish_id=IDs(1);
    
    mkdir([database '\\train2']);
    mkdir([database '\\train2\\' num2str(fish_id)]);
    framefilename_base=[database '\\fish_info_%d.mat'];
    imgfile_base=filenamebase;
    segment_records=[];
    segment_images=[];
    for i=1:length(IDs)
        segment_records=[segment_records; all_segments{IDs(i)}.segment_records];
        segment_images=[segment_images all_segments{IDs(i)}.segment_pictures];
    end
    N=length(segment_images);
    
    W=50;
    for seq=1:N
        im=segment_images(seq).patch_head;
        frameno=segment_records(seq,1);
        idx=segment_records(seq,2);
        frame_name=sprintf(framefilename_base,frameno);
        load(frame_name);
        headx=fishinfo.headpoints(idx,1);
        heady=fishinfo.headpoints(idx,2);
        theta=fishinfo.headpoints(idx,3);
        imgfile=sprintf(imgfile_base,frameno);
        img=imread(imgfile);
        
        % Normal
        sel_x=headx;
        sel_y=heady;
        sel_theta=theta;
        patch_image=img(heady-W:heady+W,headx-W:headx+W);
        rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
        headimage=rot_image(51-30:51+30,51-30:51+30);
        filename=sprintf([database '\\train2\\%d\\A%05d.bmp'],[fish_id,frameno]);
        imwrite(headimage,filename);
        
        %Normal +1 degree
        sel_x=headx;
        sel_y=heady;
        sel_theta=theta+1;
        patch_image=img(heady-W:heady+W,headx-W:headx+W);
        rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
        headimage=rot_image(51-30:51+30,51-30:51+30);
        filename=sprintf([database '\\train2\\%d\\B%05d.bmp'],[fish_id,frameno]);
        imwrite(headimage,filename);
        
        %Normal -1 degree
        sel_x=headx;
        sel_y=heady;
        sel_theta=theta-1;
        patch_image=img(heady-W:heady+W,headx-W:headx+W);
        rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
        headimage=rot_image(51-30:51+30,51-30:51+30);
        filename=sprintf([database '\\train2\\%d\\C%05d.bmp'],[fish_id,frameno]);
        imwrite(headimage,filename);
        
        
        % Normal +1 dx
%         sel_x=headx+1;
%         sel_y=heady;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\D%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal +1 degree +1 dx
%         sel_x=headx+1;
%         sel_y=heady;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\E%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree +1dx
%         sel_x=headx+1;
%         sel_y=heady;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\F%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         
%         % Normal -1 dx
%         sel_x=headx-1;
%         sel_y=heady;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\G%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx-1;
%         sel_y=heady;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\H%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx-1;
%         sel_y=heady;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\I%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         % Normal -1 dx
%         sel_x=headx;
%         sel_y=heady+1;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\J%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx;
%         sel_y=heady+1;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\K%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx;
%         sel_y=heady+1;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\L%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         
%         % Normal -1 dx
%         sel_x=headx;
%         sel_y=heady-1;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\M%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx;
%         sel_y=heady-1;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\N%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx;
%         sel_y=heady-1;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\O%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         
%         % Normal -1 dx
%         sel_x=headx-1;
%         sel_y=heady-1;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\P%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx-1;
%         sel_y=heady-1;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\Q%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx-1;
%         sel_y=heady-1;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\R%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         
%         % Normal -1 dx
%         sel_x=headx-1;
%         sel_y=heady+1;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\S%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx-1;
%         sel_y=heady+1;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\T%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx-1;
%         sel_y=heady+1;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\U%05d.bmp'],[fish_id,frameno]);
%         
%         
%         % Normal -1 dx
%         sel_x=headx+1;
%         sel_y=heady-1;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\V%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx+1;
%         sel_y=heady-1;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\W%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx+1;
%         sel_y=heady-1;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\X%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         % Normal -1 dx
%         sel_x=headx+1;
%         sel_y=heady+1;
%         sel_theta=theta;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\Y%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1 dx
%         sel_x=headx+1;
%         sel_y=heady+1;
%         sel_theta=theta+1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\Z%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
%         
%         %Normal -1 degree -1dx
%         sel_x=headx+1;
%         sel_y=heady+1;
%         sel_theta=theta-1;
%         patch_image=img(heady-W:heady+W,headx-W:headx+W);
%         rot_image=imrotate(patch_image,sel_theta,'bilinear','crop');
%         headimage=rot_image(51-30:51+30,51-30:51+30);
%         filename=sprintf([base_path '\\data\\train2\\%d\\AA%05d.bmp'],[fish_id,frameno]);
%         imwrite(headimage,filename);
        
        
        
        %imwrite(headimage,filename);
        %     filename=sprintf('F:\\CoreView_258\\data\\train2\\%d\\F%05d.bmp',[fish_id,frameno]);
        fprintf('%05d\n',frameno);
        if frameno>(total_frame*0.3)
            break
        end
        %     imwrite(im,filename);
    end
end