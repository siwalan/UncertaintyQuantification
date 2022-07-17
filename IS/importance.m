clc; clear;

marg = [1;1;1;];
parameter = [50 6.25 0 0; 60 3 0 0; 2000 200 0 0;];
R = eye(size(parameter,1));
Ro = mod_corr(R,marg,parameter);
Lo = (chol(Ro))';
iLo = inv(Lo);

parameterQ = [37.996974487706270 6.25 0 0; 58.194315475911814 3 0 0; 2.211207920467880e+03 200 0 0;];



i = 0;
maxIter = 1000;
wY = [];
wW = [];
while i < maxIter
    X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameterQ(3,1), parameterQ(3,2))];
    Y = modelFunc(X');
    wDen = [normpdf(X(3),parameterQ(3,1),parameterQ(3,2)) ];
    wNum = [normpdf(X(3),parameter(3,1),parameter(3,2))];
    w = wNum/wDen;
    wW = [wW; w];
    if Y <= 0;
        wY = [wY;1*w];
    else
        wY = [wY;0];
    end
%     wY = [wY Y*w];
    i = i + 1;

end
pf = sum(wY);
pf = pf/i
