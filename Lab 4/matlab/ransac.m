function [fit] = ransac(f1, f2, n_points, error, iter, thresh)
    
    % get descriptors and features
    [frame1, desc1] = vl_sift(single(f1));
    [frame2, desc2] = vl_sift(single(f2));

    % find matches
    matches = vl_ubcmatch(desc1, desc2);

    % get the coordinates
    m1 = matches(1,:);
    m1coords = frame1(:,m1);
    m1coords = m1coords(1:2,:);
    m2 = matches(2,:);
    m2coords = frame2(:,m2);
    m2coords = m2coords(1:2,:);
    
    cost = inf();
    
    inlier_ratio = ceil(size(matches, 2) * thresh);
    
    for i = 1:iter
        
        n_random = randi(size(matches, 2), 1, n_points);
        m1 = m1coords(:,n_random);
        m2 = m2coords(:,n_random);
        
        % get projection matrix
        P = createProjectionMatrix(m1', m2');
        
        % transform to real coordinates 
        points = P * [m1coords; ones(1, size(m1coords, 2))];
        for j = 1:length(points)
            points(:,j) = points(:,j) ./ points(3,j);
        end
        points = points(1:2,:);
        
        euclidean = sqrt(sum((m2coords - points).^2));
        
        inliers = find(euclidean < error);
        n_inliers = length(inliers);
        
        if n_inliers >= inlier_ratio
            
            
            m1 = m1coords(:,inliers);
            m2 = m2coords(:,inliers);

            % get projection matrix
            P2 = createProjectionMatrix(m1', m2');
            
            % transform to real coordinates 
            points = P2 * [m1; ones(1, size(m1, 2))];
            for j = 1:length(points)
                points(:,j) = points(:,j) ./ points(3,j);
            end
            points = points(1:2,:);
    
            updated_cost = sum(sqrt(sum((m2 - points).^2)));
            
            if updated_cost < cost
                cost = updated_cost;
                fit = P2;
            end
        end
    end
end
    