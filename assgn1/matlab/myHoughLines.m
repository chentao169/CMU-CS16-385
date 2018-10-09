function [rhos, thetas] = myHoughLines(H, nlines)
mask = imregionalmax(H);
sup_H = H.* mask;

[~, sortedInds] = sort(sup_H(:), 'descend');
topN = sortedInds(1:nlines);
[rhos, thetas] = ind2sub(size(sup_H), topN);

end
        