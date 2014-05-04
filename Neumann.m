% This MATLAB code demonstrates the calculation of the Neumann boundary term for the
% level set evolution

function [ g ] = Neumann( phi )

[nrow, ncol] = size(phi);
g = phi;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);

end
