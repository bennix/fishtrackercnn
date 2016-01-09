function [headpoints,headimages]=detect_fish_head2(filenamebase,frame)
filename=sprintf(filenamebase,frame);
im=imread(filename);
imd=im2double(im);

sigma0 = .6;
min_scale= 7;
max_scale      =  min(size(im))/256;
S      =  3 ;
operator = 'doh';
thres_intensity =120;
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
mark=~(DV>1 & DV<4);
cx(mark==1)=[];
cy(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];
DV(mark==1)=[];
mark=cx<250;

cx(mark==1)=[];
cy(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];
DV(mark==1)=[];


mark=cx>size(im,2)-300;

cx(mark==1)=[];
cy(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];
DV(mark==1)=[];

mark=cy<300;

cx(mark==1)=[];
cy(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];
DV(mark==1)=[];


mark=cy>size(im,1)-300;

cx(mark==1)=[];
cy(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];
DV(mark==1)=[];




N=length(cx);

for i=1:N
    lx=LXs(i,:);
    ly=LYs(i,:);
    lx=lx+cx(i);
    ly=ly+cy(i);
    %
    linep=improfile(im,lx,ly,60);
    pos=find(linep>thres_intensity);
    
    if  isempty(pos) || pos(1)>20
        LXs(i,2)=-LXs(i,2);
        LYs(i,2)=-LYs(i,2);
        lx=LXs(i,:);
        ly=LYs(i,:);
        lx=lx+cx(i);
        ly=ly+cy(i);
        %line(lx,ly,'Color','g');
    else
        
        %line(lx,ly,'Color','r');
    end
    
end

N=length(cx);
a=zeros(N,1);
b=zeros(N,1);
dif=zeros(N,1);

for i=1:N
    a(i)=scale_value(i)/sqrt(DV(i));
    b(i)=a(i)*DV(i);
    dif(i)=f(a(i),b(i));
     
    %text(cx(i),cy(i)+5,[num2str(a(i)) ' ' num2str(b(i)) ' '  num2str(dif(i))],'FontSize',12,'Color','r');
end
mark=dif>6;
cx(mark==1)=[];
cy(mark==1)=[];
scale_value(mark==1)=[];
LXs(mark==1,:)=[];
LYs(mark==1,:)=[];
DV(mark==1)=[];


N=length(cx);
thetas=zeros(N,1);
W=50;
mark=zeros(N,1);
for i=1:N
    sel_y=cy(i);
    sel_x=cx(i);
    patch_image=im(sel_y-W:sel_y+W,sel_x-W:sel_x+W);
    dx=diff(LXs(i,:));
    dy=diff(LYs(i,:));
    theta=atan2(dy,dx);
    
    theta_r=theta/pi*180+90;
    
    rot_image=imrotate(patch_image,theta_r,'bilinear','crop');

    linep=improfile(patch_image,51+LXs(i,:),51+LYs(i,:),60);


    [pos]=find(linep>70);
    if isempty(pos)
        LXs(i,2)=-LXs(i,2);
        LYs(i,2)=-LYs(i,2);
        
    elseif pos(1)>=10
        LXs(i,2)=-LXs(i,2);
        LYs(i,2)=-LYs(i,2);
    end
    dx=diff(LXs(i,:));
    dy=diff(LYs(i,:));
    theta=atan2(dy,dx);
    th=theta/pi*180;
    theta_base=th+90;

    
    rot_angles=theta_base-15:0.5:theta_base+15;
    xangles=rot_angles;
    count=1;
    for theta_r=theta_base-15:0.5:theta_base+15
        
        rot_image=imrotate(patch_image,theta_r,'bilinear','crop');
        headimage=rot_image(51-30:51+30,51-30:51+30);
        
        level = graythresh(headimage);
        bw_patch = im2bw(headimage,level);
        bw_patch=~bw_patch;
        
        %bw_patch=imfill(bw_patch,'holes');
        [Label,Num]=bwlabel(bw_patch);
        for l=1:Num
            bw=Label==l;
            if bw(31,31)==1
                [bw_y,bw_x]=find(bw==1);
                xangle=pcaangle_mex(bw_x,bw_y);
                xangles(count)=xangle;
            end
        end
        count=count+1;
    end
    [~,idx]=min(abs(xangles-90));
    theta_r=rot_angles(idx);
    rot_image=imrotate(patch_image,theta_r,'bilinear','crop');
    headimage=rot_image(51-30:51+30,51-30:51+30);
    
    level = graythresh(headimage);
    bw_patch = im2bw(headimage,level);
    bw_patch=~bw_patch;
    
    bw_patch=imfill(bw_patch,'holes');
    
    [Label,Num]=bwlabel(bw_patch);
    for l=1:Num
        bw=Label==l;
        if bw(31,31)==1
            [bw_y,bw_x]=find(bw==1);
            xangle=pcaangle_mex(bw_x,bw_y);
            xangles(count)=xangle;
            if all(bw(end,:)==0) && any(bw(1,:)==1) && abs(xangle-90)<1
                theta_r=rot_angles(idx)+180;
                rot_image=imrotate(patch_image,theta_r,'bilinear','crop');
                headimage=rot_image(51-30:51+30,51-30:51+30);
                
                level = graythresh(headimage);
                bw_patch = im2bw(headimage,level);
                bw_patch=~bw_patch;
                
            end
        end
    end
    thetas(i)=theta_r;
    headimages(i).patch_head=headimage;
    
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
           b_bottom_mid=all(b(end-3:end,31)==0);
           b_test = b_top | b_left | b_right | b_bottom_left | b_bottom_right | b_bottom_mid;
           if b_test==1
               mark(i)=1;
           end
       end
    end
    
    %xlabel(num2str(xangle));

end

cx(mark==1)=[];
cy(mark==1)=[];
thetas(mark==1)=[];
headpoints=[cx cy thetas];
headimages(mark==1)=[];





