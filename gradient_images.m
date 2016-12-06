% [im_x,im_y]=gradient_images(im,sigma);
% Calcul des gradients de l'image im
% en x et y à une échelle sigma
function [im_x,im_y]=gradient_images(im,sigma);
[hx,hy] = filtre_derivee_gaussien(sigma);
im_x=imfilter(im,hx,'circular');
im_y=imfilter(im,hy,'circular');
