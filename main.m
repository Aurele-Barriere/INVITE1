function main()

addpath('libsvm/matlab');
pkg load image;
load data_projet.mat;
addpath('svr');


imshow(images_test_lr(1:10, 1:10, 1:1), []);
%{
params.method = 2

res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:5), images_apprentissage_hr(1:20, 1:20, 1:5), images_test_lr(1:10, 1:10, 1:1), params);
 %}
%{
param.method = 2;
param.R = 1;
res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:10), images_apprentissage_hr(1:20, 1:20, 1:10), images_test_lr(1:10, 1:10, 1:1),param);
 %}
param.method = -1;
param.R = 1;
param.k = 5;
param.rayon = 1;
res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:10), images_apprentissage_hr(1:20, 1:20, 1:10), images_test_lr(1:10, 1:10, 1:1),param);

disp(size(res));
imshow(res, []);

end
