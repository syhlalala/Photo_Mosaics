function [ shiftX shiftY ] = doit(inname1, inname2, part,result)
warning off all
in1 = imread(inname1);
in2 = imread(inname2);
sz1=size(in1,2);
sz2=size(in2,2);
if (sz1>1500 || sz2>1500)
    total=200;
else
    total=100;
end
p1 = extract(in1, total);
p2 = extract(in2, total);
[shiftX shiftY] = main(in1,in2,p1,p2,'ou1.png','ou2.png',0);
blending('ou1.png', 'ou2.png', part, result);
%blending2P('ou1.png', 'ou2.png', 'result', 1);
end
