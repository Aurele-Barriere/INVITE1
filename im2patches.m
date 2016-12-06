% function imP = im2patches(im,r,border)
% imP : N (nlig x ncol) lines and
%      (2r+1)x(2r+1) (col)
% containing in each line patches centered in each pixel
% 
% 
% border = 'circulate' (defaut), 'replicate', 'symmetric' or 0
function imP=im2patches(im,r,border);

if nargin==2
        border='circular';
end
[nl,nc]=size(im);
imp=padarray(im,[r r],border);
k=1;
taille=(2*r+1)*(2*r+1);
    for j=1:nc
for i=1:nl
        patch=imp(i:i+2*r,j:j+2*r);
    imP(k,:)=reshape(patch,[1,taille]);
    k=k+1;
    end
end

