function [points] = houghlines(im, h, thresh)

    rows = size(im, 1);
    cols = size(im, 2);
    nrho = size(h, 1);
    ntheta = size(h, 2);
    rhomax = sqrt(rows^2 + cols^2);
    % Old peak finding method using bwlabel
    %peaks = ((h / max(max(h))) > thresh) .* h;
    %[bwl, nregions] = bwlabel(peaks);

    % Dilated image peak finding
    local_max = (h/max(max(h)) > thresh) & (imdilate(h, strel('disk',8)) == h);
    [max_row, max_col] = find(local_max);

    points = zeros(length(max_row), 2);
    % For every peak find the corresponding rho and theta
    for n = 1:length(max_row)
        % Old peak finding using bwlabel
        %mask = bwl == n;
        %region = mask .* h;
        %[rho, theta] = max(max(region));
        points(n, 1) = (max_col(n)*pi)/ntheta;
        points(n, 2) = (max_row(n)*2*rhomax)/nrho - rhomax;
    end
    
    % Plot lines loop
    for i = 1:length(points)
        [x1, y1, x2, y2] = thetarho2endpoints(points(i,1), points(i,2), 500, 500);
        plot([x1, x2], [y1, y2]);
    end
    
    for i= 1:size(rho,2)
    [x1,y1,x2,y2] = thetarho2endpoints(theta(i),rho(i),rows,cols);
    XX(1:2,i) = [x1;x2];
    YY(1:2,i) = [y1;y2];
end
% Combine the endpoints in XXYY
XXYY = [XX;YY];
imshow(im,[]);
Lines = [];

% Get the edge points again
[y,x] = find(EdgeIm);
points = [x,y];

lines=[];
for i = 1:size(XXYY,2)
%  Used to plot all the lines  
   line(XXYY(1:2,i),XXYY(3:4,i));
   % The homogeneous coordinates of both points
   XYline1(1:3,i) = [XXYY(1,i);XXYY(3,i);1];
   XYline2(1:3,i) = [XXYY(2,i);XXYY(4,i);1];
   % Cross product to find the corresponding line
   c = cross(XYline1(1:3,i),XYline2(1:3,i));
   % Normalize the line
   c = c/sqrt(c(1)^2 + c(2)^2);
   % Add found line to existing Lines
   Lines = [Lines, c];
   % Get the Points of Line per line
   PoL = points_of_line(points, c,1);
   % And try to fit a line through these points
   LTP = line_through_points(PoL);
   % Add those lines to lines
   lines = [lines,LTP];

   % Used to plot all found points by points_of_line
   for j = 1:size(PoL)
        im(magic(5));
        hold on;
        plot(PoL(j,1), PoL(j, 2),'r.','MarkerSize',10);
        hold off;
   end

end
end