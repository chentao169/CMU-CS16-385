function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% initialize 
[row, col] = size(Im);
max_rho = (row^2 + col^2)^0.5;
rho_len = int32(ceil(max_rho/rhoRes) +1);
theta_len = int32(ceil(2*pi/thetaRes + 1));

H = zeros(rho_len, theta_len);
rhoScale = 0 : rhoRes : rho_len * rhoRes;
rhoScale = double(rhoScale);
thetaScale = 0 : thetaRes : 2*pi;

for x = 1:row 
    for y = 1:col
        if Im(x,y) >= threshold
            for j = 1 : theta_len
                theta = thetaScale(j);
                p = x * cos(theta) + y * sin(theta);
                if p >=0
                    low = floor(p/rhoRes);
                    high = ceil(p/rhoRes);
                    if p - low * rhoRes  <= high * rhoRes - p
                        i = low;
                    else
                        i = high;
                    end
                    
                    i = i+1; % index starts with 1
                    H(i, j) = H(i, j)+1;
                end
            end
        end
    end
end

end
        
        