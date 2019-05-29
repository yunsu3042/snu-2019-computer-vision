function [line, inliers] = ransac(points, iter, thr, mininlier)
    global_line = 0;
    max_inliers = 0;
    global_inliers = [];
    [~, n] = size(points);
    for i = 1 : iter 
        samples = randsample(n, 2);
        v1 = points(:, samples(1))';
        v2 = points(:, samples(2))';
        errors = zeros(1, n);
        inliers = zeros(1, n);
        for j = 1 : n
          error = point_to_line(points(:, j)', v1, v2);
          errors(j) = error;
        end
        
        for j = 1 : n
            if errors(j) <= thr
                inliers(j) = 1;
            
            else
                inliers(j) = 0;
            end
        end
        
        line = inv([v1(1) 1; v2(1) 1]) * [v1(2) ; v2(2)];
        result = sum(inliers);
        if (result > max_inliers)
            global_line = line;
            max_inliers = result;
            global_inliers = inliers;
        end
    end
    inliers = global_inliers;
    line = global_line;
end

