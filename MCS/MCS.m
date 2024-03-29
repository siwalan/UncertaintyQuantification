clc; clear;

% MCS with Stopping Criteria with PF
%
% Theory Background
%
% Taken from Structural and System Reliability, Der Kiureghian (2022)
% C.O.V. of MC simulation is taken as square root of (1-Pf)/(N*Pf) (Eq.
% 9.11) in the book
%
targetCOV = 0.01;
currentCOV = Inf;
result = []
N = 0;

marg = [1; 1; 1;]
parameter = [50 6.25 0 0;60 3 0 0; 1000 200 0 0;];
while (targetCOV <= currentCOV)
    N = N+1
    X = generateRandomNumber(marg,parameter);
    Y = modelFunc(X);
    result = [result; Y];
    pf = sum(result<0);
    pf = pf/N
    currentCOV = sqrt((1-pf)/(N*pf));
end

% result = []
% while (N <= 100000)
%     N = N+1;
%     X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
%     Y = modelFunc(X');
%     result = [result; Y];
%     pf = sum(result<0);
%     pf = pf/N;
%     currentCOV = sqrt((1-pf)/(N*pf));
% end
N
pf
% MCS with Stopping Criteria without PF
%
% Theory Background
% Taken from A Brief Survey of Stopping Rules in MCS (Gilman, 1968)
% Mean Value is 1/N times Sum of xi
% Variance of the MCS is 1/(N-1) times Sum of ((xi) - U)^2
% Thus based on C.O.V. is Var/Mean, C.O.V. is 1/(N*(N-1)) times Sum of ((xi) - U)^2
%
% A more practical approach is taken at 
% https://quant.stackexchange.com/questions/21764/stopping-monte-carlo-simulation-once-certain-convergence-level-is-reached
% https://en.wikipedia.org/wiki/Standard_error
%
% Algorithm for Dynamic Variance Calculation is
% https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance#Welford's_online_algorithm
%
% Background for Standard Error
% https://statisticsbyjim.com/hypothesis-testing/standard-error-mean/
% 
% result = []
% N = 0;
% 
% avg = 0;
% m2 = 0;
% targetSE = 0.01;
% currentSE = Inf;
% 
% while (targetSE <= currentSE)
%     X = randn([1 2]);
%     Y = uq_modifiedRastrigin(X);
%     N = N+1;
%     if N == 1
%         avg = Y;
%     elseif N > 1
%         delta = Y - avg;
%         avg = avg + delta/N;
%         delta2 = Y - avg;
%         m2 = m2 + delta*delta2;
%         sn = sqrt(m2/(N-1));
%         currentSE = sn/sqrt(N);
%         % currentSE = sqrt(sn/N)
%     end
% end
% N
% 
% 
% result = []
% N = 0;
% 
% avg = 0;
% m2 = 0;
% targetSE = 0.01;
% currentSE = Inf;
% 
% while (targetSE <= currentSE)
%     X = randn([1 2]);
%     Y = uq_modifiedRastrigin(X);
%     N = N+1;
%     if N == 1
%         avg = Y;
%     elseif N > 1
%         delta = Y - avg;
%         avg = avg + delta/N;
%         delta2 = Y - avg;
%         m2 = m2 + delta*delta2;
%         sn = sqrt(m2/(N-1));
%         %currentSE = sn/sqrt(N);
%         currentSE =  (sn/sqrt(N))*1.96;
%     end
% end
% N