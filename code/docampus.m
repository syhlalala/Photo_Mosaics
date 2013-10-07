function [ output_args ] = docampus
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[sx1 sy1] = doit('data/g1/4.png','data/g1/5.png',1078,'result1.png');
[sx2 sy2] = doit('result1.png','data/g1/3.png',878,'result2.png');
[sx3 sy3] = doit('result2.png','data/g1/2.png',1578,'result3.png');
[sx4 sy4] = doit('result3.png','data/g1/6.png',3278,'result4.png');
sy=sy1+sy2+sy3+sy4+600;
imm = imread('result4.png');
r = (1500.^2+size(imm,2).^2/4).^0.5;
tocylin('result4.png',r,300,sy);
end
