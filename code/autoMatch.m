function rel = autoMatch(pat1, pat2)
    num = size(pat1, 1);
    mat = zeros(num, num);
    map1 = zeros(num, 1);
    map2 = zeros(num, 1);
    for i=1:num
        for j=1:num
            mat(i, j) = sum(sum(sum((pat1(i,:,:,:)-pat2(j,:,:,:)).^2)));
        end
        min1 = 1e10;
        min2 = 1e10;
        lab = 1;
        for j=1:num
            if mat(i, j)<min1
                min2 = min1;
                min1 = mat(i, j); lab = j;
            else
                if mat(i, j)<min2
                    min2 = mat(i, j);
                end
            end
        end
        if (min1 / min2 < 0.5) && (map2(lab) == 0)
            map1(i) = lab;
            map2(lab) = i;
        end
    end
    for j=1:num
        if map2(j) ~= 0
            continue;
        end
        min1 = 1e10;
        for i=1:num
            if (mat(i, j)<min1) && (map1(i) == 0)
                min1 = mat(i, j); lab = i;
            end
        end
        map1(lab) = j;
        map2(j) = lab;
    end
    rel = map1;
end
