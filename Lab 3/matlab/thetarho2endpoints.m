% Draw the lines
function [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, rows, cols)
    
    % If line is close to horizontal
    x1 = 0;
    y1 = (x1 * sin(theta)-rho) / cos(theta);
    x2 = cols;
    y2 = (x2 * sin(theta)-rho) / cos(theta);
    
    % If line is close to vertical
    if y2-y1 > rows
        y1 = 0;
        x1 = (y1 * cos(theta)+rho) / sin(theta);
        y2 = rows;
        x2 = (y2 * cos(theta)+rho) / sin(theta);
    end    
end