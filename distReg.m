% This MATLAB code is made as part of the course project for 
% COMP 765 - Advanced Topics (Mobile Robotics) at McGill University, Canada
% It demonstrates the calculation of the distance regularization term for
% the level set evolution
%
% Author: Srushti Dhope (srushti.dhope@mail.mcgill.ca)
%
% Date: April 29th, 2013

function [ dReg ] = distReg( phi )

% compute the distance regularization term with the double-well potential
[gPhiX,gPhiY] = gradient(phi);
root = sqrt(gPhiX.^2 + gPhiY.^2);
a = (root>=0) & (root<=1);
b = (root>1);
derRoot = a.*sin(2*pi*root)/(2*pi)+b.*(root-1);  % compute first order derivative of the double-well potential
derDerRoot = ((derRoot~=0).*derRoot+(derRoot==0))./((root~=0).*root+(root==0));
dReg = div(derDerRoot.*gPhiX - gPhiX, derDerRoot.*gPhiY - gPhiY) + 4*del2(phi); 

end
