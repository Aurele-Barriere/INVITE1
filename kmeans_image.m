% function label=kmeans_image(image,nb,sigma,coef_centres)
% k-means sur une image (que l'on filtre avec un filtre gaussien
% d'un ecart type de sigma, defaut = 1.5)
%
% On met les images dans ue matrice de N lignes (N étant le nombre
% de pixels) et P colonnes (P étant le nombre de "canaux" des images)
%
% On peut également rajoutee les coordonnées (X,Y) des points dans 
% les deux derniers vecteurs (pour faire un "lien spatial"), ce lien étant
% pondéré par la valeur coef_centres (defaut =1)
function label=kmeans_image(image,nb,sigma,coef_centres)
if nargin==2
    sigma=1.5;coef_centres=1;
elseif nargin==3
    coef_centres=1;
end

% Création des coordonnees des images
[nl,nc,ndim]=size(image);
k=1;
lig=(1:nl)'*ones([1,nc]);
col=ones(nl,1)*(1:nc);
vlig=reshape(lig',nl*nc,1);
vcol=reshape(col',nl*nc,1);

% Initialisation de la luminance (somme des canaux)
% utile seulement pour l'affichage
lum=zeros([nl,nc]);

% Création d'un filtre gaussien
gf = filtre_gaussien(6*sigma+1,sigma,6*sigma+1,sigma);

for i=1:ndim
    t=imfilter(double(image(:,:,i)),gf,'symmetric');
    lum=lum+double(t);
    % Mise des donnees dans un tableau
    X(:,i)= reshape(t',nl*nc,1);
end
coef=coef_centres/(max(nl,nc));
X=double(X);
X=centre_donnees(X);
% On rajoute deux dimensions liées aux coordonnes
X(:,end+1)=vlig.*coef;
X(:,end+1)=vcol.*coef;

% k-means
[N,P]=size(X);
for i=1:nb
    centres(i,:)=rand(size(mean(X))).*mean(X);
end

label=zeros(N,1);
convergence=0;k=1;
close all;
figure;
imagesc(reshape(label,nc,nl)');
while ~convergence
    centres_old=centres;
    % Calcul des distances au centre
    for i=1:nb
        
        centres_mat=ones(N,1)*centres(i,:);
        tmp=(X-centres_mat);tmp=tmp.*tmp;tmp=tmp';
        dist(:,i)=abs(sum(tmp))';
    end
    % On affecte les labels aux distances les plus proches
    % par rapport au centre
    [val,ind]=min(dist');
    clf;
    imagesc(reshape(label,nc,nl)'+lum/(max(lum(:))));
    hold on;
    for i=1:nb
        ii=find(ind==i);
        label(ii)=i;
        centres(i,:)=mean(X(ii,:));
        %plot(X(ii,end-2),X(ii,end-1),col{i});
        %        fprintf(' %.2f - %.2f | ',centres(i,ndim+1),centres(i,ndim+2));
        %  plot(centres(i,ndim+2)./coef_centres,centres(i,ndim+1)./coef_centres,'k+','LineWidth',2);
        %                        plot(20,80,'k+','LineWidth',8);
        
    end
    % fprintf('\n');
    ntitle=sprintf('iteration %d',k);title(ntitle);
    pause(0.1);
    
    k=k+1;
    if (k==80) | (centres_old==centres)
        convergence=1;
    end
    
    
end
fprintf('** Convergence after %d iterations **\n',k);
label=reshape(label,nc,nl)';

