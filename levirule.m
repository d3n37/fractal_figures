function z=levirule(Lmax,Axiom,Newf,n,tmp)
while n<=Lmax 
	if n==1
		tmp=Axiom; 
        n=n+1; 
	else
		tmp=strrep(tmp,'F',Newf);
        n=n+1;
        tmp=levirule(Lmax,Axiom,Newf,n,tmp); 
	end;
end; 
z=tmp;