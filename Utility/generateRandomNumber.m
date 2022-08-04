function X = genRV(marg, parameter, truncPositive)
if ~exist('truncPositive','var')
  truncPositive = 0;
end
RV_Numbers = size(marg,1);
X = zeros(RV_Numbers,1);
for RV_Distribution=1:RV_Numbers
    if (marg(RV_Distribution) == 1)
        X(RV_Distribution) = normrnd(parameter(RV_Distribution,1),parameter(RV_Distribution,2));
        if truncPositive == 1
            while(X(RV_Distribution) < 0)
               X(RV_Distribution) = normrnd(parameter(RV_Distribution,1),parameter(RV_Distribution,2));
            end
        end
    else
        m = parameter(RV_Distribution,1); % mean
        v = parameter(RV_Distribution,2); % variance
        mu = log((m^2)/sqrt(v+m^2));
        sigma = sqrt(log(v/(m^2)+1));
        X(RV_Distribution) = lognrnd(mu,sigma);
    end
end
