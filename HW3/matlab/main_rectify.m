data_path = "../data";
save_path = "../result";
Img = imread(data_path + "/HTC.png");

p1 = [64 243 243 64; 41 41 381 382];
p2 = [71 230 268 103; 46 54 361 377];

[H, result] = rectify(Img, p1, p2);
imshow(result);
imwrite(result, save_path + "/HTC_rectified.png");