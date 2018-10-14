function [ H2to1 ] = computeH(p1, p2)
%COMPUTEH Computes the homography between two sets of points
% P1 = H * P2

rows = size(p1, 1);
if size(p2, 1) < rows
    rows = size(p2, 1);
end

A = zeros(2 * rows, 9);
for i = 1 : rows
    x1 = p1(i, 1);
    y1 = p1(i, 2);
    x2 = p2(i, 1);
    y2 = p2(i ,2);
    A(2*i-1, 1) = -x2;
    A(2*i-1, 2) = -y2;
    A(2*i-1, 3) = 1;
    A(2*i-1, 7) = x1 * x2;
    A(2*i-1, 8) = y2 * x1;
    A(2*i-1, 9) = x1;
    A(2*i, 4) = -x2;
    A(2*i, 5) = -y2;
    A(2*i, 6) = -1;
    A(2*i, 7) = x2 * y1;
    A(2*i, 8) = y1 * y2;
    A(2*i, 9) = y1;
end

[~, ~, V] = svd(A);
H = V(:, 9);
H2to1 = reshape(H, 3, 3);
end
