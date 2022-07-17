function Y = uq_MelcherBeck(X)
%beta =
%   1.7891e-06
%% Check inputs
%
narginchk(1,1)
assert(size(X,1)==2,'Only 2 input variables are allowed!')
R = X(1); S = X(2); 
%% Evaluate limit state function
%s
Y = R-S;
end