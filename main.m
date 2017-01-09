function main()

  addpath('libsvm/matlab');
  pkg load image;
  load data_projet.mat;
  addpath('svr');


figure(1);
  imshow(images_test_lr(41:60, 41:60, 1:1), []);
%{
  params.method = 2

  res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:5), images_apprentissage_hr(1:20, 1:20, 1:5), images_test_lr(1:10, 1:10, 1:1), params);
 %}
%{
  param.method = 2;
  param.R = 1;
  res = super_resolution(images_apprentissage_lr(1:10, 1:10, 1:10), images_apprentissage_hr(1:20, 1:20, 1:10), images_test_lr(1:10, 1:10, 1:1),param);
 %}
%{
param.method = -1;
param.R = 1;
param.k = 0;
param.rayon = 1;
for k = 1:10
images_apprentissage_lr(:,:,k) = mat2gray(images_apprentissage_lr(:,:,k));
images_apprentissage_hr(:,:,k) = mat2gray(images_apprentissage_hr(:,:,k));
end
for k = 1:5
images_test_lr(:,:,k) = mat2gray(images_test_lr(:,:,k));
end


res = super_resolution(images_apprentissage_lr(41:60, 41:60, 1:10), images_apprentissage_hr(31:70, 31:70, 1:10), images_test_lr(41:60, 41:60, 1:1),param);
 %}

param.method = -1;
param.R = 1;
param.k = 0;
param.rayon = 1;

for k = 1:10
images_apprentissage_lr(:,:,k) = mat2gray(images_apprentissage_lr(:,:,k));
images_apprentissage_hr(:,:,k) = mat2gray(images_apprentissage_hr(:,:,k));
end
for k = 1:5
images_test_lr(:,:,k) = mat2gray(images_test_lr(:,:,k));
end


res = super_resolution(images_apprentissage_lr(41:60, 41:60, 1:10), images_apprentissage_hr(31:70, 31:70, 1:10), images_test_lr(41:60, 41:60, 1:1),param);


  disp(size(res));
figure (2);
  imshow(res, []);

end
