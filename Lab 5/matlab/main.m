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

%% Principal Component Analysis
% NumComponents set the dimensionality of the coefficients
[coeff, ~, eigenvalues] = pca(train_set, 'NumComponents', 50);
for i = 1:size(coeff, 2)
    coeff(:, i) = coeff(:, i)/max(coeff(:, i));
end

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

%% Image similarity

% This loop creates a matrix (image_index_list) of images that are most
% similar to eachother.
tic;
image_index_list = zeros(2, (size(data.images, 2) - 250));
for image = 1:(size(data.images, 2) - 250)
    best_similarity = 0;
    similar_image_index = 0;
    for i = 1:size(coeff, 2)
        similarity = dot(coeff(:, i), reshape(data.images{1,image}.img, 16800, 1));
        if similarity < best_similarity && i ~= image
            best_similarity = similarity;
            similar_image_index = i;
        end
    end
    % The image most similar to the image that is not itself is saved as i
    image_index_list(:, image) = [image, similar_image_index];
end
toc

%% Native image similarity

% This loop creates a matrix (native_image_index_list) of images that are most
% similar to eachother using the regular set of images instead of the PCA list.
tic;
native_image_index_list = zeros(2, (size(data.images, 2) - 250));
for image = 1:(size(data.images, 2) - 250)
    best_similarity = 0;
    similar_image_index = 0;
    for i = 1:(size(data.images, 2) - 250)
        similarity = immse(reshape(data.images{1,i}.img, 1, 16800), reshape(data.images{1,image}.img, 1, 16800));
        if similarity < best_similarity && i ~= image
            best_similarity = similarity;
            similar_image_index = i;
        end
    end
    % The image most similar to the image that is not itself is saved as native_image_index_list
    native_image_index_list(:, image) = [image, similar_image_index];
end
toc

%% Positioning with Nearest Neighbour

% Training and test set pca
[train_set_coeff, score, eigenvalues] = pca([train_set; test_set], 'NumComponents', 50, 'Algorithm', 'svd');
for i = 1:size(train_set_coeff, 2)
    train_set_coeff(:, i) = train_set_coeff(:, i)/max(train_set_coeff(:, i));
end
