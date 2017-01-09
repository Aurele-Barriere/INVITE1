function knn_matrix = knn(im_test, im_sortie, im_entree, k, r, i, j, R_)
% knn algorithm
% im_entree and im_sortie are the database of low-res/high-res images 
% im_test is an image in low-res
% we want to return the high-res matrix associated with the i,j pixel of im_test
% by blending the k nearest neighbor in im_entree
% r is the size of the neighborhood

  assert(nargin == 8)
% we make sure that there is every argument
  knn_matrix=zeros(R_,R_);
  [s1 s2 s3] = size(im_entree);
  im=padarray(im_test,[r r],'replicate');
% we replicate the sides of the image 
  vois = im(i:i+2*r,j:j+2*r);
% the neighborhood of the point in i,j coordinates 
  voisinage = reshape(vois,[1,(2*r+1)*(2*r+1)]);
  dist = zeros(s1,2);
% the array of distance between the neighborhood and the matrices in im_entree
  for t = 1 : s1
	    disp(r); fflush(stdout);
    dist(t,1) = norm(im_entree(t,:)-voisinage,2);
    dist(t,2) = t;
  end
% we sort this array with the first column
  sorteddist = sortrows(dist,1);
% and we only take the k closer matrices
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
