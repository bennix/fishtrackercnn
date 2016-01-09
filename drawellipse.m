function drawellipse(Mi,x0,y0,col)
if ~exist('col','var')
    col='-g';
end
hold on;
[v e]=eig(Mi);
l1=1/sqrt(e(1));
l2=1/sqrt(e(4));
alpha=atan2(v(4),v(3));
s=1;
t = 0:pi/50:2*pi;
y=s*(l2*sin(t));
x=s*(l1*cos(t));
xbar=y*cos(alpha) - x*sin(alpha);
ybar=x*cos(alpha) + y*sin(alpha);
plot(xbar+x0,ybar+y0,col);
end
