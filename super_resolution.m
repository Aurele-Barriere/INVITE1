function images_superresolues = super_resolution(images_learning_basse_resolution, images_learning_haute_resolution, images_test, param)
% super Resolution 
%   learn from initial pictures in low and high resolution
%   and apply the svm technique to a low resolution test

% Format images
[s1, s2, s3] = size(images_learning_basse_resolution);
[s1_, s2_, s3_] = size(images_learning_haute_resolution);
assert (s3 == s3_);

if (nargin == 3) % || exists(param.R) == 0) --> j'enleve ca, exists n'existe pas chez moi
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
    
    % cross-validation
    nb_folds = 10;
    [label_kt,label_kv,data_kt,data_kv] = decoupe_data(im_entree, im_sortie, nb_folds);
    perf_moy = [0 0 0 0 0 0 0 0];
    gamma=[0.1 0.5 1 2 5 10 15 20];
    for g = 1:8
        options.kernel_d = gamma(g);
        options.kernel_type = 'gaussian';
        for i=1:nb_folds
            X = label_kv{i};
            X_ = svm_regression(data_kv{i}, label_kt{i}, data_kt{i}, options);
            [x1 x2] = size(X);
            perf = sqrt ( (1 / (x1*x2)) * norm (X - X_) * norm (X - X_));
            perf_moy(g) = perf_moy(g) + perf;
        end
    end
    perf_moy = perf_moy ./ nb_folds
    
    imin = 1;
    for i = 1:8
        if (perf_moy(i) < perf_moy(imin))
            imin = i;
        end
    end
    param.gamma = gamma(imin);
       
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
    %{
    disp("images tests   ");disp(size(im_test));
    disp(im_test); fflush(stdout);
    %}
    images_superresolues = svm_regression(im_test, im_sortie, im_entree, options);
    %{
    disp("images superresolues   ");disp(size(images_superresolues));
    disp(images_superresolues); fflush(stdout);
    %}
    % reshape
    disp(size(images_superresolues))
    image_res = zeros(t1*R_,t2*R_);
    for i = 1:t1
      for j = 1:t2
        for t = 1:R_
          for t_ = 1:R_
            image_res(R_*(i-1)+t, R_*(j-1)+t_) = images_superresolues(i + t1*(j-1), t+R_*(t_-1));
          end
        end
      end
    end
    disp(size(image_res))
    images_superresolues = image_res
    % images_superresolues_ = reshape(images_superresolues, [R_*t1 R_*t2]);
    
end
%}


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
M = knn(im_test, im_sortie, im_entree, k, r, i, j);
size(M)
size(im_test)
for x = 1:r
for y = 1:r
result(R_*(i-1)+x, R_*(j-1)+y)=M(x,y);
end
end
end
end
images_superresolues = result
end


