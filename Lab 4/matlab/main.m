%%
addpath('../attachments');

%% QUESTION 2
demo_mosaic;
clear;

%%
demo_mosaic_alt(5);
clear;

%% Matching points with SIFT
nacht1 = imread('nachtwacht1.jpg');
nacht2 = imread('nachtwacht2.jpg');

im1 = single(rgb2gray(nacht1));
im2 = single(rgb2gray(nacht2));
[F1, D1] = vl_sift(im1) ;
[F2, D2] = vl_sift(im2) ;
[matches, scores] = vl_ubcmatch(D1, D2);

subplot(1,2,1);
imshow(nacht1);
hold on;
plot(F1(1,matches(1,:)), F1(2, matches(1,:)), '*');
subplot(1,2,2);
imshow(nacht2);
hold on
plot(F2(1, matches(2,:)), F2(2, matches(2,:)), '*');
hold off
%%