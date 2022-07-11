function z=Maple(Niter,NPoints)
x1=0; y1=0;
x2=1; y2=0;
x3=1/2; y3=sin(pi/3);
x=zeros(NPoints,1);
y=zeros(NPoints,1);
j=1;
while j<=NPoints
    tmpx=rand(1,1);
    tmpy=sqrt(3)/2*rand(1,1);
    if (-sqrt(3)*tmpx+tmpy<=0) && (sqrt(3)*tmpx+tmpy-sqrt(3)<=0)
        x(j)=tmpx;
        y(j)=tmpy;
        j=j+1;
    end
end
for i=1:2^Niter
    Tmp(i)=system2(i-1,2);
end
n=1; 
s='0';
while n<Niter 
    s=strcat(s,'0'); 
    n=n+1; 
end
for i=1:2^Niter
    tmp=num2str(Tmp(i)); tmp1=s;
    for m=1:length(tmp)
        tmp1(Niter-m+1)=tmp(length(tmp)-m+1);
    end
    Cod(i,1:Niter)=tmp1;
end
A1=[0.4,-0.3733;0.0600,0.6000];
A2=[-0.8000,-0.1867;0.1371,0.8000];
a1=[0.3533;0.000];
a2=[1.1000;0.1000];
figure(1); hold on;
set(gca,'xtick',[],'ytick',[]);
set(gca,'XColor','w','YColor','w');
FractalDraw(Niter,NPoints,x,y,A1,A2,a1,a2,Cod);

function z=FractalDraw(Niter,NPoints,x,y,A1,A2,a1,a2,Cod)
for m=1:2^Niter
    X=x; Y=y;
    Rule=Cod(m,:);
    for i=1:Niter
        tmp=Rule(Niter+1-i);
        if tmp=='0' 
            [X Y]=T(NPoints,X,Y,A1,a1); 
        end
        if tmp=='1' 
            [X Y]=T(NPoints,X,Y,A2,a2); 
        end
    end
    plot(X,Y,'.','MarkerSize',1,'MarkerEdgeColor','g');
end

function [X,Y]=T(NPoints,x,y,A,a)
X=zeros(NPoints,1);
Y=zeros(NPoints,1);
for i=1:NPoints
    R=[x(i);y(i)];
    R=A*R+a;
    X(i)=R(1);
    Y(i)=R(2);
end

function z=system2(D,m)
n=1;
while D>=m^n
    n=n+1;
end
if n>1
    a=floor(D/m^(n-1))*10^(n-1);
    b=mod(D,m^(n-1));
    if b>=m
        b=system2(b,m);
    end
    z=a+b;
else
    z=D;
end