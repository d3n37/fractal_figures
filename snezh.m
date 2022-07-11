function z=Crystal(N,K)
Af=4;
k=1;
for m=1:N
    for i=1:4^m 
        Tmp(k)=system3(i-1,Af); 
        k=k+1;
    end
    Q(1)=Af;
    for m=2:N 
        Q(m)=Q(m-1)+Af^m; 
    end
    n=1; 
    s='0'; 
    M=1;
    while n<=length(Tmp)
        m=1;
        while n>Q(m) m=m+1; end
        if m==1
            S(n,1:1)=s;
        else
            S(n,1:1)=s;
            S(i,1:m)=S(n,1:1);
        end
        n=n+1;
    end
    for i=1:k-1 
        tmp=num2str(Tmp(i)); 
        m=1;
        while i>Q(m)
            m=m+1;
        end
        tmp1(1:m)=S(i,1:m);
        for m=1:length(tmp)
            tmp1(length(tmp1)-m+1:length(tmp1)-m+1)=tmp(length(tmp)-m+1:length(tmp)-m+1);
        end
        Cod(i,1:length(tmp1))=tmp1;
    end
    x=0; 
    y=0;
    A1=[0.2550,0.0000;0.0000,0.2550];
    A2=[0.2550,0.0000;0.0000,0.2550];
    A3=[0.2550,0.0000;0.0000,0.2550];
    A4=[0.3700,-0.6420;0.6420,0.3700];
    a1=[0.3726;0.6714]; a2=[0.1146;0.2232];
    a3=[0.6306;0.2232]; a4=[0.6356;-0.0061];
    figure(1); hold on;
    set(gca,'xtick',[],'ytick',[]);
    set(gca,'XColor','w','YColor','w');
    DrawFractal(N,K,x,y,A1,A2,A3,A4,a1,a2,a3,a4,Cod);
end
    
function q=DrawFractal(Niter,NTrial,x,y,A1,A2,A3,A4,a1,a2,a3,a4,Cod)
X1=zeros(NTrial,1);
Y1=zeros(NTrial,1);
X=x; Y=y;
for m=1:NTrial
    Np=1+round((size(Cod,1)-1)*rand(1,1));
    Rule=Cod(Np,:);
    for i=1:length(Rule)
        tmp=Rule(length(Rule)+1-i);
        if tmp=='0' 
            [X Y]=T(X,Y,A1,a1); 
        end
        if tmp=='1' 
            [X Y]=T(X,Y,A2,a2); 
        end
        if tmp=='2' 
            [X Y]=T(X,Y,A3,a3); 
        end
        if tmp=='3' 
            [X Y]=T(X,Y,A4,a4); 
        end
    end
    X1(m)=X; Y1(m)=Y;
end
plot(X1,Y1,'.','MarkerSize',1,'MarkerEdgeColor','c');

function [X,Y]=T(x,y,A,a)
R=[x;y]; R=A*R+a;
X=R(1); Y=R(2);
function z=system3(D,m)
    n=1;
    while D>=m^n 
        n=n+1; 
    end
    if n>1
        a=floor(D/m^(n-1))*10^(n-1);
        b=mod(D,m^(n-1));
        if b>=m 
            b=system3(b,m); 
        end
        z=a+b;
        else
            z=D;
    end