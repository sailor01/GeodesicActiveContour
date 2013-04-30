% This MATLAB code is made as part of the course project for 
% COMP 558 - Fundamentals of Computer Vision at McGill University, Canada
% It demonstrates the level set evolution for object tracking in videos
%
% Authors: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%          Sricharana Rajagopal (sricharana.rajagopal@mail.mcgill.ca)
%
% Date: April 25th, 2013

function [ phi ] = evolveLS( frame, phi, G, beta, alpha, lambda, epsilon, timestep, iterin )

frame = double(rgb2gray(frame));
Gframe = conv2(frame,G,'same'); % Convolving with a Gaussian
[Ix,Iy] = gradient(Gframe); % Calculate deltaI
clear frame; clear Gframe;
f = Ix.^2 + Iy.^2;
g = 1./(1+f); % Calculating edge detector function
[Vx,Vy] = gradient(g); % Calculate gradient of edge detector function

for k=1:iterin
    
    phi = Neumann(phi);
    
    % Calculate deltaPhi
    [PhiX, PhiY] = gradient(phi);
    magPhi = sqrt((PhiX.^2)+(PhiY.^2));
    
    % Calculate N
    eps = 1e-10; % Small number to avoid division by zero
    Nx = PhiX./(magPhi+eps);
    Ny = PhiY./(magPhi+eps);
    
    % Calculate K
    K = div(Nx,Ny);
    
    % Calculate the distance regularization term
    dReg = distReg(phi);
    
    % Apply Dirac delta function
    deltaPhi = Dirac(phi,epsilon);
    
    area = deltaPhi.*g;
    edge = deltaPhi.*(Vx.*Nx + Vy.*Ny) + deltaPhi.*g.*K;
    
    phi = phi + timestep*(alpha*area + beta*dReg + lambda*edge);

end