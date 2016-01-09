function angle = pcaangle(x, y)
%PCAANGLE - Estimate main axis angle of a point cloud
%  
%   ANGLE = PCAANGLE(X, Y) estimates the angle of the main axis of
%   variation from the points (X,Y). If (X,Y) defines an oval point
%   cloud, the major axis of the ellipse is found.
%
%   ANGLE = PCAANGLE(..., 'visualize') plots the points and the direction
%   of the main axis.
%
%   PCAANGLE with no arguments starts a demo of the function.
%
%   If pcaangle is called with no arguments, the function enters
%   demonstration mode. 

%% AUTHOR    : Jøger Hansegård 
%% $DATE     : 06-Dec-2004 10:13:10 $ 
%% DEVELOPED : 7.0.1.24704 (R14) Service Pack 1 
%% FILENAME  : pcaangle.m 


%Remove the mean from the data
x= double(x);
y= double(y);
% x = x(:)-cx;
% y = y(:)-cy;
 x = x(:)-mean(x(:));
 y = y(:)-mean(y(:));

%Apply PCA to retreive major axis
c = cov(x, y);
[a, ev] = eig(c);
[ev,ind] = sort(diag(ev));

%Extract the angle of the major axis
[xa, ya] = deal(a(1,ind(end)), a(2,ind(end)));
angle = cart2pol(xa, ya)/pi*180;