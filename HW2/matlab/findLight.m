function [lv] = findLight(img, cx, cy, r)
    [h, w] = size(img);
    brightest = 0;
    for i = 1 : h
        for j = 1 : w
            if img(i, j) > brightest 
                brightest = img(i, j);
                y = i;
                x = j;
            end
        end
    end
    z = sqrt(r^2 - (x - cx)^2 - (y - cy)^2);
    lv = [x - cx, y - cy, z];
    norm_lv = lv / norm(lv);
    lv = norm_lv * double(brightest);
end