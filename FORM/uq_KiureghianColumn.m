function Y = uq_KiureghianColumn(X)


%% Check inputs
%
narginchk(1,1)
assert(size(X,1)==4,'Only 2 input variables are allowed!')
M1 = X(1); M2 = X(2); P = X(3); Y = X(4);
%% Evaluate limit state function
%
a = 0.190;
s1 = 0.030;
s2 = 0.015;
Y = 1 - (M1/(s1*Y)) - (M2/(s2*Y)) - (P/(a*Y))^2

end