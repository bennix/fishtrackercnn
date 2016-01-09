function I1=gauss21(t,O,W,c,d)
if nargin==3
    c=1;
    d=0;
end
[X, Y] = meshgrid(1:W(1), 1:W(2));
I1 = c*exp( -1/2* (t(1,1).*(X-O(1)).^2 + 2 *t(1,2).*(X-O(1)) .*(Y-O(2)) + t(2,2) .*(Y-O(2)).^2)) +d;
end