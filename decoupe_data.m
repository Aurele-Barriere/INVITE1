% function [label_t,label_v,data_t,data_v]=decoupe_data(label,data,nb_folds)
% decoupe un jeu de donnees pour la cross validation
% fournit une cellule de taille nb_folds
% avec les differents echantillons
function [label_kt,label_kv,data_kt,data_kv]=decoupe_data(label2,data2,nb_folds)
[nb2, dimout]=size(label2);
% bon format des donnees
for i=1:dimout
    label2(:,i)=reshape(label2(:,i),[numel(label2(:,i)),1]);
end
%nb2=numel(label2);
indice=randperm(nb2);
label=label2(indice,:);
data=data2(indice,:);

% test si on a des labels entiers (classif)
s=(fix(label)-label);ent=(sum(abs(s(:)))==0);
if ent
    val_labels=unique(label);
    nb_labels=numel(val_labels);
    
    
    %% Init
    ind=find(label==val_labels(1));
    nlabel=label(ind);
    ndata=data(ind,:);
    pas=fix(numel(nlabel)/nb_folds);
    
    label_kt{1}=nlabel(1:end-pas);
    label_kv{1}=nlabel(end-pas+1:end);
    data_kt{1}=ndata(1:end-pas,:);
    data_kv{1}=ndata(end-pas+1:end,:);
    for i=2:nb_folds
        label_kt{i}=[nlabel(1:end-i*pas)',nlabel(end-(i-1)*pas+1:end)']';
        label_kv{i}=nlabel(end-i*pas+1:end-(i-1)*pas);
        data_kt{i}=[ndata(1:end-i*pas,:)',ndata(end-(i-1)*pas+1:end,:)']';
        data_kv{i}=ndata(end-i*pas+1:end-(i-1)*pas,:);
    end
    
    
    
    
    
    
    for k=2:nb_labels
        ind=find(label==val_labels(k));
        nlabel=label(ind);
        ndata=data(ind,:);
        pas=fix(numel(nlabel)/nb_folds);
        
        % init
        tmpo=nlabel(1:end-pas);
        label_kt{1}=[label_kt{1}',tmpo']';
        tmpo=nlabel(end-pas+1:end);
        label_kv{1}=[label_kv{1}',tmpo']';
        tmpo=ndata(1:end-pas,:);
        data_kt{1}=[data_kt{1}',tmpo']';
        tmpo=ndata(end-pas+1:end,:);
        data_kv{1}=[data_kv{1}',tmpo']';
        
        
        for i=2:nb_folds
            tmpo=[nlabel(1:end-i*pas)',nlabel(end-(i-1)*pas+1:end)']';
            label_kt{i}=[label_kt{i}',tmpo']';
            tmpo=nlabel(end-i*pas+1:end-(i-1)*pas);
            label_kv{i}=[label_kv{i}',tmpo']';
            tmpo=[ndata(1:end-i*pas,:)',ndata(end-(i-1)*pas+1:end,:)']';
            data_kt{i}=[data_kt{i}',tmpo']';
            tmpo=ndata(end-i*pas+1:end-(i-1)*pas,:);
            data_kv{i}=[data_kv{i}',tmpo']';
        end
        
    end
else

    %% Init
    
    pas=fix(nb2/nb_folds);
    
    label_kt{1}=label(1:end-pas,:);
    label_kv{1}=label(end-pas+1:end,:);
    data_kt{1}=data(1:end-pas,:);
    data_kv{1}=data(end-pas+1:end,:);
    for i=2:nb_folds
        label_kt{i}=[label(1:end-i*pas,:)',label(end-(i-1)*pas+1:end,:)']';
        label_kv{i}=label(end-i*pas+1:end-(i-1)*pas,:);
        data_kt{i}=[data(1:end-i*pas,:)',data(end-(i-1)*pas+1:end,:)']';
        data_kv{i}=data(end-i*pas+1:end-(i-1)*pas,:);
    end
 end