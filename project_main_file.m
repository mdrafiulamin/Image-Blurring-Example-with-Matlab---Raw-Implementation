clear;
close all;
clc;
% 1) read image
Im = imread('cameraman.tif');
% 2) display image
figure,
imshow(Im);

% 3) subsample and display
Im2 = imageSubSample(Im, 2);
figure, imshow(Im2);

% 4) Blurring mask
P = 3;
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

% 7) Blurring usg g = H * f
[r,c] = size(Im2);
f=double(reshape(Im2,[r*c, 1]));
f 
H = zeros(r*c,r*c);

for i=0:r
    for j=0:c
        for p=-(P-1)/2:(P-1)/2
            for q=-(P-1)/2:(P-1)/2
                x = (i-1)*c+j+1;
                y = (i+p-1)*c+j+q+1;
                if(y >= 1 && y <= r*c && x >= 1 && x <= r*c)
                    H(x,y)=M(1+p+(P-1)/2,1+q+(P-1)/2);
                end
            end
        end
    end
end

 g = H * f;
 Im4 = uint8(reshape(g,[r,c]));
 figure, imshow((Im4-Im3)*3);
 figure, imshow((Im4));
 
 % 8) normalize rows
 for i=1:r*c
     H(i,:) = H(i,:)/sum(H(i,:));
 end
 g = H * f;
 Im5 = uint8(reshape(g,[r,c]));
 figure, imshow((Im5));