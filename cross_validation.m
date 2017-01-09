function best_param = cross_validation(nb_folds, label_kt,label_kv,data_kt,data_kv, gammas)

  perf_moy = zeros(size(gammas));
  
  for g = 1:size(gammas)
    options.kernel_d = gammas(g);
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
  
  best_param = gammas(imin)

end
