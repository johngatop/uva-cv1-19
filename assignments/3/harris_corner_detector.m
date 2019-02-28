function [H, r, c] = harris_corner_detector(I)
%   Harris_corner_detector 
%
%   RETURNS: Harris matrix H, the rows of the detected corner points r, 
%   and the columns of those points c

% Parameters
radius = 2;
sigma = 1; 
threshold = 100000000 ; % 50100000 for I; 330000000 for J % 200000000
n = 2*radius + 1;

% Make I grayscale if it is now already
J = I;
[~, ~, c] = size(I);
if c ~= 1
    I = rgb2gray(I);
end

% Make it double, because we will perform computations
I = double(I);

% Sobel filters - First order Gaussian derivative
Ix = fspecial('sobel')';
Iy = fspecial('sobel');

% Convolving the Ix and Iy with the image
Ix = imfilter(I, Ix);
Iy = imfilter(I, Iy);
Jx = imfilter(J, Ix);
Jy = imfilter(J, Iy);


% Gaussian filter
G = fspecial('gaussian', max(1, fix(6*sigma)), sigma);

% Convolving with G to compute the elements of Q
A = imfilter(Ix.^2, G);
C = imfilter(Iy.^2, G);
B = imfilter(Ix.*Iy,G);

% Cornerness H(x,y) (Harris measure)
H = (A.*C - B.^2) - 0.04.*(A + C).^2;

% n: nxn window of neighbours
[h, w, ~] = size(H);

% the points where they indicate corner if = 1, otherwise = 0
harris_points = zeros(h, w);

% Depenting on the filter size, scann the hole image to find points that
% are greater than (i) all its neighbours (ii) the threshold. 
% Then it is a harris point
for i = (n+1)/2 : h-n+1
    for j = (n+1)/2 : w-n+1         
        mx = max(max(H( i-(n-1)/2 : i+(n-1)/2, j-(n-1)/2 : j+(n-1)/2)));
        if (mx == H(i,j)) && (H(i,j)>threshold)
            harris_points(i,j) = 1;
        end
    end
end

% get rows and columns, flattened 
[r, c] = find(harris_points);

% Plot images
figure;
imshow(J), hold on, plot(c, r, 'ys');
% subplot(1, 3, 1), imshow(J), hold on, plot(c, r, 'ys');
% subplot(1, 3, 2), imshow(Ix), xlabel('I_x');
% subplot(1, 3, 3), imshow(Iy), xlabel('I_y');

end

