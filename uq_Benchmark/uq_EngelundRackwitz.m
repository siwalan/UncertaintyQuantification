function Y = uq_EngelundRackwitz(X)
%% Check inputs
%
narginchk(1,1)
assert(size(X,1)==2,'Only 2 input variables are allowed!')
X1 = X(1); X2 = X(2);
%% Evaluate limit state function
%
Y = X1*X2-(14614*10);
end