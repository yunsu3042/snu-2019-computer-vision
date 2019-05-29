function [startPos, finishPos] = getTemplateSize(img, mask) 
    [h, w] = size(img);
    first = 1;
    for i = 1: h 
        for j = 1 : w
            if mask(i, j) == 1
                if first == 1
                    startPos = [i, j];
                    first = 0;
                else
                    finishPos = [i + 1, j + 1];
                end
            end
        end
    end
    
%    T_size = finishPos - startPos;
%    Th = T_size(1);
%    Tw = T_size(2);
end
