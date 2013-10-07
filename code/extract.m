function out = extract(in, num)
    p = im2double(in);
    g = rgb2gray(p);
    
    [h w tmp] = size(p);
    
    len = 20;
    
    fx = [-2 -1 0 1 2];
    Ix = filter2(fx, g);
    fy = [-2;-1;0;1;2];
    Iy = filter2(fy, g);
    Ix2 = Ix.^2; 
    Iy2 = Iy.^2; 
    Ixy = Ix.*Iy; 
    clear Ix; 
    clear Iy; 
    
    gau = fspecial('gaussian', [7 7], 2);

    Ix2 = filter2(gau, Ix2); 
    Iy2 = filter2(gau, Iy2); 
    Ixy = filter2(gau, Ixy); 

    %R = zeros((h-2*len)*(w-2*len), 3);
    r = zeros(h,w); 
    detM = Ix2.*Iy2-Ixy.*Ixy;
    traceM = Ix2+Iy2;
    r=detM-0.1*(traceM.^2);
    tot = 0;
%     for i = len+1:h-len
%         for j = len+1:w-len
%             M = [Ix2(i,j) Ixy(i,j); Ixy(i,j) Iy2(i,j)]; 
%             r(i, j) = det(M) - 0.1 * (trace(M))^2;
%         end
%     end
    tmph = zeros(h,w);
    tmpw = zeros(h,w);
    tmph=[1:h]'*ones(1,w);
    tmpw=ones(h,1)*[1:w];
    Rmax = max(max(r))*0.02;
    if (w>3000)
        cut = w-1000;
    else
        cut = len;
    end
    g = find(tmph>len & tmpw>cut & tmph<h-len+1 & tmpw<w-len+1 & r>Rmax);
    t1=r(g)';
    t2=tmph(g)';
    t3=tmpw(g)';
    R(:,1)=t1;
    R(:,2)=t2;
    R(:,3)=t3;
    sz = size(R);
%     for i = len+1:h-len
%         for j = len+1:w-len
%             if r(i, j) > Rmax * 0.02
%                 tot = tot + 1;
%                 R(tot, 1) = r(i, j);
%                 R(tot, 2) = i;
%                 R(tot, 3) = j;
%             end
%         end
%     end
%    imshow(r), hold on;
    tot=sz(1)
    R = -sortrows(-R, 1);
    list = zeros(num, 2);
    dis = 100 * 100;
    totOut = 0;
    while totOut < num
        for i=1:tot
            if R(i, 1) > 0
                ok = 1;
                for j=1:totOut
                    if (R(i, 2) - list(j, 1))^2 + (R(i, 3) - list(j, 2))^2 < dis
                        ok = 0; break;
                    end
                end
                if ok
                    totOut = totOut + 1;
                    list(totOut, :) = R(i, 2:3);
                    R(i, 1) = -1;
                    if totOut == num
                        break;
                    end
                end
            end
        end
        dis = dis * 0.8;
    end
%    plot(list(:, 2), list(:, 1), 'x');
    pic = zeros(num, 8, 8, 3);
    for i=1:num
        pic(i, :, :, :) = imresize(p(list(i, 1)-len : list(i, 1)+len, list(i, 2)-len : list(i, 2)+len, :), [8, 8]);
    end
    out = {list, pic};
end
