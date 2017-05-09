function l = line_through_points( points )

centroid = mean(points);
covariance = zeros(3,3);
for i = 1:size(points,1)
   x = points(i, :) - centroid;
   covariance = covariance + (x'*x);
end

[~, ~, V] = svd(covariance);
l = V(:,1);
end

