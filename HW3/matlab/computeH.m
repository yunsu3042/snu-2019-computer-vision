function [H] = computeH(p1, p2) 
    [~, n] = size(p1);

    A = [];
    
    for i = 1 : n
       A = [A ; p2(1, i), p2(2, i), 1, 0, 0, 0, -p1(1, i) * p2(1, i), -p1(1, i) * p2(2, i), -p1(1, i)];
       A = [A; 0, 0, 0, p2(1,i), p2(2, i), 1, -p1(2, i) * p2(1, i), - p1(2, i)*p2(2, i), -p1(2, i)];
    end
    
    newA = A' * A;
    [~, ~, V] = svd(newA);
    [~, w] = size(V);
    H = V(:, w);
    H = reshape(H, [3, 3]);
    H = H';
    
    x = H * [p2(:, 2)' 1]';
    H = H ./ x(3);
    
end