function z=Mandel(n)
xx=-2.2:0.01:1.7;
yy=-1.5:0.01:1.5;
porog=2;
c=bsxfun(@plus,xx(:).',1i*yy(:));
M=n*ones(size(c));
ind=1:numel(c);
z = zeros(size(c));
for i = 0:n
    z(ind)=z(ind).^2+c(ind); %reccurent Mandelbrot's f-la 
    ind1=abs(z(ind))>porog;
    M(ind(ind1))=i;
    ind=ind(~ind1);
end
hold on;
imagesc(xx,yy,M)
axis equal