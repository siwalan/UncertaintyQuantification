function Y = Beam(X)
%% Check inputs
% marg = [1;1;1;];
% parameter = [50 6.25 0 0;60 3 0 0; 1000 200 0 0;];
%  Pf = 1.7901e-06
narginchk(1,1)
assert(size(X,1)==3,'Only 3 input variables are allowed!')
Y = X(1); Z = X(2); M = X(3);
%% Evaluate limit state function
%
Y = Y*Z-M;
end