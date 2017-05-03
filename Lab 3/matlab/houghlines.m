% Find significant lines
% not working yet
function [lines] = houghlines(im, h, thresh)

rows = size(im, 1);
cols = size(im, 2);
rhomax = sqrt(rows^2 + cols^2);
drho = 2 * rhomax / (size(h, 1) - 1);
dtheta = pi / size(h, 2);

peaks = h > thresh;

[bwl, nregions] = bwlabel(peaks);


lines = zeros(nregions, 1);
for n = 1:nregions
    mask = bwl == n;
    region = mask .* h;
    [rho, theta] = max(max(region));
    lines = [theta, rho];
end

end