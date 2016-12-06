%function data_centre=centre_donnees(data);
% centre et r�duit des donnees multidimentionnelles
% data
% chaque dimension sur une colonne
function [data_centre,moyenne,variance]=centre_donnees_(data);


[nl,nc]=size(data);
m=mean(data);
v=var(data);
       for j=1:nc
            data_centre(:,j)=(data(:,j)-m(j))/(sqrt(v(j)));
        end
moyenne=m;variance=v;
