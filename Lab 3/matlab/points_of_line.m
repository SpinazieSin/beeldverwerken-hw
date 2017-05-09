function result_points = points_of_line( points, line, epsilon )
    result_points = [];
    for i = 1:size(points, 1)
        point = [points(i,1), points(i,2), 1];
        if dot(point, line) <= epsilon
            result_points = [result_points; point];
        end
    end
end

