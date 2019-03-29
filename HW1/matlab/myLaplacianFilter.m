function [Iconv] = myLaplacianFilter (I)
    kernel = [1 1 1 ; 1 -8 1 ; 1 1 1];
    Iconv = myImageFilter(I, kernel);
end