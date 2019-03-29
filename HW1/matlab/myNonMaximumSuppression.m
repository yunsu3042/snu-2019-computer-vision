function [Sharp] = myNonMaximumSuppression (Im, Io)
    Sharp = zeros(size(Io));
    [h, w] = size(Io);
    for i = 2 : h - 1
        for j = 2 : w - 1
            center = Im(i, j);
            theta = Io(i, j);
            [p1, p2] = get_near_position(theta, i, j);
            val1 = Im(p1(1), p1(2));
            val2 = Im(p2(1), p2(2));
            
            if (center > val1) && (center > val2)
                Sharp(i, j) = center;
            else
                Sharp(i, j) = 0;
            end
        end
    end
end

