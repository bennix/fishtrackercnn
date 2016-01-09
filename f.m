function [dif]=f(x,y0)
p1=0.3212;
p2=-2.353;
p3=14.42;
y=p1*x^2+p2*x+p3;
dif=abs(y-y0);