function [I]=myImageFilter(I, kernel)
    [h, w] = size(I);
    [kernel_h, kernel_w] = size(kernel);
    pad_hsize = floor(kernel_h / 2);
    pad_wsize = floor(kernel_w / 2);

    padding = my_padarray(I, [pad_hsize, pad_wsize]);
    
    for move = 1 : w
        for pad = 0 : pad_hsize 
          padding(1 + pad, move + pad_wsize) = I(1, move);
          padding(h + pad_hsize * 2 - pad, move + pad_wsize) = I(h, move);
        end
    end
    
    for move = 1 : h
        for pad = 0 : pad_wsize 
            padding(move + pad_hsize, 1 + pad) = I(move, 1);
            padding(move + pad_hsize, w + pad_wsize * 2 - pad) = I(move, w);
        end
    end
    

    for i = 1 : pad_hsize
        for j = 1 : pad_wsize
            padding(i, j) = I(1,1);
            padding(h + pad_hsize + i, j) = I(h, 1);
            padding(h + pad_hsize + i, w + pad_wsize + j) = I(h, w);
            padding(i, w + pad_wsize + j) = I(1, w);
        end
    end
    
    % convolution %
    for base_row = 1 : h
        for base_col = 1 : w
            sum = 0;
            for i = 1 : kernel_h
                for j = 1 : kernel_w
                    sum = sum + padding(base_row + i - 1, base_col + j - 1) * kernel(i, j);
                end
            end
            I(base_row, base_col) = sum;
        end
    end
    
end
























