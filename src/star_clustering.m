figure;
img = imread('stephans_quintet.jpg');
subplot(3,6,1);
imshow(img);
title('original');

kernel3x3 = fspecial("gaussian", [3 3], 0.5);
img = imfilter(img, kernel3x3);
subplot(3,6,2);
imshow(img);
title('gaussian applied');

img = rgb2hsv(img);
hueChannel = img(:,:,1);
saturationChannel = img(:,:,2);
valueChannel = img(:,:,3);
subplot(3,6,3);
imshow(img);
title('hsv version');
subplot(3,6,4);hueChannel = img(:,:,1);
saturationChannel = img(:,:,2);
imshow(hueChannel);
title('hue channel');
subplot(3,6,5);
imshow(saturationChannel);
title('saturation channel');
subplot(3,6,6);
imshow(valueChannel);
title('value channel');

% seperate the stars (highpass filter)
blurredValueChannel = imgaussfilt(valueChannel, 8);
starsHSV = imsubtract(valueChannel, blurredValueChannel);
subplot(3,6,7);
imshow(blurredValueChannel)
title('blurred value channel')
subplot(3,6,8);
imshow(starsHSV);
title('stars grayscale');

% seperate the dust (lower bandpass filter)
highValueChannel = imgaussfilt(valueChannel, 18);
lowValueChannel = imgaussfilt(valueChannel, 1);
dustHSV = highValueChannel - lowValueChannel;
subplot(3,6,9);
imshow(dustHSV);
title('dust grayscale');

% seperate the galaxies (higher bandpass filter)
highValueChannel = imgaussfilt(valueChannel, 18);
lowValueChannel = imgaussfilt(valueChannel, 100);
galaxyHSV = highValueChannel - lowValueChannel;
subplot(3,6,10);
imshow(galaxyHSV);
title('galaxy grayscale');