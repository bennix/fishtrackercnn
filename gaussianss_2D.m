function SS = gaussianss_2D(I,min_scale,max_scale,S,sigma0,op)
scales=sigma0 * 2^(1/S) .^ (0:100);
flg = find(min_scale<=scales & scales<=max_scale);
flg = [flg(1)-2 flg(1)-1 flg flg(end)+1];
flg=flg(1<=flg);
scales=scales(flg);
SS.scales=scales;
ftransform = fft2(I);
[ysize xsize] = size(ftransform);
[x y] = meshgrid((0 : xsize-1)-(xsize-1)/2, (0 : ysize-1)-(ysize-1)/2);
for i=1:length(SS.scales)
    s = SS.scales(i);
    gker = exp(-(x .^ 2 + y .^ 2) / s ^ 2 /2) / pi / s ^ 2 /2;
    SS.L(:,:,i) = ifftshift(ifft2(fft2(gker) .* ftransform));
    ss=1;
    Lxx=subdxx(SS.L(:,:,i),ss);
    Lyy=subdyy(SS.L(:,:,i),ss);
    Lxy=subdxy(SS.L(:,:,i),ss);
    SS.Lxx(:,:,i) = Lxx;
    SS.Lyy(:,:,i) = Lyy;
    SS.Lxy(:,:,i) = Lxy;
    switch op
        case 'doh'
            SS.op(:,:,i)= (Lxx.*Lyy-Lxy.*Lxy)*s^4;
        case 'log'
            SS.op(:,:,i)= (Lxx + Lyy)*s^2;
    end
end
if strcmp(op,'dog')
    SS.op(:,:,1)= SS.scales(1)*(SS.L(:,:,2) - SS.L(:,:,1))/(SS.scales(2)-SS.scales(1));
    for i=2:length(SS.scales)-1
        SS.op(:,:,i)= SS.scales(i)*(SS.L(:,:,i+1) - SS.L(:,:,i-1))/(SS.scales(i+1)-SS.scales(i-1));
    end
    SS.op(:,:,length(SS.scales))= SS.scales(length(SS.scales))*(SS.L(:,:,length(SS.scales)) - SS.L(:,:,length(SS.scales)-1))/(SS.scales(length(SS.scales))-SS.scales(length(SS.scales)-1));
end