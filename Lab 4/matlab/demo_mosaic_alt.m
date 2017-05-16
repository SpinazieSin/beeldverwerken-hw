% This function is a modified version of demo_mosai.m
% It takes a specified number of points as input.
function demo_mosaic_alt(n_points)
    
    % read in images
    f1 = imread('nachtwacht1.jpg');
    f2 = imread('nachtwacht2.jpg');

    % obtain points by user
    [xy, xaya] = pickmatchingpoints(f1, f2, n_points, 1);

    % create projection matrix and transpose
    M = createProjectionMatrix(xy', xaya')';
    % obtain real coordinates
    T = maketform('projective', M);

    [x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

    xdata = [min(1,x(1)) max(size(f2,2),x(2))];
    ydata = [min(1,y(1)) max(size(f2,1),y(2))];
    f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
    f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
    subplot(1,1,1);
    imshow(max(f12,f22));
end