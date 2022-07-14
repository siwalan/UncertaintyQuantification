function Y = GradientComputation(X,parameter)
vars_size = length(X);
Gradient = zeros(vars_size,1);
    for var_iterator = 1:vars_size
        varPerturbed = X(var_iterator);
        stepSize = parameter(var_iterator,2)/200;
        x = X;
        x(var_iterator) = varPerturbed + stepSize;
        G_forward = modelFunc(x);
        x = X;
        x = X;
        x(var_iterator) = varPerturbed - stepSize;
        G_backward = modelFunc(x);
        Gradient(var_iterator) = (G_forward - G_backward)/(2*stepSize);
    end
Y = Gradient;
end
