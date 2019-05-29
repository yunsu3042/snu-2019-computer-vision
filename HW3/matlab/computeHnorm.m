function [H] = computeHnorm(p1, p2) 
    [~, n] = size(p1);
    origin_p2 = p2;
    ax = p1(1, :);
    ay = p1(2, :);
    mx = mean(ax);
    my = mean(ay);
    ax = ax - mx;
    ay = ay - my;
    scale_x = 1/max(ax);
    scale_y = 1/max(ay);
    norm_p = [scale_x 0 -scale_x*mx; 0 scale_y -scale_y*my; 0 0 1];
    
    p1 = norm_p * [p1; ones(1, n)];
    
    ax2 = p2(1, :);
    ay2 = p2(2, :);
    mx2 = mean(ax2);
    my2 = mean(ay2);
    ax2 = ax2 - mx2;
    ay2 = ay2 - my2;
    scale_x2 = 1/max(ax2);
    scale_y2 = 1/max(ay2);
    
    norm_p2 = [scale_x2 0 -scale_x2*mx2; 0 scale_y2 -scale_y2*my2; 0 0 1];
    p2 = norm_p2 * [p2; ones(1, n)];
    
    A = [];
    for i = 1 : n
        x = p2(1, i);
        y = p2(2, i);
        xp = p1(1, i);
        yp = p1(2, i);
        A = [A; x y 1 0 0 0 -xp * x -xp * y -xp];
        A = [A; 0 0 0 x y 1 -yp * x -yp * y -yp];
    end
    
    newA = A' * A;
    [~, ~, V] = svd(newA);
    [~, w] = size(V);
    H_norm = V(:, w);
    H_norm = reshape(H_norm, [3, 3]);
    H_norm = H_norm';
%     
    x = H_norm * p2(:, 2);
    H_norm = H_norm ./ x(3);
    
    H = inv(norm_p) * H_norm * norm_p2;
    x = H * [origin_p2(:, 2)' 1]';
    H = H ./ x(3);    
end