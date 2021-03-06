%% Lab 4
% Philip Bouman (10668667)
% Thomas Groot  (10658017)

addpath('../attachments');

%% QUESTION 2

% modified demo_mosaic.m (more than 4 points)
demo_mosaic_alt(6);
clear;

%% QUESTION 3 Find matches

% load images
f1 = rgb2gray(imread('nachtwacht1.jpg'));
f2 = rgb2gray(imread('nachtwacht2.jpg'));

% get descriptors and features
[frame1, desc1] = vl_sift(single(f1));
[frame2, desc2] = vl_sift(single(f2));

% find matches
matches = vl_ubcmatch(desc1, desc2);
    
% get the coordinates
m1 = matches(1,:);
m1coords = frame1(:,m1);
m1coords = m1coords(1:2,:);
m2 = matches(2,:);
m2coords = frame2(:,m2);
m2coords = m2coords(1:2,:);

% plot
figure('name','Matches');
subplot(1,2,1);
imshow(f1);
for i = 1:length(m1coords)
    text(m1coords(1, i), m1coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht1.jpg');

subplot(1,2,2);
imshow(f2);
for i = 1:length(m2coords)
    text(m2coords(1, i), m2coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht2.jpg');

%% QUESTION 3 Estimate projection matrix

% hand picked points that match
p1coords = m1coords(:,[3, 8, 11, 19, 24, 29])';
p2coords = m2coords(:,[3, 8, 11, 19, 24, 29])';

P = createProjectionMatrix(p1coords, p2coords);

% transform to real coordinates 
m2coords = P * [m1coords; ones(1, length(m1coords))];
for i = 1:length(m2coords)
    m2coords(:,i) = m2coords(:,i) ./ m2coords(3,i);
end
m2coords = m2coords(1:2,:);

% plot
figure('name','Correct matches');
subplot(1,2,1);
imshow(f1);
for i = 1:length(m1coords)
    text(m1coords(1, i), m1coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht1.jpg');

subplot(1,2,2);
imshow(f2);
for i = 1:length(m2coords)
    text(m2coords(1, i), m2coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht2.jpg');

%% QUESTION 3 Bad matches

% get the coordinates
m1 = matches(1,:);
m1coords = frame1(:,m1);
m1coords = m1coords(1:2,:);
m2 = matches(2,:);
m2coords = frame2(:,m2);
m2coords = m2coords(1:2,:);

% hand picked points that don't match
p1coords = m1coords(:,[1, 7, 12, 18, 25, 30])';
p2coords = m2coords(:,[1, 7, 12, 18, 25, 30])';

P = createProjectionMatrix(p1coords, p2coords);

% transform to real coordinates 
m2coords = P * [m1coords; ones(1, length(m1coords))];
for i = 1:length(m2coords)
    m2coords(:,i) = m2coords(:,i) ./ m2coords(3,i);
end
m2coords = m2coords(1:2,:);

% plot
figure('name','Incorrect matches');
subplot(1,2,1);
imshow(f1);
for i = 1:length(m1coords)
    text(m1coords(1, i), m1coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht1.jpg');

subplot(1,2,2);
imshow(f2);
for i = 1:length(m2coords)
    text(m2coords(1, i), m2coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht2.jpg');

%% QUESTION 4 RANSAC

% parameters
n_points = 8;
error = 1;
iter = 10;
thresh = 0.5;

% find best fit using RANSAC and transform
fit = ransac(f1, f2, n_points, error, iter, thresh)'
T = maketform('projective', fit);

% visualize (from demo_mosaic.m)
[x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

xdata = [min(1,x(1)) max(size(f2,2),x(2))];
ydata = [min(1,y(1)) max(size(f2,1),y(2))];
f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
figure('name','RANSAC Mosaic');    
subplot(1,1,1);
imshow(max(f12,f22));


