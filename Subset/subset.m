targetCOV = 0.01;
currentCOV = Inf;
result = []
N = 0;

parameter = [50 6.25 0 0;60 3 0 0; 1000 200 0 0;];
X_History =[];
while (N < 100)
    N = N+1
    X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
    Y = modelFunc(X');
    result = [result; Y X];
end

ordered_result = sortrows(result,'descend');
po = zeros(N,1);
for i=1:N
    po(i) = (N-i)/N
end
ordered_result = [po ordered_result]

result2 = zeros(10,4,10)
for i=91:100
    parameter = [ordered_result(i,3) 6.25 0 0;ordered_result(i,4) 3 0 0; ordered_result(i,5) 200 0 0;];
    X_History =[];
    N = 0
    while (N < 10)
        N = N+1
        X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
        Y = modelFunc(X');
        result2(N,:,i-90) = [Y X];
    end
end

result3 = reshape(result2,[100 4]);

ordered_result3 = sortrows(result3,'descend');
po = zeros(size(result3,1),1);
for i=1:N
    po(i) = (N-i)/N * 0.1;
end
ordered_result3 = [po ordered_result3]

result4 = zeros(10,4,10)
for i=91:100
    parameter = [ordered_result3(i,3) 6.25 0 0;ordered_result3(i,4) 3 0 0; ordered_result3(i,5) 200 0 0;];
    X_History =[];
    N = 0
    while (N < 10)
        N = N+1
        X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
        Y = modelFunc(X');
        result4(N,:,i-90) = [Y X];
    end
end

result4 = reshape(result4,[100 4]);
ordered_result4 = sortrows(result4,'descend');
po = zeros(size(result4,1),1);
N= 100
for i=1:N
    po(i) = (N-i)/N * 0.01;
end
ordered_result4 = [po ordered_result4]

result5 = zeros(10,4,10)
for i=91:100
    parameter = [ordered_result4(i,3) 6.25 0 0;ordered_result4(i,4) 3 0 0; ordered_result4(i,5) 200 0 0;];
    X_History =[];
    N = 0
    while (N < 10)
        N = N+1
        X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
        Y = modelFunc(X');
        result5(N,:,i-90) = [Y X];
    end
end

result5 = reshape(result5,[100 4]);
ordered_result5 = sortrows(result5,'descend');
po = zeros(size(result5,1),1);
N= 100
for i=1:N
    po(i) = (N-i)/N * 0.001;
end
ordered_result5 = [po ordered_result5]

result6 = zeros(10,4,10)
for i=91:100
    parameter = [ordered_result5(i,3) 6.25 0 0;ordered_result5(i,4) 3 0 0; ordered_result5(i,5) 200 0 0;];
    X_History =[];
    N = 0
    while (N < 10)
        N = N+1
        X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
        Y = modelFunc(X');
        result6(N,:,i-90) = [Y X];
    end
end

result6 = reshape(result6,[100 4]);
ordered_result6 = sortrows(result6,'descend');
po = zeros(size(result6,1),1);
N= 100
for i=1:N
    po(i) = (N-i)/N * 0.0001;
end
ordered_result6 = [po ordered_result6]

result7 = zeros(10,4,10)
for i=91:100
    parameter = [ordered_result6(i,3) 6.25 0 0;ordered_result6(i,4) 3 0 0; ordered_result6(i,5) 200 0 0;];
    X_History =[];
    N = 0
    while (N < 10)
        N = N+1
        X = [normrnd(parameter(1,1), parameter(1,2)), normrnd(parameter(2,1), parameter(2,2)), normrnd(parameter(3,1), parameter(3,2))];
        Y = modelFunc(X');
        result7(N,:,i-90) = [Y X];
    end
end

result7 = reshape(result7,[100 4]);
ordered_result7 = sortrows(result7,'descend');
po = zeros(size(result6,1),1);
N= 100
for i=1:N
    po(i) = (N-i)/N * 0.00001;
end
ordered_result7 = [po ordered_result7]