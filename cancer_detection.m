img = imread('cancer.jpg');

Iblur1 = imgaussfilt(img, 2);
Iblur2 = imgaussfilt(img, 4);
IblurX1 = imgaussfilt(img,[1,4]);
IblurY1 = imgaussfilt(img,[4,1]);

sigma = 0.4;
alpha = 0.5;

Ilocal = locallapfilt(img, sigma, alpha);

GreyImg1 = rgb2gray(IblurY1);
GreyImg2 = rgb2gray(Ilocal);

BW1 = imbinarize(GreyImg1, 'adaptive', 'Sensitivity', 0.4);
BW2 = imbinarize(GreyImg2, 'adaptive', 'Sensitivity', 0.4);

morph1 = bwmorph(GreyImg1, 'remove');
morph2 = bwmorph(GreyImg2, 'remove');

comp1 = normxcorr2(GreyImg1,BW1);
ans1 = max(comp1(:));
comp2 = normxcorr2(GreyImg2,BW2);
ans2 = max(comp2(:));

comp3 = normxcorr2(GreyImg1,morph1);
ans3 = max(comp3(:));
comp4 = normxcorr2(GreyImg2,morph2);
ans4 = max(comp4(:));

if comp1 > comp2
    disp("Gaussian is a better filter for thresholding.")
else
    disp("Laplacian is a better filter for thresholding.")
end

if comp3 > comp4
    dis("Gaussian is a better filter for morpholocal transformation.")
else
    disp("Laplacian is a better filter for morpholocal transformation.")
end

figure
subplot(1,3,1), imshow(img), title('original before gauss filter')
subplot(1,3,2), imshow(IblurX1), title('Smoothed image, \sigma_x = 1, \sigma_y = 4')
subplot(1,3,3), imshow(IblurY1), title('Smoothed image, \sigma_x = 4, \sigma_y = 1')

figure
subplot(1,2,1), imshow(img), title('Original image before lap filter')
subplot(1,2,2), imshow(Ilocal), title('Smoothed image, Laplacian filter')

figure
subplot(1,3,1), imshow(img), title('Original image before binarization')
subplot(1,3,2), imshow(BW1), title('Binary Image 1')
subplot(1,3,3), imshow(BW2), title('Binary Image 2')

figure
imshowpair(BW1, BW2, 'diff')

figure
imshowpair(morph1, morph2, 'diff')