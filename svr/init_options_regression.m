% function options=init_options_regression
%
% kernel_type = 'linear' or 'gaussian' or 'polynomial'
% kernel_d = associated parameter (sigma or degree)
%                defaut : degree=3
%                         sigma = 1/nb_features
% default : gaussian 


function options = init_options_regression
    options.kernel_type = 'gaussian';
    options.kernel_d = 10;
