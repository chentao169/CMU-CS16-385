function [H2to1] = computeH_norm(x1, x2)

rows = size(x1, 1);
%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid
tmp_x1 = x1 - centroid1;
tmp_x2 = x2 - centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
maxDis_x1 = max(tmp_x1(:, 1).*tmp_x1(:, 1) + tmp_x1(:, 2).*tmp_x1(:, 2), [], 'all');
maxDis_x2 = max(tmp_x2(:, 1).*tmp_x2(:, 1) + tmp_x2(:, 2).*tmp_x2(:, 2), [], 'all');
norm_x1 = 2/maxDis_x1 * tmp_x1;
norm_x2 = 2/maxDis_x2 * tmp_x2;

%% similarity transform 1
homo_x1 = zeros(3, rows);
homo_x1(1:2, :) = x1';
homo_x1(3, :) = ones(1, rows);

homo_norm_x1 = zeros(3, rows);
homo_norm_x1(1:2, :) = norm_x1';
homo_norm_x1(3, :) = ones(1, rows);

T1 = homo_norm_x1 * homo_x1' * inv(homo_x1 * homo_x1');

%% similarity transform 2
homo_x2 = zeros(3, rows);
homo_x2(1:2, :) = x2';
homo_x2(3, :) = ones(1, rows);
homo_norm_x2 = zeros(3, size(norm_x2, 1));
homo_norm_x2(1:2, :) = norm_x2';
homo_norm_x2(3, :) = ones(1, rows);

T2 = homo_norm_x2 * homo_x2' * inv(homo_x2 * homo_x2');

%% Compute Homography
H = computeH(norm_x1, norm_x2);

%% Denormalization
H2to1 = inv(T1) * H * T2;
