function main()

addpath('libsvm/matlab');
pkg load image;
load data_projet.mat;
addpath('svr');
super_resolution(images_apprentissage_lr(:, :, 1:2), images_apprentissage_hr(:, :, 1:2), images_test_lr)

end