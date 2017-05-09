% Calculate Hough transform
function accumulator = hough(im, Thresh, nrho, ntheta, method)

    if method == 0 % own implementation
        points = canny(im, 0.7); 
    end
    if method == 1 % built-in implementation
        points = edge(im, 'Canny', Thresh); 
    end

    accumulator = zeros(nrho, ntheta);
    [y, x] = find(points);
    rows = size(im, 1);
    cols = size(im, 2);

    rhomax = sqrt(rows^2 + cols^2);
    drho = 2 * rhomax / (nrho-1);
    dtheta = pi / ntheta;
    thetas = [0:dtheta:(pi-dtheta)];

    for i = [x';y']
        for theta = thetas
            rho = i(1) * sin(theta) - i(2) * cos(theta);
            rhoindex = round(rho/drho + nrho/2);
            thetaindex = round(theta/dtheta +1);
            accumulator(rhoindex, thetaindex) =...
                accumulator(rhoindex, thetaindex) + 1;
        end
    end

end