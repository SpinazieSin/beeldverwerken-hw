%% Exercise 3
% Philip Bouman (10668667) and Tomas Groot()

function main()
    close all
    path = '../attachments/'
    image = rgb2gray(im2double(imread(strcat(path, 'shapes.png'))));
    %image = rgb2gray(im2double(imread(strcat(path, 'billboard.png'))));
    %image = rgb2gray(im2double(imread(strcat(path, 'box.png'))));

    %% Question 2

    % canny edge detector from lab 2
	e1 = canny(image, 0.7);
    
    % built in canny edge detector
	e2 = edge(image,'Canny');
    
    acc1 = hough(image, [-0.9,0.9],50, 50, 0);
    acc2 = hough(image, [-0.9,0.9],100, 100, 1);

    figure;
	subplot(2,2,1);
	imshow(e1);
    title('Canny edge detector Lab 2');
	subplot(2,2,2);
	imshow(e2);
    title('Built-in Canny edge detector');
    subplot(2,2,3);
    imshow(acc1, []);
    title('Hough, using Canny Lab 2');
    subplot(2,2,4);
    imshow(acc2, []);
    title('Hough, using built-in Canny');

    %% Question 3

    coords = houghlines(image, acc1, 0.8)
end