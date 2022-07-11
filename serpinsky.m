function z = Serpinsky(Lmax)
x1=0; y1=0; x2=1; y2=0; x3=0.5; y3=sin(pi/3);
h=figure(1);
hold on
fill([x1 x2 x3],[y1 y2 y3],'k');
set(gca,'xtick',[],'ytick',[]);
set(gca,'Xcolor','w','Ycolor','w');
Simplex(x1,y1,x2,y2,x3,y3,0,Lmax);
hold off
function z=Simplex(x1,y1,x2,y2,x3,y3,n,Lmax)
if n<Lmax
	dx=(x2-x1)/2; dy=(y3-y1)/2; x1n=x1+dx; y1n=y1;
	x2n=x1+dx+dx/2;
	y2n=y1+dy;x3n=x1+dx/2; y3n=y1+dy;
	fill([x1n x2n x3n],[y1n y2n y3n],'w');
	n=n+1;
	Simplex(x1,y1,x1n,y1n,x3n,y3n,n,Lmax);
	Simplex(x1n,y1n,x2,y2,x2n,y2n,n,Lmax);
	Simplex(x3n,y3n,x2n,y2n,x3,y3,n,Lmax);
end