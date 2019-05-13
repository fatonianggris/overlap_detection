
I = imread('overlapping_rekap/16_L_16.jpg')

if (~isdeployed)
    addpath('meanshift_edison_matlab_interface/');
end

hs = 9;
hr = 10;
M = 11;
[S L] = msseg(I,hs,hr,M);
% figure, imshow(S);
% imshow(I);
% tes = [evalin('base', 'fileinput')];
% tes = regexp(tes, '[.]', 'split');
% % program_folder = pwd
% tes2 = strcat(pwd,'\Data ROI\MS\');
% tes2 = strcat(tes2,tes{1});
% assignin('base', 'tes', tes2);
% tes2 = strcat(tes2, '_segm.png');
% S = imread(tes2);
% figure, imshow(L);

Lbaru = padarray(L, [1 1], 'replicate', 'both');
A = ones(size(Lbaru));

for (i=2:(size(Lbaru,1)-1))
    for (j=2:(size(Lbaru,2)-1))
            % kanan
            if (Lbaru(i,j) ~= Lbaru(i,j+1))
                A(i,j) = 0;
            end
            if (Lbaru(i,j) ~= Lbaru(i+1,j))
                A(i,j) = 0;
            end
            % kanan bawah
            if (Lbaru(i,j) ~= Lbaru(i+1,j+1))
                A(i,j) = 0;
            end
    end
end

A = A(((2:(size(Lbaru,1)-1))), ((2:(size(Lbaru,2)-1))));
% figure, imshow(A);

I = im2single(I);
imreg = ones(size(I));
for (i=1:(size(A,1)))
    for (j=1:(size(A,2)))
        if (A(i,j) == 0)
            imreg(i,j,:) = 1;
        else imreg(i,j,:) = I(i,j,:);
        end
    end
end
        
assignin('base', 'L', L);

% imshow(imreg);
