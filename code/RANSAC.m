function [pairsret best ou1 ou2] = RANSAC(map, c1, c2,total) 
    num = size(map, 1);
    best = 0;
    for i=1:total
        a = randi(num, [4 1]);
        x1 = c1(a, :);
        x2 = c2(map(a), :);
        H = computeH(x1, x2);
        tot = 0;
        pairs = [];
        j=[1:num]';
        tt1=c2(map(j), 1);
        tt2=c2(map(j), 2);
        tt3=ones(1,num);
        tt(1,:)=tt1;
        tt(2,:)=tt2;
        tt(3,:)=tt3;
        t=H*tt;
        t3 = t(3,:);
        t(1,:)=t(1,:)./t3;
        t(2,:)=t(2,:)./t3;
        dis1=(t(1,:)-c1(:,1)').^2;
        dis2=(t(2,:)-c1(:,2)').^2;
        pairs=find(dis1+dis2 <= 50);
        tot=size(pairs,2);
%         for j=1:num
%             t = H * [c2(map(j), :) 1]';
%             t = t ./ t(3);
%             if (t(1)-c1(j, 1))^2 + (t(2)-c1(j, 2))^2 <= 50
%                 tot = tot+1;
%                 pairs(tot)=j;
%             end
%         end
        if tot > best
            best = tot;
            list = a;
            pairsret = pairs;
        end
    end
    
    ou1 = zeros(best, 2);
    ou2 = zeros(best, 2);
    x1 = c1(list, :);
    x2 = c2(map(list), :);
    H = computeH(x1, x2);
    tot = 0;
    for j=1:num
        t = H * [c2(map(j), :) 1]';
        t = t ./ t(3);
        if (t(1)-c1(j, 1))^2 + (t(2)-c1(j, 2))^2 <= 100
            tot = tot+1;
            ou1(tot, :) = c1(j, :);
            ou2(tot, :) = c2(map(j), :);
        end
    end
end