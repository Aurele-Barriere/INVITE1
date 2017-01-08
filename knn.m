function knn_matrix_list = knn(im_test, im_sortie, im_entree, k, r, i, j)
% knn algorithm
  assert(nargin == 7)
  knn_matrix_list=zeros(r,r);
  [s1 s2 s3] = size(im_entree);
  im=padarray(im_test,[r r],'replicate');
  vois = im(i:i+2*r,j:j+2*r);
voisinage = reshape(vois,[1,(2*r+1)*(2*r+1)]);
dist = zeros(s1,2);
for t = 1 : s1
	  dist(t,1) = norm(im_entree(t,:)-voisinage,2);
dist(t,2) = t;
end
sorteddist = sortrows(dist,1);

closer = sorteddist(1:k,:)
