% First Order Reduced Moment for Finite Element (or Implicit Model)
%
% Theory is based on ..
% Transformation Submodules are from FERUM under GPLv2 License.
clc; clear;
convergence = 0;

marg = [1;1;1;];
parameter = [50 6.25 0 0; 60 3 0 0; 1000 200 0 0;];
R = eye(size(parameter,1));

Ro = mod_corr(R,marg,parameter);
Lo = (chol(Ro))';
iLo = inv(Lo);
X = [parameter(:,1)]';
U = x_to_u(X,marg,parameter,iLo)
i = 1
e1 = 10^-5;
e2 = 10^-5;
maxIter = 1000;
while convergence == 0
    X = u_to_x(U,marg,parameter,Lo);
    J_u_x = jacobian(X,U,marg,parameter,Lo,iLo);
    J_x_u = inv(J_u_x);

    Y = modelFunc(X);
    if i == 1
        Y0 = Y;
    end
    curGrad = GradientComputation(X,parameter);
    curGrad = (curGrad' * J_x_u)';
    normCurGrad = norm(curGrad);
    alpha = -curGrad/normCurGrad;

    if ( (abs(Y/Y0)<e1) &&  (norm(U-alpha'*U*alpha)<e2)) || i > maxIter
        convergence = 1
    end

    beta =  1 - normcdf(alpha' * U);

    d = (Y/normCurGrad + alpha' * U) * alpha - U;
    U = U + d*1;
    i = i + 1;
end
beta =  1 - normcdf(alpha' * U)
u_to_x(U,marg,parameter,Lo)