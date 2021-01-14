clear;
close all;
clc;
% 1) read image
Im = imread('cameraman.tif');
% 2) display image
figure,
imshow(Im);
imwrite(Im,'Original_Image256x256.bmp')
% 3) subsample and display
Im2 = imageSubSample(Im, 2);
figure, imshow(Im2);
imwrite(Im2,'Downsampled_Image128x128.bmp')
% 4) Blurring mask
P = 7;
X=-(P-1)/2:(P-1)/2;
X = X;
mu = 0;
sigma = 0.8;
Y = normpdf(X,mu,sigma);
figure,plot(Y);
M = Y'*Y;
M = M / sum(sum(M));

% 5) Blurring using conv2
Im3 = conv2(single(Im2),M,'same');
Im3 = uint8(Im3);
figure,imshow(Im3);
imwrite(Im3,'Smoothed_Image256x256_Conv.bmp');

% 7) Blurring usg g = H * f
[r,c] = size(Im2);
f=double(reshape(Im2,[r*c, 1]));
f 
H = zeros(r*c,r*c);

for i=1:r
for j=1:c
for p=-int16((P-1)/2):int16((P-1)/2)
for q=-int16((P-1)/2):int16((P-1)/2)
    x=(i-1)*c+j;
    y=(i+p-1)*c+j+q;
    %if(x>=1 && x <= 128^2 && y>=1 && y <= 128^2)
    if((i+p)>=1 && (i+p) <= r && (j+q)>=1 && (j+q) <= c)
     H(x,y)=M(1+p+int16((P-1)/2),1+q+int16((P-1)/2));
    end
end
end
end
end

 g = H * f;
 Im4 = uint8(reshape(g,[r,c]));
 figure, imshow((Im4-Im3)*3);
 figure, imshow((Im4));
 imwrite(Im4,'Smoothed_Image256x256_H_mat.bmp');
 imwrite(Im4-Im3,'Difference_Image128x128.bmp');


 %8) normalize rows
 for i=1:r*c
     H(i,:) = H(i,:)/sum(H(i,:));
 end
 g = H * f;
 Im5 = uint8(reshape(g,[r,c]));
 figure, imshow((Im5));
 imwrite(Im5,'Smoothed_Image128x128_H_mat_normalized.bmp');