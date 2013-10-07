function res = blending(in1, in2, partition, out)
global cut
    p1 = im2double(imread(in1));
    p2 = im2double(imread(in2));
    
    [h w tmp] = size(p1);
%    partition = 900;
    level = 5;
    width = 20;
    g = zeros(level, 19, 19);
    for i=2:level
        g(i, :, :) = fspecial('gaussian', [19 19], 2^(i-2));
    end
    g(1, 10, 10) = 1;
    res = p1;
    size(p2);
    size(p1);
    res(:, partition+2^(level-1):w, :) = p2(:, partition+2^(level-1):w, :);
    res(:, partition-2^(level-1):partition+2^(level-1), :) = zeros(h, 2^(level)+1, 3);
    totalW = 2^(level-1);
    for i=1:level%:level
        if i==level
            curW = totalW;
            tmp1 = imfilter(p1(:, partition-width:partition+width, :), squeeze(g(i, :, :)), 'same');
            tmp2 = imfilter(p2(:, partition-width:partition+width, :), squeeze(g(i, :, :)), 'same');
        else
            curW = 2^(i-1);
            tmp1 = imfilter(p1(:, partition-width:partition+width, :), squeeze(g(i, :, :)), 'same') - imfilter(p1(:, partition-width:partition+width, :), squeeze(g(i+1, :, :)), 'same');
            tmp2 = imfilter(p2(:, partition-width:partition+width, :), squeeze(g(i, :, :)), 'same') - imfilter(p2(:, partition-width:partition+width, :), squeeze(g(i+1, :, :)), 'same');
        end
        res(:, partition-totalW:partition-curW, :) = res(:, partition-totalW:partition-curW, :) + tmp1(:, (width+1)-totalW:(width+1)-curW, :);
        res(:, partition+curW:partition+totalW, :) = res(:, partition+curW:partition+totalW, :) + tmp2(:, (width+1)+curW:(width+1)+totalW, :);
        for j=-curW+1:curW-1
            res(:, partition+j, :) = res(:, partition+j, :) + tmp2(:, (width+1)+j, :) * (j+curW)/(2*curW) + tmp1(:, (width+1)+j, :) * (curW-j)/(2*curW);
        end
    end
    hold off;
    imwrite(res, out);
    figure(4);
    imshow(res);
    cuth = cut(3)-cut(1)+1;
    cutw = cut(4)-cut(2)+1;
    %newpic = zeros(cuth, cutw,3);
    newpic = res(cut(1):cut(3),cut(2):cut(4),:);
    %figure(2);
    %imshow(newpic);
    imwrite(newpic, ['_' out]);
end