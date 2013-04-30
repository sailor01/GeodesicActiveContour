% This MATLAB code is made as part of the course project for 
% COMP 765 - Advanced Topics (Mobile Robotics) at McGill University, Canada
% It calculates the center of mass of the frame difference
%
% Author: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%
% Date: April 29th, 2013

function [ com ] = COM( currframe, prevframe )

currframe = rgb2gray(currframe);
currframe = im2bw(currframe,0.8);
prevframe = rgb2gray(prevframe);
prevframe = im2bw(prevframe,0.8);

diff = currframe - prevframe;
[row,col] = find(diff<0);
for i=1:size(row,1)
    diff(row(i,1),col(i,1))=1;
end

c  = regionprops(diff, 'Centroid');
com = cat(1, c.Centroid);

end
