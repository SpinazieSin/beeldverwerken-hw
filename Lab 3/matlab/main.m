%% Exercise 3
% Philip Bouman (10668667) and Thomas Groot(10658017)

function main()
    close all
    path = '../attachments/';
    image = rgb2gray(im2double(imread(strcat(path, 'shapes.png'))));
    %image = rgb2gray(im2double(imread(strcat(path, 'billboard.png'))));
    %image = rgb2gray(im2double(imread(strcat(path, 'box.png'))));

    %% Question 2

    % canny edge detector from lab 2
	e1 = canny(image, 0.7);
    
    % built in canny edge detector
	e2 = edge(image,'Canny');
    
    acc1 = hough(image, [-0.9,0.9],200, 200, 0);
    acc2 = hough(image, [-0.9,0.9],300, 300, 1);

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

    imshow(image);
    hold on
    coords = houghlines(image, acc2, 0.4);
    hold off
    
    %% Question 5

    % Restructure results of find
    [x,y] = find(e1);
    edge_points = [x,y];
    % Loop over end points
    hold on
    for i = 1:length(coords)
        % Get the cross product of the two end point vectors
        cross_vector = cross([coords(i,1),coords(i,2),1], [coords(i,3),coords(i,4),1]);
        norm_cross_prod = cross_vector/norm(cross_vector);
        % Calculate the line points
        line_points = points_of_line(edge_points, norm_cross_prod, 1);
        % Least square fit of line points
        line = line_through_points(line_points);
        plot(line)
    end
    hold off
    %% Question 6
    
    image = rgb2gray(im2double(imread(strcat(path, 'box.png'))));
    acc2 = hough(image, [-0.9,0.9],300, 300, 1);
    
    % show original image
    imshow(image);
    hold on
    coords = houghlines(image, acc2, 0.4);
    hold off
end