% This MATLAB code is made as part of the course project for 
% COMP 765 - Advanced Topics (Mobile Robotics) at McGill University, Canada
% It demonstrates the calculation of the Neumann boundary term for the
% level set evolution
%
% Author: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%
% Date: April 29th, 2013

function [ g ] = Neumann( phi )

[nrow, ncol] = size(phi);
g = phi;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);

end
