function [X,Y]=Flower(Lmax)
Axiom='F[+F+F][-F-F][++F][--F]F';
Newf='FF[++F][+F][F][-F][--F]';
teta=pi/16;
alpha=pi/2;
p=[0;0];
Coord(p,Lmax,Axiom,Newf,alpha,teta);

function z=Coord(p,Lmax,Axiom,Newf,alpha,teta)
Rule=FlowerString(Lmax,Axiom,Newf,1,'');
figure(1); 
hold on;
M=length(Rule);
L=0;
x0=p(1);
y0=p(2);
for i=1:M
    if Rule(i)=='F'
        x1=x0+cos(alpha); 
        y1=y0+sin(alpha);
        X=[x0,x1]; 
        Y=[y0,y1]; 
        x0=x1; 
        y0=y1;
        plot(X,Y,'Color','k'); 
    end
    if Rule(i)=='+'
        alpha=alpha+teta;
    end
    if Rule(i)=='-'
        alpha=alpha-teta;
    end
    if Rule(i)=='['
        if L==0 
            St=[x0;y0;alpha]; 
            L=1; 
        else
            St=cat(2,St,[x0;y0;alpha]);
        end
    end
    if Rule(i)==']'
        M=size(St,2); 
        R=St(1:3,M:M);
        x0=R(1); 
        y0=R(2);
        alpha=R(3); 
        St=St(1:3,1:M-1);
    end
end
hold off

function z=FlowerString(Lmax,Axiom,Newf,n,tmp)
while n<=Lmax
    if n==1
        tmp=Axiom; n=n+1; else
        tmp=strrep(tmp,'F',Newf);
        n=n+1; 
        tmp=FlowerString(Lmax,Axiom,Newf,n,tmp);
    end
end
z=tmp;