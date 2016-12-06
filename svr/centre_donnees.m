% function data_centre=centre_donnees(data);
% Recentre des donnees multidimentionnelles
% data
% chaque dimension sur une colonne
function [data_centre,m,v]=centre_donnees(data,m,v);


[nl,nc]=size(data);
if nargin==1
m=mean(data);
v=var(data);
end

       for j=1:nc
            data_centre(:,j)=(data(:,j)-m(j))/(sqrt(v(j)));
        end
