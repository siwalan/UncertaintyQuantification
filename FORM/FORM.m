% First Order Reduced Moment for Finite Element (or Implicit Model)
% Transformation Submodules are from FERUM under GPLv2 License.

clc; clear;
convergence = 0;

FORM_Params = [1];
Gradient_Parameter = [0,1,5,1]
%% Probabilistic Data
marg = [1;1;1;];
parameter = [50 6.25 0 0; 60 3 0 0; 1000 200 0 0;];
%%% Correlation Matrixes
R = eye(size(parameter,1));

%%% Procedures for NATAF
Ro = mod_corr(R,marg,parameter);
Lo = (chol(Ro))';
iLo = inv(Lo);

%% Initial Value for Iteration Generation
X = [parameter(:,1)]';
U = x_to_u(X,marg,parameter,iLo)

%% Convergence Limit, Iterator
i = 1;e1 = 10^-10;e2 = 10^-10;
maxIter = 5000;

fprintf("Starting FORM\n")
while convergence == 0
    fprintf("\nForm Analysis Iteration: %d Starting\n", i)

    X = u_to_x(U,marg,parameter,Lo);

    if FORM_Params(1) == 1
        fprintf("* Initial Value\n");
        for U_Iter=1:(size(parameter,1))
            fprintf("* Value of U%d : %8.5f; Value of X%x : %10.5f \n", U_Iter, U(U_Iter), U_Iter, X(U_Iter))
        end
            fprintf("\n")
    end
    
    J_u_x = jacobian(X,U,marg,parameter,Lo,iLo);
    J_x_u = inv(J_u_x);

    Y = modelFunc(X);
    if (isnan(Y))
        fprintf("* F Evaluation Error\n");
        break
    end

    fprintf("* Function Evaluation Iter #%d Finished\n",i);

    if i == 1
        Y0 = Y;
    end
    Gradient_Parameter(1) = i;
    curGrad = GradientComputation(Y,X,parameter,Gradient_Parameter);

    if (isnan(curGrad))
        fprintf("* Gradient Evaluation Error\n");
        break
    end

    curGrad = (curGrad' * J_x_u)';
    normCurGrad = norm(curGrad);
    alpha = -curGrad/normCurGrad;

    if ( (abs(Y/Y0)<e1) &&  (norm(U-alpha'*U*alpha)<e2)) || i >= maxIter
        convergence = 1;
    end

    beta =  (alpha' * U);
    pf =  1 - normcdf(beta);
    fprintf("* Current Beta is %f\n",beta);

    d = (Y/normCurGrad + alpha' * U) * alpha - U;
    U = U + d*1;
    i = i + 1;
end
beta =  (alpha' * U);
pf =  1 - normcdf(beta);
u_to_x(U,marg,parameter,Lo);

fprintf("\n\n\n**********************");
fprintf("\nFinal Beta is %f\n",beta)

fprintf("\nFinal Pf is %10.9f\n",pf);

fprintf("\nDesign Value \n");

for U_Iter=1:(size(parameter,1))
    fprintf("* Value of U%d : %8.5f; Value of X%x : %10.5f \n", U_Iter, U(U_Iter), U_Iter, X(U_Iter))
end