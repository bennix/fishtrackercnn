function I1 = imsmooth1(I,s)
if s==0
    I1 = I;
    return;
end
[~,~,K]=size(I);
if K > 1
    error('gray image');
end
ftransform = fft2(I);
[ysize xsize] = size(ftransform);
[x y] = meshgrid((0 : xsize-1)-(xsize-1)/2, (0 : ysize-1)-(ysize-1)/2);
ker = exp(-(x .^ 2 + y .^ 2) / s ^ 2 /2) / pi / s ^ 2 /2;
I1 = ifftshift(ifft2(fft2(ker) .* ftransform));
