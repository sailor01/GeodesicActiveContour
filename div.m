% This MATLAB code is made as part of the course project for 
% COMP 765 - Advanced Topics (Mobile Robotics) at McGill University, Canada
% It demonstrates the calculation of the curvature for the level set
% evolution
%
% Author: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%
% Date: April 29th, 2013

function [ K ] = div( Nx, Ny )

[nx,~]=gradient(Nx); 
[~,ny]=gradient(Ny);
K = nx + ny;

end
