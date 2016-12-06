function images_superresolues = super_resolution(images_learning_basse_resolution, images_learning_haute_resolution, images_test, param)
% super Resolution 
%   learn from initial pictures in low and high resolution
%   and apply the svm technique to a low resolution test

% Format images
[s1, s2, s3] = size(images_learning_basse_resolution);
[s1_, s2_, s3_] = size(images_learning_haute_resolution);
assert (s3 == s3_);

R = 1; % low res radius. to be fixed by parameter
R_ = 2; % high res radius

im_entree = [];
im_sortie = [];
for n=1:s3 % reshape data

   for i=1+R:s1-R
        for j=1+R:s2-R
            im_entree = [im_entree reshape(images_learning_basse_resolution(i-R:i+R, j-R:j+R, n), [(2 * R + 1) ^ 2, 1])];
            im_sortie = [im_sortie reshape(images_learning_haute_resolution(i*R_:i*R_ + R_ - 1, j*R_:j*R_ + R_ - 1, n), [R_^2, 1])];
        end
    end
    % im_entree_vect = reshape(im_basse, [(s2 - 2*R +1) * (s1 - 2*R + 1), 1]);
    % im_sortie_vect = reshape(im_sortie, [sizex * sizey, 1]);
    
end

im_entree = transpose(im_entree);
im_sortie = transpose(im_sortie);

% SVR method
if(nargin == 3 || (param.method == 0 && param.gamma == 0))
    
    % cross-validation
    nb_folds = 10;
    [label_kt,label_kv,data_kt,data_kv] = decoupe_data(im_entree, im_sortie, nb_folds);
    perf_moy = [0 0 0 0 0 0 0 0];
    gamma=[0.1 0.5 1 2 5 10 15 20];
    for g = 1:8
        for i=1:nb_folds
            X = data_kv{i};
            X_ = svm_regression(label_kv{i},data_kt{i},label_kt{i});
            
            perf = sqrt ( (1 / size(X)) * norm (X - X_) * norm (X - X_));
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

if (param.method == 0)
    options.kernel_d = param.gamma;

    images_superresolues = svm_regression(images_test, images_learning_basse_resolution, images_learning_haute_resolution, options)
end


% test with
% super_resolution(images_apprentissage_lr(100:120, 100:120, 1:2), images_apprentissage_hr(100:120, 100:120, 1:2), images_test_lr)