function images_superresolues = super_resolution(images_learning_basse_resolution, images_learning_haute_resolution, images_test, param)
% super Resolution 
%   learn from initial pictures in low and high resolution
%   and apply the svm technique to a low resolution test

% Format images
[s1, s2, s3] = size(images_learning_basse_resolution);
[s1_, s2_, s3_] = size(images_learning_haute_resolution);
assert (s3 == s3_);

if (nargin == 3 || exists(param.R) == 0)
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
   % im_sortie = [im_sortie im2patches(images_learning_haute_resolution(:,:,n),R_,'replicate')
    
    for i=1:s1
         for j=1:s2
             im_sortie = [im_sortie reshape(images_learning_haute_resolution(((i-1)*R_)+1:(i*R_), ((j-1)*R_)+1:(j*R_), n), [R_*R_, 1])];
         end
     end
    % im_entree_vect = reshape(im_basse, [(s2 - 2*R +1) * (s1 - 2*R + 1), 1]);
    % im_sortie_vect = reshape(im_sortie, [sizex * sizey, 1]);
    
end


im_sortie = transpose(im_sortie);
disp(size(im_entree))
disp(size(im_sortie))


% SVR method
if(nargin == 3 || (param.method == 0 && param.gamma == 0))
    
    % cross-validation
    nb_folds = 10;
    [label_kt,label_kv,data_kt,data_kv] = decoupe_data(im_entree, im_sortie, nb_folds);
    perf_moy = [0 0 0 0 0 0 0 0];
    gamma=[0.1 0.5 1 2 5 10 15 20];
    for g = 1:8
        disp(g); fflush(stdout);
        options.kernel_d = gamma(g);
        options.kernel_type = 'gaussian';
        for i=1:nb_folds
            X = label_kv{i};
            X_ = svm_regression(data_kv{i}, label_kt{i}, data_kt{i}, options);
            [x1 x2] = size(X);
            perf = sqrt ( (1 / (x1*x2)) * norm (X - X_) * norm (X - X_));
            perf_moy(g) = perf_moy(g) + perf;
        end
        disp(perf_moy(g)); fflush(stdout);
    end
    perf_moy = perf_moy ./ nb_folds
    disp(perf_moy); fflush(stdout);
    
    imin = 1;
    for i = 1:8
        if (perf_moy(i) < perf_moy(imin))
            imin = i;
        end
    end
    disp(imin);fflush(stdout);
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
    disp(im_test); fflush(stdout);
    images_superresolues = svm_regression(im_test, im_sortie, im_entree, options);

    % reshape
    
    images_superresolues = reshape(images_superresolues, [R_*t1 R_*t2]);
    
end
%}


% test with
% super_resolution(images_apprentissage_lr(100:120, 100:120, 1:2), images_apprentissage_hr(100:120, 100:120, 1:2), images_test_lr)
% compare with imresize(im, [taille * 2, taille * 2])