function [ output_args ] = tocylin( inp,r,sx,sy )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
inpic = imread(inp);
[h w tmp] = size(inpic);
halfh = round(h/2)+sx
%halfw = round(w/2);
halfw=sy
d = sqrt(r*r-halfw*halfw);
maxh = ceil(h*r/d);
halfmaxh = ceil(maxh/2);
tot = 0;
newpic = ones(maxh,w,3);

tmp1 = zeros(maxh,w,2);
tmp1(:,:,1)=[1:maxh]'*ones(1,w);
tmp1(:,:,2)=ones(maxh,1)*[1:w];
tmp2 = zeros(maxh,w,2);
tmp2(:,:,1)=tmp1(:,:,1)-halfmaxh;
tmp2(:,:,2)=tmp1(:,:,2)-halfw;
cc = sqrt(r*r-tmp2(:,:,2).*tmp2(:,:,2));
tmp2(:,:,1)=tmp2(:,:,1)./cc*d+halfh;
tmp2(:,:,2)=tmp2(:,:,2)./cc*d+halfw;
g = find(tmp2(:,:,1)>1 & tmp2(:,:,2)>1 & tmp2(:,:,1)<h & tmp2(:,:,2)<w)-1;
list1 = [floor(g./maxh)+1 mod(g,maxh)+1];
lt1 = list1(:,1);
lt1=lt1';
lt2 = list1(:,2);
lt2=lt2';
%size(tmp1([3 4], [2 3], :))
list2(:,1) = tmp2(g+1);
list2(:,2) = tmp2(g+1+maxh*w);
list = [list1(:,2) list1(:,1) list2(:,2) list2(:,1)];

% for i=1:maxh
%     for j=1:w
%         %[i j]
%         x = i-halfmaxh;
%         y = j-halfw;
%         c = sqrt(r*r-y*y);
%         xx = x/c*d+halfh;
%         yy = y/c*d+halfw;
%         if round(xx) > 1 && round(yy) > 1 && round(xx) < h && round(yy) < w
%             tot = tot+1;
%             list(tot, :) = [i j xx yy];
%         end
%     end
% end
% % 
% for i=1:maxh
%     %i
%     for j=1:w
%         xx = tmp2(i,j,1);
%         yy = tmp2(i,j,2);
%         if round(xx) > 1 && round(yy) > 1 && round(xx) < h && round(yy) < w
%             tot = tot+1;
%             list(tot, :) = [i j xx yy];
%         end
%     end
% end
sz=size(list);
tot=sz(1)
pp = im2double(inpic);
rr = interp2(pp(:, :, 1), list(1:tot, 3), list(1:tot, 4));
gg = interp2(pp(:, :, 2), list(1:tot, 3), list(1:tot, 4));
bb = interp2(pp(:, :, 3), list(1:tot, 3), list(1:tot, 4));
for i=1:tot
    newpic(list(i, 1), list(i, 2), :) = [rr(i) gg(i) bb(i)];
end
imwrite(newpic, ['cylin_' inp]);
figure(5);
imshow(newpic);
end