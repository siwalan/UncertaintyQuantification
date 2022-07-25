%% Example 6.2 from Monte Carlo Book with R

a = 2.7; b = 6.3; c =2.669;
startX = rand(1);
Nsim =5000;
X = ones(5000,1) * startX;
for i=2:Nsim 
    Y = rand(1);
    rho = betapdf(Y,a,b)/betapdf(X(i-1),a,b);
    if (rand(1) < rho)
        X(i) = X(i-1) + (Y-X(i-1));
    else
        X(i) = X(i-1);
    end
end