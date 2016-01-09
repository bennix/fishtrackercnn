function I1 = imsmooth3(I,s)
if s==0
    I1 = I;
    return;
end
ftransform = fftn(I);
[ysize xsize zsize] = size(ftransform);
[x y z] = meshgrid((0 : xsize-1)-(xsize-1)/2, (0 : ysize-1)-(ysize-1)/2,(0 : zsize-1)-(zsize-1)/2);
gker=exp(-(x .^ 2 + y .^ 2 + z .^ 2) / s ^ 2 / 0.2e1) * sqrt(0.2e1) * pi ^ (-0.3e1 / 0.2e1) / s ^ 3 / 0.4e1;
I1 = ifftshift(ifftn(fftn(gker) .* ftransform));