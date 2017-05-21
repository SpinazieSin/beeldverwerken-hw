%% Lab 5
% Philip Bouman (10668667)
% Thomas Groot  (10658017)


%% Add data folder to path
addpath('../attachments');

%% Load data and reshaping images
data = load('omni.mat');

% Reshaping data 2.4
% Create training set
train_set = zeros(300, 16800);
for i = 1:300
      train_set(i, :) = reshape(data.images{1,i}.img, 1, 16800);
end
% Create testing set (test set index is index+training set size)
test_set = zeros(250, 16800);
for i = 1:250
    train_set(i, :) = reshape(data.images{1,i+300}.img, 1, 16800);
end

%% PCA
% NumComponents set the dimensionality of the coefficients
[coeff, ~, eigenvalues] = pca(train_set, 'NumComponents', 300);
for i = 1:size(coeff, 2)
    coeff(:, i) = coeff(:, i)/max(coeff(:, i));
end
%coeff = myPCA(train_set, 50);

%% Plot first 5 PCA vectors as images

for i = 1:5
    subplot(1,5,i)
    imshow(reshape(coeff(:, i), 112, 150));
end

%% Plot second 5 PCA vectors as images
for i = 6:10
    subplot(1,5,i-5)
    imshow(reshape(coeff(:, i), 112, 150));
end

%% Plot eigenvalues

plot(eigenvalues(1:50))

%%


