function [C] = my_padarray(I, pad_size)
    pad_h = pad_size(1);
    pad_w = pad_size(2);
    [I_h, I_w] = size(I);
    h = I_h + pad_h * 2;
    w = I_w + pad_w * 2;
    C = zeros(h, w);
    
    for i = 1 : I_h
        for j = 1 :I_w 
            C(pad_h + i, pad_w + j) = I(i, j);
        end
    end    
end