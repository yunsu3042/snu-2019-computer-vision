function [possible] = in_box(i, j, h, w)
    if (i >= 1) && (i <= h) && (j >= 1) && (j <= w)
        possible = 1;
    else
        possible = 0;
    end
end