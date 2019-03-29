function [Im, Io] = mySobelFilter (I)
    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = [1 2 1; 0 0 0 ; -1 -2 -1];
    Ix = myImageFilter(I, sobel_x);
    Iy = myImageFilter(I, sobel_y);
    
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Im = sqrt(Ix2 + Iy2);
    Io = atan(Ix./Iy);  
    Io(Io == Inf) = pi/2;
    Io(isnan(Io)) = 0;
end