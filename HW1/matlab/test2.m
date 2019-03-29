datadir     = '../data';    %the directory containing the images
resultsdir  = '../tests'; %the directory for dumping results

%parameters
sigma1 = 1;
sigma2 = 2;

sigma = 1;
highThreshold = 1.0;
lowThreshold = 0.0;
%end of parameters

imglist = dir(sprintf('%s/*.jpg', datadir));

%read in images%
[path imgname dummy] = fileparts(imglist(9).name);
img = imread(sprintf('%s/%s', datadir, imglist(9).name));

if (ndims(img) == 3)
    img = rgb2gray(img);
end

img = double(img) / 255;

% Laplacian
Il = myLaplacianFilter(img);

% Differential of Gaussian
Ig1 = myGaussianFilter(img, sigma1);
Ig2 = myGaussianFilter(img, sigma2);
Idg = Ig2 - Ig1;

% Canny Edge Detector
% 1. Smoothing
Ig = myGaussianFilter(img, sigma);
% 2.1 Find x, y lines 
[Ix, Iy] = mySobelXYFilter(Ig, sigma);
% 2. Find gradient magnitude and direction
[Im, Io] = mySobelFilter(Ig, sigma);
% 3. Run non-maximum suppressio
In = myNonMaximumSuppression(Im, Io);




% % 4. Double thresholding
% highThreshold = 1.0;
% lowThreshold = 0.0;
% Iedge1 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.3f.png', resultsdir, imgname, highThreshold, lowThreshold);
% imwrite(Iedge1, fname);
% highThreshold = 0.75;
% lowThreshold = 0.;
% Iedge2 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold );
% imwrite(Iedge2, fname);
% highThreshold = 0.5;
% lowThreshold = 0.0;
% Iedge3 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir,imgname, highThreshold, lowThreshold );
% imwrite(Iedge3, fname);
% highThreshold = 0.25;
% lowThreshold = 0.0;
% Iedge4 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold);
% imwrite(Iedge4, fname);
% highThreshold = 0.1;
% lowThreshold = 0.0;
% Iedge5 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold);
% imwrite(Iedge5, fname);
% 
% 
% highThreshold = 0.7;
% lowThreshold = 0.7;
% Iedge1 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold );
% imwrite(Iedge1, fname);
% highThreshold = 0.7;
% lowThreshold = 0.5;
% Iedge2 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold , lowThreshold);
% imwrite(Iedge2, fname);
% highThreshold = 0.7;
% lowThreshold = 0.3;
% Iedge3 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold);
% imwrite(Iedge3, fname);
% highThreshold = 0.7;
% lowThreshold = 0.1;
% Iedge4 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold);
% imwrite(Iedge4, fname);
% highThreshold = 0.3;
% lowThreshold = 0.2;
% Iedge5 = myDoubleThresholding(In, highThreshold, lowThreshold);
% fname = sprintf('%s/%s_03Canny_%.2f_%.2f.png', resultsdir, imgname, highThreshold, lowThreshold);
% imwrite(Iedge5, fname);



%everything below here just saves the outputs to files%
fname = sprintf('%s/%s_00Origin.png', resultsdir, imgname);
imwrite(img, fname);
fname = sprintf('%s/%s_01Laplacian.png', resultsdir, imgname);
imwrite((Il - min(Il(:))) ./ (max(Il(:)) - min(Il(:))), fname);
fname = sprintf('%s/%s_02DoG.png', resultsdir, imgname);
imwrite((Idg - min(Idg(:))) ./ (max(Idg(:)) - min(Idg(:))), fname);
fname = sprintf('%s/%s_03Sobel_Im.png', resultsdir, imgname);
imwrite((Im - min(Im(:))) ./ (max(Im(:)) - min(Im(:))), fname);
fname = sprintf('%s/%s_03Sobel_Io.png', resultsdir, imgname);
imwrite((Io - min(Io(:))) ./ (max(Io(:)) - min(Io(:))), fname);
fname = sprintf('%s/%s_04Sobel_Ix.png', resultsdir, imgname);
imwrite((Ix - min(Ix(:))) ./ (max(Ix(:)) - min(Ix(:))), fname);
fname = sprintf('%s/%s_05Sobel_Iy.png', resultsdir, imgname);
imwrite((Iy - min(Iy(:))) ./ (max(Iy(:)) - min(Iy(:))), fname);
fname = sprintf('%s/%s_05NonMaximum.png', resultsdir, imgname);
imwrite(In, fname);


    