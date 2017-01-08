function knn_matrix = knn(im_test, im_sortie, im_entree, k, r, i, j, R_)
% knn algorithm
  assert(nargin == 8)
  knn_matrix=zeros(R_,R_);
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

  closer = sorteddist(1:k,:);
  for t1 = 1:R_
    for t2 = 1:R_
      p = 0;
      for s = 1:k
        p = p + im_sortie(closer(s,2),(t1-1)*R_+t2);
      end
      knn_matrix(t1,t2) = p/k;
    end
  end
end
