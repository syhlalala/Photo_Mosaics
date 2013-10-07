function [shiftX shiftY] = main(in1, in2, pat1, pat2, ou1, ou2, show)
global height
global width
global cut
p1 = im2double(in1);
p2 = im2double(in2);
[h w tmp] = size(p2);
[hh ww tmp] = size(p1);
if (w>1500 || ww>1500)
    total=50000;
else
    total=20000;
end
rel = autoMatch(pat1{2}, pat2{2});
['autoMatch done!']
[pairs best x1 x2] = RANSAC(rel, pat1{1}, pat2{1},total);
best
H = computeH(x1, x2);

[h w tmp] = size(p2);
[hh ww tmp] = size(p1);
height = h;
width = w;

s1 = H * [1 1 1]';
s1 = s1 ./ s1(3);
s2 = H * [h 1 1]';
s2 = s2 ./ s2(3);
s3 = H * [1 w 1]';
s3 = s3 ./ s3(3);
s4 = H * [h w 1]';
s4 = s4 ./ s4(3);
newSX = min([1 s1(1) s2(1) s3(1) s4(1)]);
newSY = min([1 s1(2) s2(2) s3(2) s4(2)]);
newTX = max([hh s1(1) s2(1) s3(1) s4(1)]);
newTY = max([ww s1(2) s2(2) s3(2) s4(2)]);
right = newSY
if right > 0
    cutSX = max([1 s1(1) s3(1)]);
    %cutSY = max([1 s1(2) s2(2)])
    cutSY = 1;
    cutTX = min([hh s2(1) s4(1)]);
    cutTY = min([s3(2) s4(2)]);
else
    cutSX = max([1 s1(1) s3(1)]);
    %cutSY = max([1 s1(2) s2(2)])
    cutSY = max([s1(2) s2(2)]);
    cutTX = min([hh s2(1) s4(1)]);
    cutTY = ww;
end

if (show > 0)
    figure(1);
    hold off;
    imshow([p1,p2]);
    hold on;
    for tidx=1:1:size(pairs,2);
        idx = pairs(tidx);
        plot([pat1{1}(idx,2),pat2{1}(rel(idx),2)+ww],[pat1{1}(idx,1),pat2{1}(rel(idx),1)]);
        hold on;
    end;
end;
s1;
s2;
s3;
s4;
result = abs(log(norm(s2-s1)/norm(s4-s3)));

newP1 = ones(newTX-newSX+1, newTY-newSY+1, 3);
newP2 = ones(newTX-newSX+1, newTY-newSY+1, 3);
size(newP2);
shiftX = 1-newSX;
shiftY = 1-newSY;
newP1(1+shiftX:hh+shiftX, 1+shiftY:ww+shiftY, :) = p1(:, :, :);
newP2 = ones(size(newP1));
cut = [cutSX+shiftX cutSY+shiftY cutTX+shiftX cutTY+shiftY];
Hprime = inv(H);
list = zeros((newTX-newSX+1)*(newTY-newSY+1), 4);
tot = 0;
newh=round(newTX-newSX+1);
neww=round(newTY-newSY+1);
% tmp1 = zeros(newh,neww);
% tmp2 = zeros(newh,neww);
tmp3 = ones(1,newh*neww);
tmp1=[1:newh]'*ones(1,neww)-shiftX;
tmp2=ones(newh,1)*[1:neww]-shiftY;
t1 = zeros(1,newh*neww);
t2 = zeros(1,newh*neww);
t1(:)=tmp1(:,:);
t2(:)=tmp2(:,:);
tt=[t1;t2;tmp3];
t=Hprime*tt;
t3 = t(3,:);
t(1,:)=t(1,:)./t3;
t(2,:)=t(2,:)./t3;
g = find(round(t(1,:))>1 & round(t(2,:))>1 & round(t(1,:))<h & round(t(2,:))<w);
l1=t1(g)+shiftX;
l2=t2(g)+shiftY;
l3=t(1,g);
l4=t(2,g);
sz=size(g);
list=zeros(sz(2),4);
list(:,1)=l1';
list(:,2)=l2';
list(:,3)=l3';
list(:,4)=l4';
sz = size(list);
tot=sz(1);
% for i=1:newTX-newSX+1
%     for j=1:newTY-newSY+1
%         t = Hprime*[i-shiftX j-shiftY 1]';
%         t = t ./ t(3);
%         if round(t(1)) > 1 && round(t(2)) > 1 && round(t(1)) < h && round(t(2)) < w
%             tot = tot+1;
%             list(tot, :) = [i j t(1) t(2)];
%         end
%     end
% end
rr = interp2(p2(:, :, 1), list(1:tot, 4), list(1:tot, 3));
gg = interp2(p2(:, :, 2), list(1:tot, 4), list(1:tot, 3));
bb = interp2(p2(:, :, 3), list(1:tot, 4), list(1:tot, 3));
for i=1:tot
    newP2(list(i, 1), list(i, 2), :) = [rr(i) gg(i) bb(i)];
end
%figure(2);
%imshow(newP1);
%figure(3);
%imshow(newP2);
if right>0
    imwrite(newP1, ou1);
    imwrite(newP2, ou2);
else
    imwrite(newP1, ou2);
    imwrite(newP2, ou1);
end
end
