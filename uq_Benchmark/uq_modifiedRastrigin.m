function Y = uq_modifiedRastrigin(X)
% UQ_MODIFIEDRASTRIGIN computes the modified Rastrigin limit state function.
%
%   Y = UQ_SHORTCOLUMN(X) evaluates the 2-dimensional Rastrigin limit state
%   function for N-by-2 input matrix X, where N is the number of evaluation
%   points; and returns a column vector of length N.
%
%   References:
%
%   - Mühlenbein, H, M. Schomisch, and J. Born. (1991).
%     The parallel genetic algorithm as function optimizer. 
%     Parallel Computing, vol. 17, pp. 619-632.
%     DOI:10.1016/S0167-8191(05)80052-3
%   - Echard, B, N. Gayton, and M. Lemaire. (2011). AK-MCS: An active
%     learning reliability method combining Kriging and Monte Carlo
%     Simulation. Structural Safety, vol. 33, pp. 145-154.
%     DOI:10.1016/j.strusafe.2011.01.002

%% Check inputs
%
narginchk(1,1)
assert(size(X,2)==2,'Only 2 input variables are allowed!')

%% Evaluate limit state function
%
Y = 10 - sum(X.^2 - 5*cos(2*pi*X), 2);

end