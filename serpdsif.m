function z=SerpDSIF(Niter,NPoints)
x=zeros(NPoints,1); 
y=zeros(NPoints,1);
x1=0; y1=0; 
x2=1; y2=0; 
x3=1/2; y3=sin(pi/3);
j=1;
while j<=NPoints
    tmpx=rand(1,1);
    tmpy=sqrt(3)/2*rand(1,1);
    if (-sqrt(3)*tmpx+tmpy<=0) & (sqrt(3)*tmpx+tmpy-sqrt(3)<=0)
        x(j)=tmpx; 
        y(j)=tmpy;
        j=j+1; 
    end;
end
for i=1:3^Niter
    Tmp(i)=system3(i-1);
end
n=1; s='0';
while n<Niter
    s=strcat(s,'0'); n=n+1;
end
for i=1:3^Niter
    tmp=num2str(Tmp(i)); 
    tmp1=s;
    for m=1:length(tmp)
        tmp1(Niter-m+1)=tmp(length(tmp)-m+1);
    end
    Cod(i,1:Niter)=tmp1;
end
a1=[0;0]; 
a2=[1/2;0]; 
a3=[1/4;sqrt(3)/4]; 
A=[1/2,0;0,1/2];
figure(1); 
hold on; 
set(gca,'xtick',[],'ytick',[]);
set(gca,'XColor','w','Ycolor','w'); 
fill([x1 x2 x3],[y1 y2 y3],'w');
GosperDraw(Niter,NPoints,x,y,A,a1,a2,a3,Cod);

function z=GosperDraw(Niter,NPoints,x,y,A,a1,a2,a3,Cod)
for m=1:3^Niter
    X=x; 
    Y=y; 
    Rule=Cod(m,:);
    for i=1:Niter
        tmp=Rule(Niter+1-i);
        if tmp=='0'
            [X Y]=T(NPoints,X,Y,A,a1);
        end
        if tmp=='1'
            [X Y]=T(NPoints,X,Y,A,a2);
        end
        if tmp=='2'
            [X Y]=T(NPoints,X,Y,A,a3);
        end
    end
    plot(X,Y,'.','MarkerSize',1,'MarkerEdgeColor','b');
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
    function z=system3(D);
    n=1;
    while D>=3^n 
        n=n+1; 
    end
    if n>1
        a=floor(D/3^(n-1))*10^(n-1); 
        b=mod(D,3^(n-1));
        if b>=3
            b=system3(b);
        end
        z=a+b;
    else
        z=D;
end