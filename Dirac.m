% This MATLAB code demonstrates the calculation of the Dirac delta function term for the
% level set evolution

function [ deltaPhi ] = Dirac( phi, epsilon )

f = (epsilon/2)*(1 + cos(pi*phi/epsilon));
b = (phi >= -epsilon) & (phi <= epsilon);
deltaPhi = f.*b;

end
