% function im_filt= spectres_images(im,sigma)
% calcul des spectres d'une image
% sigma est un tableau de valeurs croissantes
% im_filt contient un tableau des valeurs filtrées
function im_filt= spectres_images(im,sigma)

for i=1:numel(sigma)
    filtre = discrete_gaussian(sigma(i));
    filtre =filtre/(sum(filtre));
    %    t=imfilter(im,filtre,'circular');
    t=imfilter(im,filtre,'circular');
    im_filt(:,:,i)=t;
end
