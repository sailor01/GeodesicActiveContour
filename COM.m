% This MATLAB code calculates the center of mass of the frame difference

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
