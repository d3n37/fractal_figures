function z=Serpinsky2(Lmax)
x1=0; y1=0; x2=1; y2=0; x3=1; y3=1; x4=0; y4=1;
figure(1); 
hold on; 
fill([x1 x2 x3 x4],[y1 y2 y3 y4],'y');
set(gca,'xtick',[],'ytick',[]);
set(gca,'XColor','w','YColor','w');
Quadrate(x1,y1,x2,y2,x3,y3,x4,y4,0,Lmax);
hold off
function z=Quadrate(x1,y1,x2,y2,x3,y3,x4,y4,n,Lmax)
if n<Lmax
	dx=(x2-x1)/3; dy=(y3-y1)/3;
	x1n=x1+dx; y1n=y1+dy; x2n=x1+dx+dx; y2n=y1+dy;
	x3n=x1+dx+dx; y3n=y1+dy+dy; x4n=x1+dx; y4n=y1+dy+dy;
	fill([x1n x2n x3n x4n],[y1n y2n y3n y4n],'b');
	n=n+1;
	Quadrate(x1,y1,x1+dx,y1,x1+dx,y1+dy,x1,y1+dy,n,Lmax);
	Quadrate(x1+dx,y1,x1+2*dx,y1,x1+2*dx,y1+dy,x1+dx,y1+dy,n,Lmax);
	Quadrate(x1+2*dx,y1,x2,y1,x2,y1+dy,x1+2*dx,y1+dy,n,Lmax);
	Quadrate(x1+2*dx,y1+dy,x2,y1+dy,x2,y1+2*dy,x1+2*dx,y1+2*dy,n,Lmax);
	Quadrate(x1+2*dx,y1+2*dy,x2,y1+2*dy,x2,y3,x1+2*dx,y3,n,Lmax);
	Quadrate(x1+dx,y1+2*dy,x1+2*dx,y1+2*dy,x1+2*dx,y4,x1+dx,y4,n,Lmax);
	Quadrate(x1,y1+2*dy,x1+dx,y1+2*dy,x1+dx,y4,x1,y4,n,Lmax);
	Quadrate(x1,y1+dy,x1+dx,y1+dy,x1+dx,y1+2*dy,x1,y1+2*dy,n,Lmax);
end