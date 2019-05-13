clc;
clear all;
close all;

BW = imread('objek.tif');
figure
imshow(BW);
x = im2bw(BW);
s  = regionprops(x,'Orientation','Area','Image');

stop = size(s,[1]);

for c = 1:stop
    if s(c).Orientation < -45 || s(c).Orientation > 45
        'vertical'
    elseif s(c).Orientation > -45 || s(c).Orientation < 45
        'horizontal'
    end
end