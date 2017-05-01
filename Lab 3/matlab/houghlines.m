% Find significant lines
% not working yet
function [lines] = houghlines(im, h, thresh)

rows = size(im, 1);
cols = size(im, 2);
rhomax = sqrt(rows^2 + cols^2);
drho = 2 * rhomax / (size(h, 1) - 1);
dtheta = pi / size(h, 2);

peaks = h > thresh;
size(peaks)
 
[bwl, nregions] = bwlabel(peaks);

size(bwl)
nregions

for n = 1:nregions
    mask = bwl == n;
    region = mask .* h;
end

end