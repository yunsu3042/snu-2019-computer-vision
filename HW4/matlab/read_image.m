
function img = read_image(fileName)
% read a new image, convert to double, convert to greyscale
    img = imread(fileName);
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end

    img = double(img) / 255;
    return;
end