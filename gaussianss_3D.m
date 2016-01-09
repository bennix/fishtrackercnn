function SS = gaussianss_3D(I,min_scale,max_scale,S,sigma0,op)
scales=sigma0 * 2^(1/S) .^ (0:100);
flg = find(min_scale<=scales & scales<=max_scale);
flg = [flg(1)-2 flg(1)-1 flg flg(end)+1];
flg=flg(1<=flg);
scales=scales(flg);
SS.scales=scales;
ftransform = fftn(I);
[ysize xsize zsize] = size(ftransform);
[x y z] = meshgrid((0 : xsize-1)-(xsize-1)/2, (0 : ysize-1)-(ysize-1)/2,(0 : zsize-1)-(zsize-1)/2);
for i=1:length(SS.scales)
    s = SS.scales(i);
    gker=exp(-(x .^ 2 + y .^ 2 + z .^ 2) / s ^ 2 / 0.2e1) * sqrt(0.2e1) * pi ^ (-0.3e1 / 0.2e1) / s ^ 3 / 0.4e1;
    SS.L(:,:,:,i) = ifftshift(ifftn(fftn(gker) .* ftransform));
    ss=1;
    Lxx=subdxx3(SS.L(:,:,:,i),ss);
    Lyy=subdyy3(SS.L(:,:,:,i),ss);
    Lzz=subdzz3(SS.L(:,:,:,i),ss);
    Lxy=subdxy3(SS.L(:,:,:,i),ss);
    Lxz=subdxz3(SS.L(:,:,:,i),ss);
    Lyz=subdyz3(SS.L(:,:,:,i),ss);
    SS.Lxx(:,:,:,i) = Lxx;
    SS.Lyy(:,:,:,i) = Lyy;
    SS.Lzz(:,:,:,i) = Lzz;
    SS.Lxy(:,:,:,i) = Lxy;
    SS.Lxz(:,:,:,i) = Lxz;
    SS.Lyz(:,:,:,i) = Lyz;
    switch op
        case 'doh'
            SS.op(:,:,:,i)= (-Lxz.^2.*Lyy+2*Lxy.*Lxz.*Lyz-Lxx.*Lyz.^2-Lxy.^2.*Lzz+Lxx.*Lyy.*Lzz)*s^6;
        case 'log'
            SS.op(:,:,:,i)= (Lxx + Lyy + Lzz)*s^2;
    end
end
if strcmp(op,'dog')
    SS.op(:,:,:,1)= SS.scales(1)*(SS.L(:,:,:,2) - SS.L(:,:,:,1))/(SS.scales(2)-SS.scales(1));
    for i=2:length(SS.scales)-1
        SS.op(:,:,:,i)= SS.scales(i)*(SS.L(:,:,:,i+1) - SS.L(:,:,:,i-1))/(SS.scales(i+1)-SS.scales(i-1));
    end
    SS.op(:,:,:,length(SS.scales))= SS.scales(length(SS.scales))*(SS.L(:,:,:,length(SS.scales)) - SS.L(:,:,:,length(SS.scales)-1))/(SS.scales(length(SS.scales))-SS.scales(length(SS.scales)-1));
end