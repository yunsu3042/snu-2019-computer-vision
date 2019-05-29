datapath = "../data/";

T = [1, 0, 0; 0 2 0; 0 0 1];
T_inv = inv(T);

img = double(imread(sprintf("%s/toys.jpg", datapath)))/255;

[h, w, c] = size(img);

warp_img = zeros(2 * h, w, c);

for y = 1 : 2 * h
    for x = 1 : w
        X = ([x y 1])';
        A = (T_inv * X)';
        posx = A(1) / A(3);
        posy = A(2) / A(3);
        a = mod(posx, 1);
        b = mod(posy, 1);
        
        i = posy + b;
        j = posx - a;
        A = (1 - a)*(1 - b) * img(i, j, 1:3);
        
        if i + 1 <= h
            A = A + a * (1 - b) * img(i + 1, j, 1:3);
        end
        if (j + 1 <= w) && (i + 1 <= h) 
            A = A + a * b * img(i + 1, j + 1, 1:3);
        end
        if j + 1 <= w
            A = A + (1 - a) * b * img(i, j + 1, 1:3);
        end
        warp_img(y, x, 1:3) = A;
    end
end

