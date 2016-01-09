function [headpoints,headimages]=detect_fish_head(filenamebase,frame)
filename=sprintf(filenamebase,frame);
im=imread(filename);
imd=im2double(im);

sigma0 = .6;
min_scale= 7;
max_scale      =  min(size(im))/256;
S      =  3 ;
operator = 'doh';
thres_intensity =150;
gss = gaussianss_2D(imd,min_scale,max_scale,S,sigma0,operator);
[t,idx]=max(gss.op,[],3);
idx_m=idx;
p=FastPeakFind(t);
cx=p(1:2:end);
cy=p(2:2:end);

pixels_value=im(sub2ind(size(im),cy,cx));
cx=cx(pixels_value<thres_intensity);
cy=cy(pixels_value<thres_intensity);

N=length(cx);
mark=zeros(N,1);
pixels_value=zeros(N,1);
for i=1:N
    ty=cy(i);
    tx=cx(i);
    w=10;
    if ((ty>(1+w)) && (ty<(size(im,1)-w)) && (tx>(1+w)) && (tx<(size(im,2)-w)))
        patch=im(ty-w:ty+w,tx-w:tx+w);
        pixels_value(i)=mean2(patch);
    else
        mark(i)=1;
    end
end
cx=cx(pixels_value<thres_intensity & mark==0);
cy=cy(pixels_value<thres_intensity & mark==0);

idx_value=idx_m(sub2ind(size(im),cy,cx));
N=length(idx_value);
mark=zeros(N,1);
DV=zeros(N,1);


LXs=zeros(N,2);
LYs=zeros(N,2);
for i=1:N
    idx=idx_value(i);
    Hxx=gss.Lxx(cy(i),cx(i),idx);
    Hxy=gss.Lxy(cy(i),cx(i),idx);
    Hyy=gss.Lyy(cy(i),cx(i),idx);
    hess = [Hxx Hxy;Hxy Hyy];
    [V,D]=eig(hess);
    D=diag(D);
    [D_sort,idxs]=sort(D);
    D_ratio=D(2)/D(1);
    DV(i)=D_ratio;
    
    if D_ratio>4
        mark(i)=1;
    end
    % text(cx(i),cy(i)+5,[num2str(scale_value(i)) ' ' num2str(DV(i))],'Color','r','FontSize',14);
    V_sel=V(idxs(1),:)*100;
    LX=[cx(i) cx(i)+V_sel(1)];
    LY=[cy(i) cy(i)+V_sel(2)];
    LXs(i,:)=[ 0 V_sel(1)];
    LYs(i,:)=[ 0 V_sel(2)];
    
    %line(LX,LY,'Color','r');
end

cx(mark==1)=[];
cy(mark==1)=[];
DV(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];


idx_value=idx_m(sub2ind(size(idx_m),cy,cx));
scale_value=gss.scales(idx_value);

mark=~(scale_value>7 & scale_value<14);
cx(mark==1)=[];
cy(mark==1)=[];
DV(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];

mark=~(DV>1.1 & DV<3.2);
cx(mark==1)=[];
cy(mark==1)=[];
DV(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];

regions = detectMSERFeatures(im,'RegionAreaRange',[200 14000],'ThresholdDelta' ,1);


N=length(regions);
v=zeros(N,1);
for i=1:N
    t=regions(i).PixelList;
    x=t(:,1);
    y=t(:,2);
    v(i)=mean(im(sub2ind(size(im),y,x)));
end
mark=v>thres_intensity*1.1;
regions(mark==1)=[];

N=length(regions);
bw=im;
bw(:)=0;
for i=1:N
    %idx=blobs(i);
    x=regions(i).PixelList;
    x1=x(:,1);
    y1=x(:,2);
    
    bw(sub2ind(size(bw),y1,x1))=1;
end
se=strel('disk',4);
bw=imdilate(bw,se);
bw=imerode(bw,se);

N=length(cx);
mark=zeros(N,1);
for i=1:N
    if bw(cy(i),cx(i))==0
        mark(i)=1;
    end
end
cx(mark==1)=[];
cy(mark==1)=[];
DV(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];

N=length(cx);

for i=1:N
    lx=LXs(i,:);
    ly=LYs(i,:);
    lx=lx+cx(i);
    ly=ly+cy(i);
    %line(lx,ly,'Color','r');
    linep=improfile(im,lx,ly,60);
    pos=find(linep>thres_intensity);
    
    if  isempty(pos) || pos(1)>20
        LXs(i,2)=-LXs(i,2);
        LYs(i,2)=-LYs(i,2);
    end
    
    
end

xy=[cx cy];

LXs(xy(:,1)<240,:)=[];
LYs(xy(:,1)<240,:)=[];
xy(xy(:,1)<240,:)=[];


LXs(xy(:,2)<240,:)=[];
LYs(xy(:,2)<240,:)=[];
xy(xy(:,2)<240,:)=[];


LXs(xy(:,2)>size(im,1)-240,:)=[];
LYs(xy(:,2)>size(im,1)-240,:)=[];
xy(xy(:,2)>size(im,1)-240,:)=[];


LXs(xy(:,1)>size(im,2)-240,:)=[];
LYs(xy(:,1)>size(im,2)-240,:)=[];
xy(xy(:,1)>size(im,2)-240,:)=[];

cx=xy(:,1);
cy=xy(:,2);

N=length(cx);
angles=zeros(N,1);
for i=1:N
    %text(cx(i),cy(i)+5,num2str(i),'Color','r','FontSize',15);
    lx=LXs(i,:);
    ly=LYs(i,:);
    theta_rad=atan2(ly(2),lx(2));
    theta=theta_rad/pi*180;
    lx=lx+cx(i);
    ly=ly+cy(i);
    angles(i)=theta;
    
end


M=length(cx);
thetas=zeros(M,1);
marks=zeros(M,1);

for id=1:M
    
    sel_x=cx(id);
    sel_y=cy(id);
    sel_angle=angles(id)+90;
    W=100;
    patch_im=im(sel_y-W:sel_y+W,sel_x-W:sel_x+W);
    
    regions = detectMSERFeatures(patch_im,'RegionAreaRange',[200 14000],'ThresholdDelta' ,1);
    N=length(regions);
    v=zeros(N,1);
    for i=1:N
        t=regions(i).PixelList;
        x=t(:,1);
        y=t(:,2);
        pix=patch_im(sub2ind(size(patch_im),y,x));
        pix=sort(pix);
        pix=pix(1:round(length(pix)));
        v(i)=max(pix);
    end
    if length(v)>1
        regions(v>thres_intensity)=[];
        
        bw_patch=patch_im;
        bw_patch(:)=0;
        N=length(regions);
        for i=1:N
            t=regions(i).PixelList;
            x=t(:,1);
            y=t(:,2);
            bw_patch(sub2ind(size(bw_patch),y,x))=1;
        end
        [Label,Num]=bwlabel(bw_patch);
        for i=1:Num
            b_temp=Label==i;
            if b_temp(W+1,W+1)==1
                bw_patch=b_temp;
                break;
            end
        end
        [bw_y,bw_x]=find(bw_patch==1);
        bw_y=bw_y-(W+1);
        bw_x=bw_x-(W+1);
        dist_v=sqrt(bw_y.^2+bw_x.^2);
        bw_x=bw_x(dist_v<40);
        bw_y=bw_y(dist_v<40);
        bw_y=bw_y+(W+1);
        bw_x=bw_x+(W+1);
        bw_patch(:)=0;
        bw_patch(sub2ind(size(bw_patch),bw_y,bw_x))=1;
        [Label,Num]=bwlabel(bw_patch);
        for i=1:Num
            b_temp=Label==i;
            if b_temp(W+1,W+1)==1
                bw_patch=b_temp;
                break;
            end
        end
        [bw_y,bw_x]=find(bw_patch==1);
        if ~(isempty(bw_y) && isempty(bw_x))
            bw_y=bw_y-(W+1);
            bw_x=bw_x-(W+1);
            
            rot_angle_rad=-sel_angle/180*pi;
            x_rot=bw_x.*cos(rot_angle_rad)-bw_y.*sin(rot_angle_rad);
            y_rot=bw_x.*sin(rot_angle_rad)+bw_y.*cos(rot_angle_rad);
            xangle=pcaangle_mex(x_rot,y_rot);
            
            v=[];
            px=1;
            for delta=-100:0.1:100
                temp_angle=sel_angle+delta;
                rot_angle_rad=-temp_angle/180*pi;
                x_rot=bw_x.*cos(rot_angle_rad)-bw_y.*sin(rot_angle_rad);
                y_rot=bw_x.*sin(rot_angle_rad)+bw_y.*cos(rot_angle_rad);
                xangle=pcaangle_mex(x_rot,y_rot);
                v(px,1)=temp_angle;
                v(px,2)=xangle;
                px=px+1;
            end
            
            [~,idx]=min(abs(v(:,2)-90));
            idx=idx(1);
            rot_angle=v(idx,1);
            rot_angle_rad=-rot_angle/180*pi;
            
            x_rot=bw_x.*cos(rot_angle_rad)-bw_y.*sin(rot_angle_rad);
            y_rot=bw_x.*sin(rot_angle_rad)+bw_y.*cos(rot_angle_rad);
            xangle=pcaangle_mex(x_rot,y_rot);
            x_rot=x_rot+(W+1);
            y_rot=y_rot+(W+1);
            x_rot=round(x_rot);
            y_rot=round(y_rot);
            xy=[x_rot y_rot];
            xy(xy(:,1)<1,:)=[];
            xy(xy(:,2)<1,:)=[];
            xy(xy(:,1)>size(patch_im,2),:)=[];
            xy(xy(:,2)>size(patch_im,1),:)=[];
            x_rot=xy(:,1);
            y_rot=xy(:,2);
            patch_bw=patch_im;
            patch_bw(:)=0;
            patch_bw(sub2ind(size(patch_bw),y_rot,x_rot))=1;
            patch_bw=imfill(patch_bw,'holes');
            
            patch_im_rot=imrotate(patch_im,rot_angle,'bilinear','crop');
            
            
            C=30;
            patch_head=patch_im_rot(W+1-C:W+1+C,W+1-C:W+1+C);
            patch_head_bw=patch_bw(W+1-C:W+1+C,W+1-C:W+1+C);
            mark=0;
            if any(patch_head_bw(:,1)==1) || any(patch_head_bw(:,end)==1)
                mark=1;
            elseif any(patch_head_bw(1,:)==1) && any(patch_head_bw(end,:)==1)
                mark=1;
            end
            marks(id)=mark;
            if all(patch_head_bw(end,:)==0) && any(patch_head_bw(1,:)==1)
                rot_angle=rot_angle+180;
                rot_angle_rad=-rot_angle/180*pi;
                
                x_rot=bw_x.*cos(rot_angle_rad)-bw_y.*sin(rot_angle_rad);
                y_rot=bw_x.*sin(rot_angle_rad)+bw_y.*cos(rot_angle_rad);
                xangle=pcaangle_mex(x_rot,y_rot);
                x_rot=x_rot+(W+1);
                y_rot=y_rot+(W+1);
                x_rot=round(x_rot);
                y_rot=round(y_rot);
                xy=[x_rot y_rot];
                xy(xy(:,1)<1,:)=[];
                xy(xy(:,2)<1,:)=[];
                xy(xy(:,1)>size(patch_im,2),:)=[];
                xy(xy(:,2)>size(patch_im,1),:)=[];
                x_rot=xy(:,1);
                y_rot=xy(:,2);
                patch_bw=patch_im;
                patch_bw(:)=0;
                patch_bw(sub2ind(size(patch_bw),y_rot,x_rot))=1;
                patch_bw=imfill(patch_bw,'holes');
                patch_im_rot=imrotate(patch_im,rot_angle,'bilinear','crop');
                patch_head=patch_im_rot(W+1-C:W+1+C,W+1-C:W+1+C);
                patch_head_bw=patch_bw(W+1-C:W+1+C,W+1-C:W+1+C);
            end
            
            thetas(id)=rot_angle;
            headimages(id).patch_head=patch_head;
            headimages(id).patch_head_bw=patch_head_bw;
            
        else
            marks(id)=1;
            headimages(id).patch_head=[];
            headimages(id).patch_head_bw=[];
        end
    else
        marks(id)=1;
        headimages(id).patch_head=[];
        headimages(id).patch_head_bw=[];
    end
end
headimages(marks==1)=[];
cx(marks==1)=[];
cy(marks==1)=[];
thetas(marks==1)=[];
figure;

imshow(im,[]);
hold on;
plot(cx,cy,'r+');

N=length(cx);
for id=1:N
    
    img=headimages(id).patch_head;
    %     regions = detectMSERFeatures(img,'RegionAreaRange',[20 14000],'ThresholdDelta' ,1);
    %     N=length(regions);
    %     v=zeros(N,1);
    %     for i=1:N
    %         t=regions(i).PixelList;
    %         x=t(:,1);
    %         y=t(:,2);
    %         pix=img(sub2ind(size(img),y,x));
    %         pix=sort(pix);
    %         pix=pix(1:round(length(pix)));
    %         v(i)=max(pix);
    %     end
    %
    %     regions(v>135)=[];
    level = graythresh(img);
    bw_patch = im2bw(img,level);
    bw_patch=~bw_patch;
    %     bw_patch=img;
    %     bw_patch(:)=0;
    %     N=length(regions);
    %     for i=1:N
    %         t=regions(i).PixelList;
    %         x=t(:,1);
    %         y=t(:,2);
    %         bw_patch(sub2ind(size(bw_patch),y,x))=1;
    %     end
    bw_patch=imfill(bw_patch,'holes');
    [Label,Num]=bwlabel(bw_patch);
    for i=1:Num
        b_temp=Label==i;
        if b_temp(C+1,C+1)==1
            bw_patch=b_temp;
            break;
        end
    end
    bw_patch=imfill(bw_patch,'holes');
    
    [bw_y,bw_x]=find(bw_patch==1);
    xangle=pcaangle_mex(bw_x,bw_y);
    %xlabel(num2str(xangle));
    diff_angle=abs(90-xangle);
    flag=1;
    if xangle<90
        rot_angle=thetas(id)-flag*diff_angle;
    else
        rot_angle=thetas(id)+flag*diff_angle;
    end
    rot_angle2=rot_angle-thetas(id);
    rot_angle_rad=-rot_angle2/180*pi;
    bw_y1=bw_y-(C+1);
    bw_x1=bw_x-(C+1);
    
    x_rot=bw_x1.*cos(rot_angle_rad)-bw_y1.*sin(rot_angle_rad);
    y_rot=bw_x1.*sin(rot_angle_rad)+bw_y1.*cos(rot_angle_rad);
    xangle=pcaangle_mex(x_rot,y_rot);
    
    
    x_rot=x_rot+(C+1);
    y_rot=y_rot+(C+1);
    x_rot=round(x_rot);
    y_rot=round(y_rot);
    xy=[x_rot y_rot];
    xy(xy(:,1)<1,:)=[];
    xy(xy(:,2)<1,:)=[];
    xy(xy(:,1)>size(bw_patch,2),:)=[];
    xy(xy(:,2)>size(bw_patch,1),:)=[];
    x_rot=xy(:,1);
    y_rot=xy(:,2);
    patch_bw=bw_patch;
    patch_bw(:)=0;
    patch_bw(sub2ind(size(patch_bw),y_rot,x_rot))=1;
    patch_bw=imfill(patch_bw,'holes');
    
    diff_xangle=abs(xangle-90);
    if diff_angle<diff_xangle
        flag=-1;
        if xangle<90
            rot_angle=thetas(id)-flag*diff_angle;
        else
            rot_angle=thetas(id)+flag*diff_angle;
        end
        rot_angle2=rot_angle-thetas(id);
        rot_angle_rad=-rot_angle2/180*pi;
        bw_y2=bw_y-(C+1);
        bw_x2=bw_x-(C+1);
        
        x_rot=bw_x2.*cos(rot_angle_rad)-bw_y2.*sin(rot_angle_rad);
        y_rot=bw_x2.*sin(rot_angle_rad)+bw_y2.*cos(rot_angle_rad);
        xangle=pcaangle_mex(x_rot,y_rot);
        
        
        x_rot=x_rot+(C+1);
        y_rot=y_rot+(C+1);
        x_rot=round(x_rot);
        y_rot=round(y_rot);
        xy=[x_rot y_rot];
        xy(xy(:,1)<1,:)=[];
        xy(xy(:,2)<1,:)=[];
        xy(xy(:,1)>size(bw_patch,2),:)=[];
        xy(xy(:,2)>size(bw_patch,1),:)=[];
        x_rot=xy(:,1);
        y_rot=xy(:,2);
        patch_bw=bw_patch;
        patch_bw(:)=0;
        patch_bw(sub2ind(size(patch_bw),y_rot,x_rot))=1;
        patch_bw=imfill(patch_bw,'holes');
        
        diff_xangle=abs(xangle-90);
    end
    
    sel_x=cx(id);
    sel_y=cy(id);
    patch_im=im(sel_y-W:sel_y+W,sel_x-W:sel_x+W);
    patch_im_rot=imrotate(patch_im,rot_angle,'bilinear','crop');
    
    patch_head=patch_im_rot(W+1-C:W+1+C,W+1-C:W+1+C);
    
    
    
    thetas(id)=rot_angle;
    headimages(id).patch_head=patch_head;
    headimages(id).patch_head_bw=patch_bw;
end


headpoints=[cx cy thetas];
N=length(cx);
for id=1:N
    %id=7;
    img=headimages(id).patch_head;
    %     regions = detectMSERFeatures(img,'RegionAreaRange',[20 14000],'ThresholdDelta' ,1);
    %     N=length(regions);
    %     v=zeros(N,1);
    %     for i=1:N
    %         t=regions(i).PixelList;
    %         x=t(:,1);
    %         y=t(:,2);
    %         pix=img(sub2ind(size(img),y,x));
    %         pix=sort(pix);
    %         pix=pix(1:round(length(pix)));
    %         v(i)=max(pix);
    %     end
    %
    %     regions(v>125)=[];
    level = graythresh(img);
    bw_patch = im2bw(img,level);
    bw_patch=~bw_patch;
    %     bw_patch=img;
    %     bw_patch(:)=0;
    %    N=length(regions);
    %     for i=1:N
    %         t=regions(i).PixelList;
    %         x=t(:,1);
    %         y=t(:,2);
    %         bw_patch(sub2ind(size(bw_patch),y,x))=1;
    %     end
    bw_patch=imfill(bw_patch,'holes');
    [Label,Num]=bwlabel(bw_patch);
    for i=1:Num
        b_temp=Label==i;
        if b_temp(C+1,C+1)==1
            bw_patch=b_temp;
            break;
        end
    end
    bw_patch=imfill(bw_patch,'holes');
    % subplot(2,2,3),imshow(bw_patch,[])
    [bw_y,bw_x]=find(bw_patch==1);
    xangle=pcaangle_mex(bw_x,bw_y);
    %xlabel(num2str(xangle));
    diff_angle=abs(90-xangle);
    flag=1;
    if xangle<90
        rot_angle=thetas(id)-flag*diff_angle;
    else
        rot_angle=thetas(id)+flag*diff_angle;
    end
    rot_angle2=rot_angle-thetas(id);
    rot_angle_rad=-rot_angle2/180*pi;
    bw_y1=bw_y-(C+1);
    bw_x1=bw_x-(C+1);
    
    x_rot=bw_x1.*cos(rot_angle_rad)-bw_y1.*sin(rot_angle_rad);
    y_rot=bw_x1.*sin(rot_angle_rad)+bw_y1.*cos(rot_angle_rad);
    xangle=pcaangle_mex(x_rot,y_rot);
    
    
    x_rot=x_rot+(C+1);
    y_rot=y_rot+(C+1);
    x_rot=round(x_rot);
    y_rot=round(y_rot);
    xy=[x_rot y_rot];
    xy(xy(:,1)<1,:)=[];
    xy(xy(:,2)<1,:)=[];
    xy(xy(:,1)>size(bw_patch,2),:)=[];
    xy(xy(:,2)>size(bw_patch,1),:)=[];
    x_rot=xy(:,1);
    y_rot=xy(:,2);
    patch_bw=bw_patch;
    patch_bw(:)=0;
    patch_bw(sub2ind(size(patch_bw),y_rot,x_rot))=1;
    patch_bw=imfill(patch_bw,'holes');
    
    diff_xangle=abs(xangle-90);
    if diff_angle<diff_xangle
        flag=-1;
        if xangle<90
            rot_angle=thetas(id)-flag*diff_angle;
        else
            rot_angle=thetas(id)+flag*diff_angle;
        end
        rot_angle2=rot_angle-thetas(id);
        rot_angle_rad=-rot_angle2/180*pi;
        bw_y2=bw_y-(C+1);
        bw_x2=bw_x-(C+1);
        
        x_rot=bw_x2.*cos(rot_angle_rad)-bw_y2.*sin(rot_angle_rad);
        y_rot=bw_x2.*sin(rot_angle_rad)+bw_y2.*cos(rot_angle_rad);
        xangle=pcaangle_mex(x_rot,y_rot);
        
        
        x_rot=x_rot+(C+1);
        y_rot=y_rot+(C+1);
        x_rot=round(x_rot);
        y_rot=round(y_rot);
        xy=[x_rot y_rot];
        xy(xy(:,1)<1,:)=[];
        xy(xy(:,2)<1,:)=[];
        xy(xy(:,1)>size(bw_patch,2),:)=[];
        xy(xy(:,2)>size(bw_patch,1),:)=[];
        x_rot=xy(:,1);
        y_rot=xy(:,2);
        patch_bw=bw_patch;
        patch_bw(:)=0;
        patch_bw(sub2ind(size(patch_bw),y_rot,x_rot))=1;
        patch_bw=imfill(patch_bw,'holes');
        
        diff_xangle=abs(xangle-90);
    end
    
    sel_x=cx(id);
    sel_y=cy(id);
    patch_im=im(sel_y-W:sel_y+W,sel_x-W:sel_x+W);
    patch_im_rot=imrotate(patch_im,rot_angle,'bilinear','crop');
    
    patch_head=patch_im_rot(W+1-C:W+1+C,W+1-C:W+1+C);
    
    
    
    thetas(id)=rot_angle;
    headimages(id).patch_head=patch_head;
    headimages(id).patch_head_bw=patch_bw;
end

N=length(headimages);
mark=zeros(N,1);

for i=1:N
   
    patch=headimages(i).patch_head;
    level = graythresh(patch);
    BW = im2bw(patch,level);
    BW =~BW;
    [L,M]=bwlabel(BW);
    for p=1:M
       b=L==p;
       if b(31,31)==1
           b_top=any(b(1,:)==1);
           b_left=any(b(:,1)==1);
           b_right=any(b(:,end)==1);
           b_bottom_left=any(b(end,1:12)==1);
           b_bottom_right=any(b(end,end-11:end)==1);
           b_test = b_top | b_left | b_right | b_bottom_left | b_bottom_right;
           if b_test==1
               mark(i)=1;
           end
       end
    end
    
    
    %xlabel([num2str(b) ':' num2str(angle)]);
end
headimages(mark==1)=[];
headpoints(mark==1,:)=[];