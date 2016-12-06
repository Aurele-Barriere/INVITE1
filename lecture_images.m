% function im=lecture(nom_image)
% ex im=lecture('*tif')
% lecture de la serie temp d'images

function im=lecture(nom_image)
a=dir(nom_image);
for i=1:numel(a)
    im(:,:,i)=imread(a(i).name);
    fprintf('donnee %s traitee\n',a(i).name);
end
