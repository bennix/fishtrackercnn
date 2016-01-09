function [I1]=gauss3(t,O,W,c,d)
if nargin==3
    c=1;
    d=0;
end
[X, Y,Z] = meshgrid(1:W(1), 1:W(2),1:W(3));
I1 = c*exp( -1/2* (t(1,1).*(X-O(1)).^2 + 2 *t(1,2).*(X-O(1)) .*(Y-O(2)) + t(2,2) .*(Y-O(2)).^2 + 2 .*t(1,3) .*(X-O(1)).* (Z-O(3)) + 2 .*t(2,3).* (Y-O(2)).* (Z-O(3)) + t(3,3).* (Z-O(3)).^2)) +d;
end