% Find significant lines
% not working yet
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
    for n = 1:length(max_row)
        % Old peak finding using bwlabel
        %mask = bwl == n;
        %region = mask .* h;
        %[rho, theta] = max(max(region));
        points(n, 1) = (max_col(n)*pi)/ntheta;
        points(n, 2) = (max_row(n)*2*rhomax)/nrho - rhomax;
    end
end