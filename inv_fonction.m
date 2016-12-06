% function x=inv_fonction(y,xf,yf)
%
% on a une fonction yf=f(xf)
% on recherche le x correspondant au y donné

function x=inv_fonction(y,xf,yf)
[v,ind]=min(abs(yf-y));
x=mean(xf(ind));