% function cout = optimal_transport_1D(serie1,serie2)
% Calcul du cout de transport entre 2 ditributions
%
% ENTREES
% serie1 et serie2 sur definie sur l'axe axt_t
%
% SORTIES
% cout : cout du transport associé
% Deuxieme sortie (optionnelle)
% T : fonction de transport associee
%
% Attention : si on normalise, ce ne sont plus les meme distributions
%             si elles n'ont pas la meme aire
%
%
% Pour avoir les interpolations

function cout = optimal_transport_1D(mu_x,mu_y)
normalisation=1;
p=2;
% Normalisation des densites
if normalisation==1
    mu_x=mu_x/(sum(mu_x));
    mu_y=mu_y/(sum(mu_y));
end
% Calcul des fonctions de repartition C_mux et C_muy

C_mux=cumsum(mu_x);
C_muy=cumsum(mu_y);


% Calcul du cout
if normalisation==1
    discretisation_cumul=linspace(0,1,numel(mu_x)*10);
else
    discretisation_cumul=linspace(0,max(max(C_muy),max(C_mux)),numel(mu_x)*10);
end
pas_d = discretisation_cumul(2)-discretisation_cumul(1);
for i=1:numel(discretisation_cumul)
invx(i)= inv_fonction(discretisation_cumul(i),1:numel(mu_x),C_mux);
invy(i)= inv_fonction(discretisation_cumul(i),1:numel(mu_x),C_muy);
end
increment_cout=abs(invy - invx);
cout=sum(power(increment_cout,p))*pas_d;

    
    
    
end



% pascal_modifie=zeros(size(pascal));
% for i=axe
% ind=find(pascal==i);
% pascal_modifie(ind)=T(i);
% end

