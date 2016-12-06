% function y = gauss(x,std,moy)
% def : moy = 0
% T. Corpetti
function y = gauss(x,std,moy)
if nargin==2
  moy = 0;
end
coef1 = (2*std*std); coef2  = (std*sqrt(2*pi));
y = exp(-((x-moy).*(x-moy))/coef1) /coef2;

%y = y*(x(2)-x(1));