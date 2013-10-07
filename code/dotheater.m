function [ output_args ] = dotheater
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[sx1 sy1] = doit('data/g2/02.jpg','data/g2/03.jpg',622,'result.jpg');
[sx2 sy2] = doit('result.jpg','data/g2/01.jpg',600,'theaterresult.jpg');
sx=sx1+sx2+400;
sy=sy1+sy2+240;
imm = imread('theaterresult.jpg');
r = (1000.^2+size(imm,2).^2/4).^0.5;
tocylin('theaterresult.jpg',r,40,sy);
end
