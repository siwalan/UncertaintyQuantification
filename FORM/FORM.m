
convergence = 0;

marg = [1;1];
parameter = [5.5 1.0 0 0; 5 1 0 0; ];
R = eye(2);

Ro = mod_corr(R,marg,parameter);
Lo = (chol(Ro))';
iLo = inv(Lo);
X = [5.5 5];
U = x_to_u(X,marg,parameter,iLo)

while convergence == 0
    X = u_to_x(U,marg,parameter,Lo);
    J_u_x = jacobian(X,U,marg,parameter,Lo,iLo);
    J_x_u = inv(J_u_x);

    Y = modelFunc(X);
    curGrad = GradientComputation(X,parameter);
    curGrad = (curGrad * J_x_u)
    normCurGrad = norm(curGrad)
    alpha = -curGrad/normCurGrad;
    d = (curGrad/normCurGrad + alpha * U) * alpha - U';
    X = X + d*0.01
end

