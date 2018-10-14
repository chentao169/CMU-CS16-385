function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if size(I1, 3) == 3
    I1 = rgb2gray(I1);
end

if size(I2, 3) == 3
    I2 = rgb2gray(I2);
end

%% Detect features in both images
% return cornerPoints object array
p1 = detectFASTFeatures(I1);
p2 = detectFASTFeatures(I2);


%% Obtain descriptors for the computed feature locations
[desc1, lc1] = computeBrief(I1, p1.Location);
[desc2, lc2] = computeBrief(I2, p2.Location);

%% Match features using the descriptors
indexPairs = matchFeatures(desc1, desc2, 'matchthreshold', 60);
locs1 = lc1(indexPairs(:, 1), :);
locs2 = lc2(indexPairs(:, 2), :);

end

