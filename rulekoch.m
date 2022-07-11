function z=RuleKoch(Lmax,Axiom,Newf,n,tmp);
while n<=Lmax 
	if n==1
		tmp=Axiom; n=n+1; 
	else
		tmp=strrep(tmp,'F',Newf); 
		n=n+l; tmp=RuleKoch (Lmax,Axiom,Newf ,n, tmp); 
	end;
end; 
z=tmp;

function [X,Y]=Koch(Lmax)
Axiom='F++F++F';
Newf='F-F++F-F';
teta=pi/3;
alpha=0;
p=[0;0];
p=Coord(p,Lmax,Axiom,Newf,alpha,teta,p);
M=size(p,2);
X=p(1:1,1:M); 
Y=p(2:2,1:M); 
figure(1);
plot(X,Y,'1 Color','k'); 
set(gca,'xtick',[],'ytick',[]); 
set(gca,'XColor','w','YColor','w');

function z=Coord(p,Lmax,Axiom,Newf, alpha,teta)
Rule=RuleKoch(Lmax,Axiom,Newf,1,' '); 
M=length(Rule); 
for i=l:M
	Tmp=p(1:2, size(p,2):size(p,2)); 
	if Rule(i)=='F'
		R=[cos(alpha);sin(alpha)];
		R=R/(4^Lmax);
		Tmp=Tmp+R; 
		p=cat(2,p,Tmp); 
	end;
	if Rule(i)=='+' 
		alpha=alpha+teta; 
	end;
	if Rule(i)=='-' 
		alpha=alpha-teta; 
	end;
end; 
z=p;