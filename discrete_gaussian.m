%function gaussian = discrete_gaussian(t,size)
% return a gaussian function
% t : variance
% size : size of support
%note pour LES: si delta est la taille du filtre LES, 
%alors t ici doit avoir pour valeur t = (1/12)*sqrt(delta)
function varargout = discrete_gaussian(t,size)

    if nargin <= 1
        size = 10*max(1,floor(sqrt(t))) + 1;
    end
    demiTaille = floor(size/2);
    
    %on affecte sa valeur au pixel central
    g(demiTaille+1) = besseli(0,t,1);
    %puis on calcule les valeurs pour les autres pixels
    %en tenant compte du fait que notre fonction est symetrique
    for n = 1:1:demiTaille
        g(demiTaille+1+n) = besseli(n,t,1);
        g(demiTaille+1-n) = g(demiTaille+1+n);
    end
        if nargin <= 1
g=g/sum(g);
        end

varargout = {g}  ;