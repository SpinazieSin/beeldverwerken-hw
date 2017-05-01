%% 1D Gaussian Kernel
function G = Gauss1(sigma)
    % An appropriate grid size would be 3 times sigma.
    radius = round(3*sigma);
    x = -radius:radius;
    G = exp(-(x .* x) ./ (2*sigma^2));
    G = G ./ (sqrt(2*pi) * sigma);
    G = (1 / sum(G(:))) * G;
end