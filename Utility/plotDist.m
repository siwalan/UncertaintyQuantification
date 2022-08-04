result = [];
for i=1:10000
    marg =1;parameter =[204 20.4 0 0];
    parameter = distribution_parameter(marg,parameter);
    Y =generateRandomNumber(marg,parameter);
    result = [result; Y];
end
histogram(result./204,'Normalization','pdf')
hold on;

result = [];
for i=1:10000
    marg =2;parameter =[204 20.4 0 0];
    parameter = distribution_parameter(marg,parameter);
    Y =generateRandomNumber(marg,parameter);
    result = [result; Y];
end
histogram(result./204,'Normalization','pdf')