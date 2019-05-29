data_path = "../data";
Iin = imread(data_path + "/taj1r.png");
Iref = imread(data_path + "/taj2r.png");
save_path = "../result";

p1 = [1044 1046 1404 1069 714; 164 218 420 811 530];
p2 = [481 476 784 436 49; 149 204 454 808 482];

A = [];


for i = 1 : 5 
    x = p1(1, i);
    y = p1(2, i);
    xp = p2(1, i);
    yp = p2(2, i);
    A = [A; x y 1 0 0 0 -xp * x -xp * y -xp];
    A = [A; 0 0 0 x y 1 -yp * x -yp * y -yp];
end

newA = A' * A;
[~, ~, V] = svd(newA);
[~, w] = size(V);
t = V(:, w);
H = reshape(t, [3, 3]);
H = H'; 

[Iwarp, Imerge] = warpImage(Iin, Iref, H);

imwrite(Iwarp, save_path + "/taj1r_warped.png");
imwrite(Imerge, save_path + "/taj_merged.png");

