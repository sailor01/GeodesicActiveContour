% This MATLAB code demonstrates the calculation of the curvature for the level set
% evolution

function [ K ] = div( Nx, Ny )

[nx,~]=gradient(Nx); 
[~,ny]=gradient(Ny);
K = nx + ny;

end
