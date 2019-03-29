function [Ix, Iy] = mySobelFilter (I, sigma)
    G = myGaussianFilter(I, sigma);
    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [1 2 1; 0 0 0 ; -1 -2 -1];
    Ix = myImageFilter(G, sobel_x);
    Iy = myImageFilter(G, sobel_y);
end