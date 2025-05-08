b clc; clear; close all;

% Read input image
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif'}, 'Select an Image');
if isequal(filename, 0)
    disp('User canceled the operation.');
    return;
end
img = imread(fullfile(pathname, filename));

% Check image type and size
disp(['Original Image Class: ', class(img)]);
disp(['Original Image Size: ', mat2str(size(img))]);

% Convert to grayscale if the image is RGB
if size(img, 3) == 3
    grayImg = rgb2gray(img);
else
    grayImg = img; % Already grayscale
end

% Convert grayscale image to double if needed
if ~isa(grayImg, 'double')
    grayImg = im2double(grayImg);
end

% Check final image type before edge detection
disp(['Processed Image Class: ', class(grayImg)]);
disp(['Processed Image Size: ', mat2str(size(grayImg))]);

% Perform edge detection
try
    edges = edge(grayImg, 'Canny');
catch ME
    disp('Error in edge detection:');
    disp(ME.message);
    return;
end

% Create a dotted effect by downsampling the edge pixels
[dottedRows, dottedCols] = find(edges);
dotSpacing = 1; % Adjust spacing between dots

% Create a white background image
dottedImg = ones(size(edges)) * 255; % White background

% Select points with spacing and set them as black dots
for i = 1:dotSpacing:length(dottedRows)
    dottedImg(dottedRows(i), dottedCols(i)) = 0; % Black dots
end

% Convert to uint8
dottedImg = uint8(dottedImg);

% Display results
figure;
subplot(1,2,1);
imshow(img);
title('Original Image');

subplot(1,2,2);
imshow(dottedImg);
title('Dotted Line Image');

% Save the output
imwrite(dottedImg, 'dotted_white_bg.png');
disp('Dotted image saved as dotted_white_bg.png');