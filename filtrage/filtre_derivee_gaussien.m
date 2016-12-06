%function [hx,hy] = filtre_derivee_gaussien(std_dev)
% creation de filtres derivatifs Gaussiens
% std_dev : standard deviation sigma = sqrt(variance)
%

function varargout = filtre_derivee_gaussien(std_dev)
n1=8*std_dev+1;
n2=8*std_dev+1;
    std_dev = max(std_dev,0.05);

if ((abs(std_dev)<=0.05)&(abs(std_dev)<=0.05))
    dx=[-0.5,0,0.5];
    if nargout==1
        varargout={dx};
    else
        varargout={dx,dx'};
    end
else

    %generate a 2-D Gaussian kernel along x direction
    i = (1:n1) - (n1+1)/2;
    j = (1:n2) - (n2+1)/2;
    hd = -dgauss(i,std_dev);
    h = gauss(j,std_dev);
    h = h/sum(h);
    hd = hd/sum(abs(hd));
    hx = h'*hd;
    hy=hx';
   
  varargout={hx,hy};
end