function [H, result] = rectify(Img, p1, p2) 
    [h, w, ~] = size(Img);
    [~, n] = size(p1);
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
    [~, k] = size(V);
    t = V(:, k);
    H = reshape(t, [3, 3]);
    H = H'; 

    H_inv = inv(H);

    result = zeros(h,w,3);
    for y = 1 : h
        for x = 1 : w
            v = H_inv * [x y 1]';
            posx = v(1) ./ v(3);
            posy = v(2) ./ v(3);

            i = floor(posx);
            j = ceil(posy);

            a = posx - i;
            b = j - posy; 
            pixel = uint8([0, 0, 0]);
            flag = 0;
            if (0 < i) && (i <= w) && (0 < j) && (j <= h) 
                pixel = pixel + reshape((1 - a) *(1 - b) * Img(j, i, 1:3), [1, 3]); 
                flag = 1;
            end
            if (0 < i + 1) && (i + 1 <= w) && (0 < j) && (j <= h)
                pixel = pixel + reshape(b * (1 - a) * Img(j, i + 1, 1:3), [1, 3]);
                flag = 1;
            end
            if  (0 < i + 1) && (i + 1 <= w) && (0 < j + 1) && (j + 1 <= h)
                pixel = pixel + reshape(a * b * Img(j + 1, i + 1, 1:3), [1, 3]);
                flag = 1;
            end
            if (0 < i) && (i <= w) && (0 < j + 1) && (j + 1 <= h)
                pixel = pixel + reshape((1 - b) * a * Img(j + 1, i, 1:3), [1, 3]);
                flag = 1;
            end        
            if flag == 0
                result(y, x, :) = uint8([255 255 255]);
            else
                result(y, x, :) = pixel;
            end
            
        end
    end
    result = uint8(result);
    
end