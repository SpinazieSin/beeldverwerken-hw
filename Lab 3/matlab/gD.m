%% Gaussian Derivatives
function result = gD(image, sigma, xorder, yorder)
    % An appropriate grid size would be 3 times sigma.
    radius = round(3*sigma);
    x = -radius:radius;
    g = Gauss1(sigma);
    dx = -x .* g ./ sigma^2;
    dxx = ((x .^2 ./ sigma^4) - (1/sigma^2)) .* g;
    if xorder == 0 
        image = imfilter(image, g, 'conv', 'replicate');
    end    
    if xorder == 1
        image = imfilter(image, dx, 'conv', 'replicate');
    end
    if xorder == 2
        image = imfilter(image, dxx, 'conv', 'replicate');
    end    
    if yorder == 0
        image = imfilter(image, g', 'conv', 'replicate');
    end    
    if yorder == 1
        image = imfilter(image, dx', 'conv', 'replicate');
    end
    if yorder == 2
        image = imfilter(image, dxx', 'conv', 'replicate');
    end    
    result = image;
end