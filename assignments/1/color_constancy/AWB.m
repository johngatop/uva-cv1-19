function [] = AWB(img_name)

// read the image
I = imread(img_name);
// get the values for the color channels
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

// get means of color channels
Rm = mean(R(:));
Gm = mean(G(:));
Bm = mean(B(:));

// generate the corrected grayworld 128 part
r = 128/Rm;
g = 128/Gm;
b = 128/Bm;

// initialize the "corrected" image with zeros
[w, h, channels] = size(I);
Ic = zeros(w, h, channels);

// now we can do the correction
// by multiplying the values
// maybe this can be vectorized
Ic(:,:,1) = I(:,:,1) * r;
Ic(:,:,2) = I(:,:,2) * g;
Ic(:,:,3) = I(:,:,3) * b;

// and show the figure
figure 
subplot(1,2,1)
orignal = imshow(I)
title('Original picture')
subplot(1,2,2)
modified = imshow(Ic);
title('Modified to be color constant')

end;

