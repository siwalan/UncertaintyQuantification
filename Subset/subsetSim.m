clc; clear;

proposal_Parameters = [1];
marg = [2;2;2;];
RV_parameters = [50 6.25 0 0;60 3 0 0; 1000 200 0 0;];

R = eye(size(RV_parameters,1));
Ro = mod_corr(R,marg,RV_parameters);
Lo = (chol(Ro))';
iLo = inv(Lo);
RV_parameters = distribution_parameter(marg,RV_parameters);

p0 = 0.10;
N = 100;
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
    X = generateRandomNumber(marg,RV_parameters);
    Y = modelFunc(X);
    result(i,:,1) = [Y X'];
end

maxLevel = 10;
for i=1:maxLevel
    [sortResult(:,:,i), idx]  = sortrows(result(:,:,i),'descend');
    seeds = result(idx(end-Nc:end),2:end,i);
    seedsY = result(idx(end-Nc:end),1,i);
    pLim(i) = result(idx(NPtarget),1,i);
    if (i > 1)
        pLevel(i) = pLevel(i-1)*p0;
    end
    Xs = zeros(N,N_params);
    paramSeed = zeros(Nc,N_params);

    for j=1:Nc
        paramSeed(j,:) = seeds(j,:)';
        curSeed = seeds(j,:)';
        for k=1:Ns
            proposal = genSubsetProp(curSeed,marg,RV_parameters,Lo,iLo, proposal_Parameters);
            
%             for U_Iter=1:(size(RV_parameters,1))
%                 fprintf("* Value of cS%d : %8.5f; Value of Pr%x : %10.5f \n", U_Iter, curSeed(U_Iter), U_Iter, proposal(U_Iter))
%             end
%             fprintf("\n");

            Y_prop = modelFunc(proposal);
            if Y_prop <= pLim(i)
                Xs((j-1)*Ns+k,:) = proposal;
            else
                Xs((j-1)*Ns+k,:) = seeds(j,:);
                Y_prop = seedsY(j,:);
            end
            result((j-1)*Ns+k,:,i+1) = [Y_prop Xs((j-1)*Ns+k,:)];

        end
    end
    


end

