% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
im = imread('../data/cv_cover.jpg');
if size(im, 3) == 3
    im = rgb2gray(im);
end

%% Compute the features and descriptors
features = detectFASTFeatures(im);
[desc, loc] = computeBrief(im, features.Location);

histogram = zeros(35);
for i = 1:35
    %% Rotate image
    tmp_im = imrotate(im, i * 10);
    %% Compute features and descriptors
    tmp_features = detectFASTFeatures(tmp_im);
    [tmp_desc, ~] = computeBrief(tmp_im, tmp_features.Location);
    %% Match features
    indexPairs = matchFeatures(desc, tmp_desc, 'matchthreshold', 60);
    %% Update histogram
    histogram(i) = size(indexPairs, 1);
end

%% Display histogram
figure; 
subplot(2, 2, 1);
% plot(10:10:350, histogram);


%% visualize 10 degree rotation

features = detectSURFFeatures(im);
[desc, loc] = extractFeatures(im, features);

tmp_im = imrotate(im, 10);
% tmp_features = detectFASTFeatures(tmp_im);
% [tmp_desc, tmp_loc] = computeBrief(tmp_im, tmp_features.Location);
% indexPairs = matchFeatures(desc, tmp_desc, 'matchthreshold', 60);

tmp_features = detectSURFFeatures(tmp_im);
[tmp_desc, tmp_loc] = extractFeatures(tmp_im, tmp_features);
indexPairs = matchFeatures(desc, tmp_desc); 

locs1 = loc(indexPairs(:, 1), :);
locs2 = tmp_loc(indexPairs(:, 2), :);
subplot(2, 2, 2);
showMatchedFeatures(im, tmp_im, locs1, locs2, 'montage');
legend('matched points 1','matched points 2');
title('rotate 10 degree');

%% visualize 90 degree rotation
tmp_im = imrotate(im, 90);
% tmp_features = detectFASTFeatures(tmp_im);
% [tmp_desc, tmp_loc] = computeBrief(tmp_im, tmp_features.Location);
% indexPairs = matchFeatures(desc, tmp_desc, 'matchthreshold', 60);

tmp_features = detectSURFFeatures(tmp_im);
[tmp_desc, tmp_loc] = extractFeatures(tmp_im, tmp_features);
indexPairs = matchFeatures(desc, tmp_desc); 

locs1 = loc(indexPairs(:, 1), :);
locs2 = tmp_loc(indexPairs(:, 2), :);
subplot(2, 2, 3);
showMatchedFeatures(im, tmp_im, locs1, locs2, 'montage');
legend('matched points 1','matched points 2');
title('rotate 90 degree');

%% visualize 340 degree rotation
tmp_im = imrotate(im, 340);
% tmp_features = detectFASTFeatures(tmp_im);
% [tmp_desc, tmp_loc] = computeBrief(tmp_im, tmp_features.Location);
% indexPairs = matchFeatures(desc, tmp_desc, 'matchthreshold', 60);

tmp_features = detectSURFFeatures(tmp_im);
[tmp_desc, tmp_loc] = extractFeatures(tmp_im, tmp_features);
indexPairs = matchFeatures(desc, tmp_desc); 

locs1 = loc(indexPairs(:, 1), :);
locs2 = tmp_loc(indexPairs(:, 2), :);
subplot(2, 2, 4);
showMatchedFeatures(im, tmp_im, locs1, locs2, 'montage');
legend('matched points 1','matched points 2');
title('rotate 340 degree');