% This MATLAB code is made as part of the course project for 
% COMP 558 - Fundamentals of Computer Vision at McGill University, Canada
% It demonstrates the calculation of the curvature for the level set
% evolution
%
% Authors: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%          Sricharana Rajagopal (sricharana.rajagopal@mail.mcgill.ca)
%
% Date: April 25th, 2013

function [ K ] = div( Nx, Ny )

[nx,~]=gradient(Nx); 
[~,ny]=gradient(Ny);
K = nx + ny;

end