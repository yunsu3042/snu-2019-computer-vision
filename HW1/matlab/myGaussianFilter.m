function [G] = myGaussianFilter(I, sigma)
    kernel_size = 4 * floor(3 * sigma) + 1;
    if kernel_size < 3 
        kernel_size = 3;
    end
    kernel_radius = floor(kernel_size / 2);
    
    constant = 1/(sqrt(2*pi)*sigma);
    kernel = zeros(1, kernel_size);
    for i = -kernel_radius : kernel_radius
        value = constant * exp(- i^2/(2 * sigma^2));
        kernel(kernel_radius + i + 1) = value;
    end
    
    kernel = kernel' * kernel;
    G = myImageFilter(I, kernel);
end