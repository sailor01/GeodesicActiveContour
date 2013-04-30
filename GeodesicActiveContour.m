% This MATLAB code is made as part of the course project for 
% COMP 558 - Fundamentals of Computer Vision at McGill University, Canada
% It demonstrates the geodesic active contour model using level sets for 
% object tracking in videos
%
% Authors: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%          Sricharana Rajagopal (sricharana.rajagopal@mail.mcgill.ca)
%
% Date: April 25th, 2013

function [ ] = GeodesicActiveContour( )

clear all;

% Part of video to be used (time in seconds)
tstart = 18;
tend = 23;

% Read video & get frame rate
obj = VideoReader('robot2.mp4');
fRate = floor(obj.FrameRate) + 1;
prevframe = read(obj,tstart*fRate);
imshow(prevframe,[]);
hold on;

% Get initial neighbourhood of robot
Points = [4,2];
for i=1:4
    [x,y] = ginput(1);
    plot(x,y,'ro')
    Points(i,:) = [x,y];
end
minP = min(Points);
maxP = max(Points);
minrow = minP(1,1);
mincol = minP(1,2);
maxrow = maxP(1,1);
maxcol = maxP(1,2);
rectangle('Position',[minrow,mincol,maxrow-minrow,maxcol-mincol],'EdgeColor','r'); drawnow;
hold off;

% Calculate initial center of mass
tempframe = read(obj,(tstart-1)*fRate);
prevCOM = COM(prevframe, tempframe);
[m,n,~] = size(tempframe);
clear tempframe;

% Input constants for level set evolution
val = 2;
timestep = 5;  % time step
iterin = 5; % number of iterations inside evolveLS function
iterout = 80; % number of iterations for evolving level set
alpha = 1.5; % coefficient of the weighted area term
beta = 0.2/timestep;  % coefficient of the distance regularization term
lambda = 5; % coefficient of the weighted length term
epsilon = 1.5; % parameter that specifies the width of the Dirac delta function
sigma = 1.5;
G = fspecial('gaussian',15,sigma); % Gaussian to smoothen the image

% Level set evolution for object detection & tracking
for i=tstart+1:tend
    
    % Read next frame
    currframe = read(obj,i*fRate);
    
    % Generating new phi for current neighbourhood of robot
    currCOM = COM(currframe, prevframe);
    shiftCOM = currCOM - prevCOM;
    minrow = floor(minrow + shiftCOM(1,1));
    mincol = floor(mincol + shiftCOM(1,2));
    maxrow = floor(maxrow + shiftCOM(1,1));
    maxcol = floor(maxcol + shiftCOM(1,2));
    if mincol<1, mincol=1; end
    if mincol>n, mincol=n; end
    if minrow<1, minrow=1; end
    if minrow>m, minrow=m; end
    frame = currframe(mincol:maxcol,minrow:maxrow,:);
    [p,q,~] = size(frame);
    phi = val*ones(p,q);
    phi(5:p-5, 5:q-5) = -val;
    bigPhi = val*ones(m,n);
    
    figure;
    
    for j=1:iterout;
        phi = evolveLS( frame, phi, G, beta, alpha, lambda, epsilon, timestep, iterin );
        for u=1:p
            for v=1:q
                bigPhi(mincol+u-1,minrow+v-1) = phi(u,v);
            end
        end
        imagesc(currframe,[0,255]); axis off; hold on;  contour(bigPhi, [0,0], 'r'); hold off; drawnow;
    end
    clear phi; clear bigPhi; clear frame;
    
    prevframe = currframe;
    prevCOM = currCOM;
    clear currframe; clear currCOM;
    
end

end