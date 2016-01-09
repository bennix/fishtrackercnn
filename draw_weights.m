%function draw_weights(w)
w=net.layers{7}.filters;
M=size(w,3);
N=size(w,4);
W=size(w,1);
H=size(w,2);
pad=2;
map=zeros((W+pad)*M+pad,(H+pad)*N+pad);
for m=1:M
    for n=1:N
        p=w(:,:,m,n);
        map(m*pad+(m-1)*W+1:m*pad+m*W,n*pad+(n-1)*H+1:n*pad+n*H)=p;
    end
end

imagesc(map);