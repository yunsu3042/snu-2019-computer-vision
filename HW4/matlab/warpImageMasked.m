function [warped] = warpImageMasked(img, mask, W)
[h, w] = size(mask);

% img = img .* mask; 
warped = warpImage(img,W);

for i = 1 : h 
    for j = 1 : w 
        if mask(i, j) ~= 1
            warped(i, j) = 0;
        end
    end
end


end
