function knn_matrix = knn(im_test, im_sortie, im_entree, k, r, i, j)
% knn algorithm
  assert(nargin == 7)
  knn_matrix=zeros(r,r)
