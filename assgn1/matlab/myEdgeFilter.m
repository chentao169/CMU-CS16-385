function [img1] = myEdgeFilter(img0, sigma)
%Your implemention
hsize = 2*ceil(3*sigma)+1;
filter = fspecial('gaussian', hsize, sigma);
im1 = myImageFilter(img0, filter);

% x-axis gradient
sobel = [-0.5 0 0.5];
imgx = myImageFilter(im1, sobel);
% y-axis gradient
imgy = myImageFilter(im1, sobel');

% image gradient magnitude
[row, col] = size(img0);
imgm = zeros(row, col);
for r = 1:row
    for c = 1:col
        imgm(r, c) = (imgx(r,c)^2 + imgy(r,c)^2)^0.5;
    end
end

% non-max suppression
img1 = imgm;
for r = 2 : row-1
    for c = 2 : col-1
        x = imgx(r, c);
        y = imgy(r, c);
        de = gradDir(x, y);
        switch de
            case 0
                img1(r, c) = cmp(imgm(r, c-1), imgm(r, c), imgm(r, c+1));
            case pi/4
                img1(r, c) = cmp(imgm(r-1, c+1), imgm(r, c), imgm(r+1, c-1));
            case pi/2
                img1(r, c) = cmp(imgm(r-1, c), imgm(r, c), imgm(r+1, c));
            case 3*pi/4
                img1(r, c) = cmp(imgm(r-1, c-1), imgm(r, c), imgm(r+1, c+1));
        end
    end
end
 

function de = gradDir(x, y)
    degree = atan(y/x);
    if -pi/2 <= degree < -3*pi/8
        de = pi/2;
    elseif -3*pi/8 <= degree < -pi/8
        de = 3*pi/4;
    elseif -pi/8 <= degree < pi/8
        de = 0;
    elseif pi/8 <= degree < 3*pi/8
        de = pi/4;
    elseif 3*pi/8 <= degree <= pi/2
        de = pi/2;
    end
end

function val = cmp(n1, cent, n2)
    if n1 > cent || n2 > cent
        val = 0;
    else
        val = cent;
    end
end

                
end
    
                
        
        
