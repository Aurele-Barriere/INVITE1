% h = filtre_gaussien
% creation de filtres Gaussiens
%
%
% Cas 1D : h = filtre_gaussien(size_x,std_x)
%
%
% Cas 2D : h = filtre_gaussien(size_x,std_x,size_y,std_y)
%
%
% Cas 2D avec rotation : h = filtre_gaussien(size_x,std_x,size_y,std_y,theta)
%
% size : taille du filtre
% std : standard deviation sigma = sqrt(variance)
%
% utilise d2gauss
% T. Corpetti


function varargout = filtre_gaussien(n1,std1,n2,std2,theta)
if nargin==2
  n2 = 1;std2 = 1;theta = 0;
end
if nargin==3
  if n2==1
    std2 = 1;theta = 0;
  elseif n2==2
    std2 = std1;n2 = n1;theta = 0;
  else
    n2 = 1;std2 = 1;theta = 0;
  end
end  
if ((std1==0) & (std2==0))
    if nargout==1
        varargout={1};
    else
        varargout={1,1};
    end
else

if nargin==4
  theta = 0;
end

r=[cos(theta) -sin(theta);
   sin(theta)  cos(theta)];
for i = 1 : n2 
    for j = 1 : n1
        u = r * [j-(n1+1)/2 i-(n2+1)/2]';
        h(i,j) = gauss(u(1),std1)*gauss(u(2),std2);
    end
end
%h = h / sqrt(sum(sum(h.*h)));
coef = sum(sum(h));
h = h / coef;
if nargout==1
  varargout={h};
else
    varargout={h,coef};
end
end