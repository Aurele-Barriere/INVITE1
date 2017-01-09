function images_superresolues = super_resolution(images_learning_basse_resolution, images_learning_haute_resolution, images_test, param)
% super Resolution 
%   learn from initial pictures in low and high resolution
%   and apply the svm technique to a low resolution test

% Format images
[s1, s2, s3] = size(images_learning_basse_resolution);
[s1_, s2_, s3_] = size(images_learning_haute_resolution);
assert (s3 == s3_);

if (nargin == 3 || isfield(param, 'R') == 0)
  R = 1;
else
  R=param.R;
end

assert(s1_ / s1 == s2_ / s2)
R_ = s1_ / s1; % high res radius

im_entree = [];
im_sortie = [];
for n=1:s3 % reshape data
    im_entree = [im_entree;im2patches(images_learning_basse_resolution(:,:,n),R,'replicate')];
    
    for i=1:s1
         for j=1:s2
             im_sortie = [im_sortie reshape(images_learning_haute_resolution(((i-1)*R_)+1:(i*R_), ((j-1)*R_)+1:(j*R_), n), [R_*R_, 1])];
         end
     end    
end


im_sortie = transpose(im_sortie);

% SVR method
if(nargin == 3 || (param.method == 0 && param.gamma == 0))
    
    nb_folds = 10;
    [label_kt,label_kv,data_kt,data_kv] = decoupe_data(im_entree, im_sortie, nb_folds);
    gamma=[0.1 0.5 1 2 5 10 15 20];
    
    % does the cross validation
    best = cross_validation(nb_folds, label_kt, label_kv, data_kt, data_kv, gamma)
    param.gamma = best;
       
end


if (nargin == 3 || param.method == 0)
    options.kernel_d = param.gamma;
    options.kernel_type = 'gaussian';
    % im2patches
    im_test = [];
    [t1 t2 t3] = size(images_test);
    for n = 1:1 % 1:t3 for all images
        im_test = [im_test; im2patches(images_test(:,:,n),R,'replicate')];
    end
    % Does the regression
    im_sup = svm_regression(im_test, im_sortie, im_entree, options);
    
    % reshape the result
    image_res = zeros(t1*R_,t2*R_);
    for i = 1:t1
      for j = 1:t2
        for t = 1:R_
          for t_ = 1:R_
            image_res(R_*(i-1)+t, R_*(j-1)+t_) = im_sup(i + t1*(j-1), t+R_*(t_-1));
          end
        end
      end
    end
    disp(size(image_res));
    images_superresolues = image_res;
    
end

% SVR method with addition of gradient information
if (nargin == 4 && param.method == 2)
  param.sigma = [2 3 5 10 20];
  
  % Add gradient parameters
  for sigma = param.sigma
    new_line_x = [];
    new_line_y = [];
    for t = 1:s3
      [im_entree_x, im_entree_y] = gradient_images(images_learning_basse_resolution(:,:,t), sigma);
      for i = 1:s1
        for j = 1:s2
          new_line_x = [new_line_x im_entree_x(i,j)];
          new_line_y = [new_line_y im_entree_y(i,j)];
        end
      end
    end
    im_entree = [im_entree transpose(new_line_x) transpose(new_line_y)];
  end
  
  
  % cross validation
  if (not(isfield(param, 'gamma')) || param.gamma == 0)
    nb_folds = 10;
    [label_kt,label_kv,data_kt,data_kv] = decoupe_data(im_entree, im_sortie, nb_folds);
    gamma=[0.1 0.5 1 2 5 10 15 20];
    best = cross_validation(nb_folds, label_kt, label_kv, data_kt, data_kv, gamma);
    param.gamma = best;
  end
  
  options.kernel_d = param.gamma;
  options.kernel_type = 'gaussian';

  % the end
  
  % prepare the test image
  im_test = [];
  [t1 t2 t3] = size(images_test);
  for n = 1:1 % 1:t3 for all images
    im_test = [im_test; im2patches(images_test(:,:,n),R,'replicate')];
  end
  for sigma = param.sigma
    new_line_x = [];
    new_line_y = [];
    for t = 1:t3
      [im_test_x, im_test_y] = gradient_images(images_learning_basse_resolution(:,:,t), sigma);
      for i = 1:t1
        for j = 1:t2
          new_line_x = [new_line_x im_test_x(i,j)];
          new_line_y = [new_line_y im_test_y(i,j)];
        end
      end
    end
    im_test = [im_test transpose(new_line_x) transpose(new_line_y)];
  end
  disp(size(im_test)); disp(size(im_sortie)); disp(size(im_entree));
  
  % Does the regression
  im_sup = svm_regression(im_test, im_sortie, im_entree, options);
  
  % Transform the result into an image
  image_res = zeros(t1*R_,t2*R_);
    for i = 1:t1
      for j = 1:t2
        for t = 1:R_
          for t_ = 1:R_
            image_res(R_*(i-1)+t, R_*(j-1)+t_) = im_sup(i + t1*(j-1), t+R_*(t_-1));
          end
        end
      end
    end
  disp(size(image_res));
  images_superresolues = image_res;
  
  
end

% KNN method
if(nargin == 4 && param.method == -1)
  %{
  % validation croisée
    if(param.k == 0)
      klist = [1 2 3 4 5];
      klength = 5;
    end
    if(param.k > 0)
      klist = [param.k];
      klength = 1;
    end
    if(param.rayon == 0)
      rlist = [1 2 3];
      rlength = 3;  
    end
    if(param.rayon > 0)
      rlist = [param.r];
      rlength = 1;
    end
    if (klength > 1 || rlength > 1)
      for k = 1:klength
        for r = 1:rlength
            % test
	    % eval performance
	    disp(todo);
        end
      end
   end
	  %}
   k = 3;
   r = 1;
  % to change
  % now that k and r are determined, starting knn algorithm
  [t1 t2 t3] = size(images_test);
  result = zeros(t1*R_,t2*R_);
  im_test = images_test;
  %  for n = 1:1 % 1:t3 for all images
  %im_test = [im_test; im2patches(images_test(:,:,n),R,'replicate')];
  %end
  for i = 1:t1
    for j = 1:t2
      M = knn(im_test, im_sortie, im_entree, k, r, i, j,R_);
      size(M);
      size(im_test);
      for x = 1:r
        for y = 1:r
          result(R_*(i-1)+x, R_*(j-1)+y)=M(x,y);
        end
      end
    end
  end
  images_superresolues = result;
end

end
