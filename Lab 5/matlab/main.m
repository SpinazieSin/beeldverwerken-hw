%% Lab 5
% Philip Bouman (10668667)
% Thomas Groot  (10658017)

addpath('../attachments');

%% Load data and reshaping images
data = load('omni.mat');

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

%%

