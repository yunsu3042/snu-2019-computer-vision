%path to sphere and object images
dirname1 = '../data/q3/scene1';
dirname2 = '../data/q3/scene2';
[globalImg1, directImg1] = separateGlobalDirect(dirname1);
[globalImg2, directImg2] = separateGlobalDirect(dirname2);

 figure(1);
 imshow(globalImg1);
 title('Scene1 Global Image');
 
 figure(2);
 imshow(directImg1);
 title('Scene1 Direct Image');
 
 figure(3);
 imshow(globalImg2);
 title('Scene2 Global Image');
 
 figure(4);
 imshow(directImg2);
 title('Scene2 Direct Image');