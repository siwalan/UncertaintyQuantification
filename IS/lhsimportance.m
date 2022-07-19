clc; clear;

marg = [1;1;1;1;1];
parameter = [0.07433 0.005 0 0;0.1 0.01 0 0; 13 60 0 0; 4751 48 0 0; -648 11 0 0]
R = eye(size(parameter,1));
Ro = mod_corr(R,marg,parameter);
Lo = (chol(Ro))';
iLo = inv(Lo);

parameterQ = [0.0583182995692646;0.100000000000000;-0.360338271452145;4768.09929479390;-648.366320391761]
UQ = x_to_u(parameterQ(:,1),marg,parameter,iLo);

LHS = lhsdesign(50,2);
margLHS = [6;6];
R = eye(2);
parameterLHS = [0.5 (1/(2*sqrt(3))) 0 1; 0.5 (1/(2*sqrt(3))) 0 1;]
RoLHS = mod_corr(R,margLHS,parameterLHS);
LoLHS = (chol(RoLHS))';
iLoLHS = inv(LoLHS);
ULHS = x_to_u(LHS(:,1),marg,paramaterLHS,iLoLHS)

i = 0;
maxIter = 50;
wY = [];
wW = [];
while i < maxIter
    U = mvnrnd(UQ',ones(size(marg,1),1)');
    X = u_to_x(U',marg,parameter,Lo);
    Y = modelFunc(X);
    wDen = mvnpdf(U,UQ',eye(size(marg,1)));
    wNum = mvnpdf(U);
    w = wNum/wDen;
    if Y <= 0;
        wY = [wY;1*w];
    else
        wY = [wY;0];
    end
    
    i = i + 1;

end
pf = sum(wY);
pf = pf/i
