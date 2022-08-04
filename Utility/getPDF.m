function Y = getPDF(X, marg, parameter)

if marg == 1
    Y = normpdf(X,parameter(1),parameter(2));
elseif marg == 2
    m = parameter(1); % mean
    v = parameter(2); % variance
    mu = log((m^2)/sqrt(v+m^2));
    sigma = sqrt(log(v/(m^2)+1));
    Y = lognpdf(X,mu,sigma);
elseif marg == 6
    a = parameter(3);
    b = parameter(4);
    Y = unipdf(X,a,b);
end
end
