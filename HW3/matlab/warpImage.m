function [Iwarp, Imerge] = warpImage(Iin, Iref, H) 
    H_inv = inv(H);
    [h, w, ~] = size(Iin);
    [h_ref, w_ref, ~] = size(Iref); 
    
    Iwarp = uint8(Iref);

    for y = 1 : h_ref
        for x = 1 : w_ref
            v = H_inv * [x y 1]';
            posx = v(1) ./ v(3);
            posy = v(2) ./ v(3);

            i = floor(posx);
            j = ceil(posy);

            a = posx - i;
            b = j - posy; 
            pixel = uint8([0, 0, 0]);

            if (0 < i) && (i <= w) && (0 < j) && (j <= h) 
                pixel = pixel + reshape((1 - a) *(1 - b) * Iin(j, i, 1:3), [1, 3]); 
            end
            if (0 < i + 1) && (i + 1 <= w) && (0 < j) && (j <= h)
                pixel = pixel + reshape(b * (1 - a) * Iin(j, i + 1, 1:3), [1, 3]);
            end
            if  (0 < i + 1) && (i + 1 <= w) && (0 < j + 1) && (j + 1 <= h)
                pixel = pixel + reshape(a * b * Iin(j + 1, i + 1, 1:3), [1, 3]);
            end
            if (0 < i) && (i <= w) && (0 < j + 1) && (j + 1 <= h)
                pixel = pixel + reshape((1 - b) * a * Iin(j + 1, i, 1:3), [1, 3]);
            end        
            if pixel == uint8([0 0 0]) 
%                 Iwarp(y, x, :) = Iref(y, x, :);
                Iwarp(y, x, :) = pixel;
            else
                Iwarp(y, x, :) = pixel;
            end
        end
    end
    
    [h_m, w_m, diff] = helper(Iin, Iref, H);

    Imerge = zeros(h_m, w_m, 3);

    for y = 1 : h_m 
        for x = 1 : w_m
            inv_p = [x - diff(2), y - diff(1), 1]';

            v = H_inv * inv_p;
            posx = v(1) ./ v(3);
            posy = v(2) ./ v(3);

            i = floor(posx);
            j = ceil(posy);

            a = posx - i;
            b = j - posy; 
            pixel = uint8([0, 0, 0]);

            if (0 < i) && (i <= w) && (0 < j) && (j <= h) 
                pixel = pixel + reshape((1 - a) *(1 - b) * Iin(j, i, 1:3), [1, 3]); 
            end
            if (0 < i + 1) && (i + 1 <= w) && (0 < j) && (j <= h)
                pixel = pixel + reshape(b * (1 - a) * Iin(j, i + 1, 1:3), [1, 3]);
            end
            if  (0 < i + 1) && (i + 1 <= w) && (0 < j + 1) && (j + 1 <= h)
                pixel = pixel + reshape(a * b * Iin(j + 1, i + 1, 1:3), [1, 3]);
            end
            if (0 < i) && (i <= w) && (0 < j + 1) && (j + 1 <= h)
                pixel = pixel + reshape((1 - b) * a * Iin(j + 1, i, 1:3), [1, 3]);
            end        

            if pixel == uint8([0 0 0]) 
                if (diff(1) + 1 <= y) && (y <= diff(1) + h_ref - 1) && (diff(2) + 1 <= x)
                    Imerge(y, x, :) = uint8(Iref(y - diff(1), x - diff(2), :));
                else
                    Imerge(y, x, :) = uint8([0 0 0]);
                end
            else
                Imerge(y, x, :) = pixel;
            end
        end
    end
    Imerge = uint8(Imerge);
    
end
    

