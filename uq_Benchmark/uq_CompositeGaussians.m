function Y = uq_CompositeGaussians(X)
% UQ_COMPOSITEGAUSSIANS evaluates the composite Gaussians test function.
%
%   Y = UQ_COMPOSITEGAUSSIANS(X) computes the composite limit state
%   function from two limit state components using two-dimensional input X:
%      X(:,1): X1
%      X(:,2): X2
%
%   Reference:
%
%   - B. J. Bichon, J. M. McFarland, and S. Mahadevan, "Efficient surrogate 
%     models for system reliability analysis of systems with multiple
%     failure modes," Reliability Engineering and System Safety, vol. 96,
%     pp. 1386-1395, 2011. DOI:10.1016/j.ress.2011.05.008

%% Check input
%
%narginchk(1,1)
%assert(size(X,2) == 2, 'Exactly 2 input variables are needed!')

%% Get input
X1 = X(1);
X2 = X(2);

%% Evaluate function
% First limit state function
G1 = X1.^2 + X2 - 8; 
% Second limit state function
G2 = 1/5*X1 + X2 - 6; 
% Composite limit state function
Y = max([G1 G2], [], 2);

end