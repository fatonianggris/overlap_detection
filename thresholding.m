% clear all;
% clc;
% close all;


I = imread('D:\MAGISTER INFORMATIKA\Computer Vision\BISMILLAH PROJECT AKHIR VISKOM\Coding\overlapping_rekap\16_L_10.jpg');
if size(I,3)==3
    I = rgb2gray(I);
end
I = adapthisteq(I);
x = imhist(I); % buat histogram
figure;
imshow(I)
figure;
% imhist(I)
[m n] = size(x); %ambil nilai size maksimum imhist yaitu 255
% no_z = find(x); %mengambil bin yang non-zero value 

%partisi histrogram menjadi 4
p1 = x(1:64,:);
p2 = x(65:128,:);
p3 = x(129:192,:);
p4 = x(193:255,:);
p34 = x(129:255,:);
% [pixelCounts grayLevels] = imhist(I);
% T = graythresh(uint8(p3));
Th = otsu_func(x);
% a=x(p34,:);
% M = median(a);
% max1=max(a(:));
% min1=min(a(:));
% mn = mean(a);
% addpath('Program/');

% R = morphologiProcess(I,'square',6,Th,'dia')
BW = imbinarize(I,Th);
figure;
imshow(BW)

