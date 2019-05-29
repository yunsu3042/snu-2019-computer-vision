function [cx, cy, r] = findCircle(img, threshold)
    [h, w] = size(img);
    bin_img = zeros(h, w);
    for i = 1 : h
        for j = 1 : w 
            if (img(i, j) >= threshold) 
                bin_img(i, j) = 1;
            else
                bin_img(i, j) = 0;
            end
        end
    end
    upper_h =1;
    for i = 1 : h
        if ismember(1, bin_img(i, :))
            upper_h = i;
            break;
        end
    end
    lower_h = 1;
    for i = h : -1 : 1
        if ismember(1, bin_img(i, :))
            lower_h = i;
            break;
        end
    end
    lower_w = 1;
    for i = 1 : w
        if ismember(1, bin_img(:, i))
            lower_w = i;
            break;
        end
    end
    upper_w = 1;
    for i = w : -1 : 1
        if ismember(1, bin_img(:, i))
            upper_w = i;
            break;
        end
    end
    
    predict_r1 = (lower_h - upper_h) / 2;
    predict_r2 = (upper_w - lower_w) / 2;
    predict_r= floor((predict_r1 + predict_r2)/2);
    Rmin = predict_r - 20;
    Rmax = predict_r + 20;
    [pos, r] = imfindcircles(img,[Rmin Rmax],'ObjectPolarity','bright');
    pos = round(pos);
    cx = pos(1);
    cy = pos(2);
    r = round(r);
end