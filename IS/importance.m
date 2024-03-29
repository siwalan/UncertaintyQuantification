clc; clear;

marg = [1;1;1;];
parameter = [50 6.25 0 0;60 3 0 0; 1000 200 0 0;];
R = eye(size(parameter,1));
Ro = mod_corr(R,marg,parameter);
Lo = (chol(Ro))';
iLo = inv(Lo);

parameterQ = [25.1058; 57.4945; 1.443399260222214e+03];
UQ = x_to_u(parameterQ(:,1),marg,parameter,iLo);


i = 0;
maxIter = 500;
wY = [];
wW = [];
while i < maxIter
    U = mvnrnd(zeros(size(marg,2),size(marg,1)),eye(size(marg,1),size(marg,1)));
    U = U + UQ';
    X = u_to_x(U',marg,parameter,Lo);
    Y = modelFunc(X);
    Top = mvnpdf(U);
    Bottom = mvnpdf(U-UQ');
    w = Top/Bottom;
    if Y <= 0;
        wY = [wY;1*w];
    else
        wY = [wY;0];
    end
    
    i = i + 1;

end
pf = sum(wY);
pf = pf/i
