function [X,Y]=Levicurve(Lmax)
Axiom='F';
Newf='-F++F-';
teta=pi/4;
alpha=0;
p=[0;0];
p=Coord(p,Lmax,Axiom,Newf,alpha,teta);
M=size(p,2);
X=p(1:1,1:M);
Y=p(2:2,1:M);
figure(1);
plot(X,Y,'Color','r');

function z=Coord(p,Lmax,Axiom,Newf,alpha,teta)
Rule=levirule(Lmax,Axiom,Newf,1,' ');
M=length(Rule);
for i=1:M
    Tmp=p(1:2,size(p,2):size(p,2));
    if Rule(i)=='F'
        R=[cos(alpha);sin(alpha)]; R=R/(4^Lmax);
        Tmp=Tmp+R; p=cat(2,p,Tmp);
    end
    if Rule(i)=='+'
        alpha=alpha+teta;
    end
    if Rule(i)=='-'
        alpha=alpha-teta;
    end
end
z=p;
