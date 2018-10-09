function [im1] = myImageFilter(im0, h)
% filter constants
[h_row, h_col] = size(h);
M = floor(h_row/2);
N = floor(h_col/2);
h = double(h);

% image constants
[im_row, im_col] = size(im0);
im0 = double(im0);

% % intermediate image (original image + padding)
% w_row = im_row + 2 * M;
% w_col = im_col + 2 * N;
% im_pad = zeros(w_row, w_col);

% fill orignal image to padding image
% im_pad(M+1 : w_row-M, N+1 : w_col-N) = im0;

% % mirror top edge
% im_pad(1:M, N+1 : w_col-N) = flip(im0(1:M, :), 1);
% % mirror right edge
% im_pad(M+1 : w_row-M, w_col-N+1 : end) = flip(im0(: , im_col-N+1 : end), 2);
% % mirror bottom edge
% im_pad(w_row-M+1 : end, N+1 : w_col-N) = flip(im0(im_row-M+1:end, :), 1);
% % mirror left edge
% im_pad(M+1 : w_row-M, 1 : N) = flip(im0(:, 1 : N), 2);
% 
% % mirror top-left corner
% im_pad(1 : M, 1 : N) = flip(im_pad(1 : M, N+1: 2*N), 2);
% % mirror top-right corner
% im_pad(1 : M, w_col-N+1 : end) = flip(im_pad(1:M, w_col-2*N+1 : w_col-N),2);
% % mirror bottom-right corner
% im_pad(w_row-M+1 : end, w_col-N+1 : end) = flip(im_pad(w_row-M+1 : end, w_col-2*N+1 : w_col-N), 2);
% % mirror bottom-left corner
% im_pad(w_row-M+1 : end, 1 : N) = flip(im_pad(w_row-M+1 : end, N+1: 2*N), 2);

% pad array
im_pad = padarray(im0, [M, N], 'replicate', 'both');

% convolution
im1 = zeros(im_row, im_col);
for r = M+1 : M+im_row
    for c = N+1 : N+im_col
        value = 0;
        for k = -M:M
            for l = -N:N
                value = value + h(k+M+1, l+N+1) * im_pad(r-k, c-l);
            end
        end
        im1(r-M, c-N) = value;
    end
end
