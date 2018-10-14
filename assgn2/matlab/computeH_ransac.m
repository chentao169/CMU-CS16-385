function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

pairs = size(locs1, 1);
max_count = 0;
bestH2to1 = zeros(3, 3);
inliers = zeros(1, pairs);

for i = 1:pairs
    % randomly choose 5 points
    index = randperm(pairs, 5);
    
    % compute H
    p1 = locs1(index, :);
    p2 = locs2(index, :);
    H = computeH_norm(p1, p2);
    
    % count inliers
    count = 0;
    flag_inliers = zeros(1, pairs);
    for j = 1 : pairs
        x1 = locs1(j, :);
        homo_x1 = zeros(3, 1);
        homo_x1(1:2, :) = x1';
        homo_x1(3, 1) = 1;
        
        x2 = locs2(j, :);
        homo_x2 = zeros(3, 1);
        homo_x2(1:2, :) = x2';
        homo_x2(3, 1) = 1;
        
        gauss_x1 = H * homo_x2;
        if isequal(gauss_x1, homo_x1)
            count = count + 1;
            flag_inliers(j) = 1;
        end
    end
    
    % update bestH2to1
    if count > max_count
        bestH2to1 = H;
        inliers = flag_inliers;
    end
    
    if count == pairs
        break
    end
end

