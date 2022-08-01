function Y = GradientComputation(X,parameter,type)
vars_size = length(X);
Gradient = zeros(vars_size,1);
for var_iterator = 1:vars_size
    varPerturbed = X(var_iterator);
    if type == 'cd'
        G_forward = nan
        G_backward = nan;
        stepSize_Controller = 1;
        while (isnan(G_forward) || isnan(G_backward))
            stepSize = parameter(var_iterator,2)/(stepSize_Controller*200);
            x = X;
            x(var_iterator) = varPerturbed + stepSize;
            G_forward = modelFunc(x);
            x(var_iterator) = varPerturbed - stepSize;
            G_backward = modelFunc(x);

            if (isnan(G_forward) || isnan(G_backward))
                stepSize_Controller = stepSize_Controller +1;
            end
        end
        Gradient(var_iterator) = (G_forward - G_backward)/(2*stepSize);
    elseif type ='fd'
        G_forward = nan
        stepSize_Controller = 1;
        while (isnan(G_forward) )
            stepSize = parameter(var_iterator,2)/(stepSize_Controller*200);
            x = X;
            x(var_iterator) = varPerturbed + stepSize;

            G_forward = modelFunc(x);
            if (isnan(G_forward))
                stepSize_Controller = stepSize_Controller +1;
            end
        end
        Gradient(var_iterator) = (G_forward)/(stepSize);
    elseif type = 'bd'
        G_backward = nan;
        stepSize_Controller = 1;
        while ( isnan(G_backward))
            stepSize = parameter(var_iterator,2)/(stepSize_Controller*200);
            x = X;
            x(var_iterator) = varPerturbed - stepSize;
            G_backward = modelFunc(x);

            if ( isnan(G_backward))
                stepSize_Controller = stepSize_Controller +1;
            end
        end
        Gradient(var_iterator) = (G_backward)/(stepSize);
    end
end
end
