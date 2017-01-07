function main()

addpath('libsvm/matlab');
pkg load image;
load data_projet.mat;
addpath('svr');


imshow(images_test_lr(1:10, 1:10, 1:1), []);

params.method = 2

res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:5), images_apprentissage_hr(1:20, 1:20, 1:5), images_test_lr(1:10, 1:10, 1:1), params);
%{
param.method = -1;
param.R = 0;
res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:2), images_apprentissage_hr(1:20, 1:20, 1:2), images_test_lr(1:10, 1:10, 1:1),param);
%}
disp(size(res));
imshow(res, []);

end
