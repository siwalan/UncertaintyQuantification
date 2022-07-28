clc; clear;

parameters = [50 6.25 0 0;60 3 0 0; 1000 200 0 0;];
p0 = 0.10;
N = 10000;
Nc     = N*p0;           
Ns     = 1/p0;   

N_params = 3;
MaxLevel = 10;

NPtarget = N - (N * p0);

result = zeros(N,N_params+1,10);
sortResult = zeros(N,N_params+1,10);
pLim = zeros(10,1);
pLevel = zeros(10,1);
pLevel(1) = p0;
for i=1:N
    X = [normrnd(parameters(1,1), parameters(1,2)), normrnd(parameters(2,1), parameters(2,2)), normrnd(parameters(3,1), parameters(3,2))];
    Y = modelFunc(X')*-1;
    result(i,:,1) = [Y X];
end

maxLevel = 10;
for i=1:maxLevel
    [sortResult(:,:,i), idx]  = sortrows(result(:,:,i),'ascend');
    seeds = result(idx(end-Nc:end),2:end,i);
    pLim(i) = result(idx(NPtarget),1,i);
    if (i > 1)
        pLevel(i) = pLevel(i-1)*p0;
    end
    Xs = zeros(N,N_params);
    for j=1:Nc
        paramSeed = parameters;
        paramSeed(:,1) = seeds(j,:);
        for k=1:Ns
            X = [normrnd(paramSeed(1,1), paramSeed(1,2)), normrnd(paramSeed(2,1), paramSeed(2,2)), normrnd(paramSeed(3,1), paramSeed(3,2))];
            for z=1:N_params
                X_Proposal = paramSeed(z,1)-parameters(z,2) + rand(1)*parameters(z,2)*2;
                r = normpdf(X_Proposal, parameters(z,1), parameters(z,2)) / normpdf(X(z), parameters(z,1), parameters(z,2));
                if rand <= r
                    X(z) = X_Proposal;
                end
            end
            

            if (modelFunc(X')) >= pLim(i)
                Xs((j-1)*Ns+k,:) = X;
            else
                Xs((j-1)*Ns+k,:) = seeds(j,:);
            end

        end
    end
    
    for j=1:N
        X = Xs(j,:);
        Y = modelFunc(X')*-1;
        result(j,:,i+1) = [Y X];
    end

end

