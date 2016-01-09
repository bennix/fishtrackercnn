function I1=gauss2(theta,a,b,winsz,x0,y0)
[X, Y] = meshgrid(-winsz:winsz, -winsz:winsz);
I1 = exp( -1/2* ( ((X-x0)*cos(theta) + (Y-y0)*sin(theta)).^2/a^2 + ((Y-y0)*cos(theta) - (X-x0)*sin(theta)).^2/b^2)) ;

end