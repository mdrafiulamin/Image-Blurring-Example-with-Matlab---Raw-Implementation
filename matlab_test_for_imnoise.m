% 4) Matlab test program to test property of imnoise function
clear;

I = uint8(10*ones(128,128));
m = -0.1;
var_gauss = 0.000000;
J = imnoise(I,'gaussian',m,var_gauss);
imshow(J)
J