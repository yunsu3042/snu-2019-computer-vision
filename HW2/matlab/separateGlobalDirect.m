function [globalImg directImg] = separateGlobalDirect(dirname)
    imglist = dir(sprintf('%s/*.png', dirname));
    [n, ~] = size(imglist);
    img = imread(sprintf("%s/%s", dirname, imglist(1).name));
    [h, w, c] = size(img);
    minImg = img;
    maxImg = img;
    
    for idx = 1 : n
        img = imread(sprintf("%s/%s", dirname, imglist(idx).name));
        for i = 1 : h
            for j = 1 : w
                for z = 1 : c
                    if minImg(i, j, z) > img(i, j, z)
                        minImg(i, j, z) = img(i, j, z);
                    end
                    if maxImg(i, j, z) < img(i, j, z)
                        maxImg(i, j, z) = img(i, j, z);
                    end
                end
            end
        end
    end
    globalImg = 2 * minImg;
    directImg = maxImg - minImg;
end