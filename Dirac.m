% This MATLAB code is made as part of the course project for 
% COMP 558 - Fundamentals of Computer Vision at McGill University, Canada
% It demonstrates the calculation of the Dirac delta function term for the
% level set evolution
%
% Authors: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%          Sricharana Rajagopal (sricharana.rajagopal@mail.mcgill.ca)
%
% Date: April 25th, 2013

function [ deltaPhi ] = Dirac( phi, epsilon )

f = (epsilon/2)*(1 + cos(pi*phi/epsilon));
b = (phi >= -epsilon) & (phi <= epsilon);
deltaPhi = f.*b;

end