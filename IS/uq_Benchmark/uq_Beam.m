function Y = Beam(X)
%beta =
%   1.7891e-06
%% Check inputs
%
narginchk(1,1)
assert(size(X,1)==3,'Only 3 input variables are allowed!')
Y = X(1); Z = X(2); M = X(3);
%% Evaluate limit state function
%
Y = Y*Z-M;
end