function H = computeH(x1, x2)
    n = size(x1, 1);
    A = zeros(n*2, 8);
    b = zeros(n*2, 1);
    for i=1:n
        A(i*2-1, 1) = x2(i, 1);
        A(i*2-1, 2) = x2(i, 2);
        A(i*2-1, 3) = 1;
        A(i*2-1, 7) = -x2(i, 1) * x1(i, 1);
        A(i*2-1, 8) = -x2(i, 2) * x1(i, 1);
        A(i*2  , 4) = x2(i, 1);
        A(i*2  , 5) = x2(i, 2);
        A(i*2  , 6) = 1;
        A(i*2  , 7) = -x2(i, 1) * x1(i, 2);
        A(i*2  , 8) = -x2(i, 2) * x1(i, 2);

        b(i*2-1, 1) = x1(i, 1);
        b(i*2  , 1) = x1(i, 2);
    end
    t = A\b;
    H = [t(1:3)'; t(4:6)'; t(7:8)' 1];
end