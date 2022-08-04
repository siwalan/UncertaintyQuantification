function Y = GradientComputation(Y,X,X_parameter,Gradient_Parameter)
maxGradStepSize = Gradient_Parameter(3);
Verbosity = Gradient_Parameter(4);
vars_size = length(X);
Gradient = zeros(vars_size,1);
fprintf("** Starting Gradient Calculation for Iter %d\n",Gradient_Parameter(1));
for var_iterator = 1:vars_size
    varPerturbed = X(var_iterator);
    if Gradient_Parameter(2) == 0 % Central Diff
        gradStepSize = 1;
        if Verbosity > 1
            fprintf("*** Central Difference Method, Var %d\n", var_iterator);
            fprintf("**** Step size is %d\n", 1/gradStepSize*200);
        end
        G_forward = nan; G_backward = nan;
        while (isnan(G_forward) || isnan(G_backward))
            stepSize = X_parameter(var_iterator,2)/(gradStepSize*200);
            x = X;
            x(var_iterator) = varPerturbed + stepSize;
            G_forward = modelFunc(x);
            x(var_iterator) = varPerturbed - stepSize;
            G_backward = modelFunc(x);
            if (isnan(G_forward) || isnan(G_backward))
                fprintf("***** Gradient Not Found, Reducing Step Size");
                gradStepSize = gradStepSize +1;
            end

            if (gradStepSize > maxGradStepSize)
                fprintf("***** Gradient Calculation Error");
                Y = nan(vars_size,1);
                break
            end
        end
        Gradient(var_iterator) = (G_forward - G_backward)/(2*stepSize);
    elseif Gradient_Parameter(2) == 1 % Forward Diff
        gradStepSize = 1;
        if Verbosity > 1
            fprintf("*** Forward Difference Method, Var %d\n", var_iterator);
            fprintf("**** Step size is %d\n", 1/gradStepSize*200);
        end
        G_forward = nan;
        while (isnan(G_forward) )
            stepSize = X_parameter(var_iterator,2)/(gradStepSize*200);
            x = X;
            x(var_iterator) = varPerturbed + stepSize;

            G_forward = modelFunc(x);
            if (isnan(G_forward))
                fprintf("***** Gradient Not Found, Reducing Step Size\n");
                gradStepSize = gradStepSize +1;
            end

            if (gradStepSize > maxGradStepSize)
                fprintf("***** Gradient Calculation Error\n");
                Y = nan(vars_size,1);
                break
            end
        end
        Gradient(var_iterator) = (G_forward-Y)/(stepSize);
    elseif Gradient_Parameter(2) == 2
        gradStepSize = 1;
        if Verbosity > 1
            fprintf("*** Backward Difference Method, Var %d\n", var_iterator);
            fprintf("**** Step size is %d\n", 1/gradStepSize*200);
        end
        G_backward = nan;
        while ( isnan(G_backward))
            stepSize = X_parameter(var_iterator,2)/(gradStepSize*200);
            x = X;
            x(var_iterator) = varPerturbed - stepSize;
            G_backward = modelFunc(x);

            if ( isnan(G_backward))
                fprintf("***** Gradient Not Found, Reducing Step Size\n");
                gradStepSize = gradStepSize +1;
            end

            if (gradStepSize > maxGradStepSize)
                fprintf("***** Gradient Calculation Error\n");
                Y = nan(vars_size,1);
                break
            end

        end
        Gradient(var_iterator) = (Y-G_backward)/(stepSize);
    end
    if Verbosity > 1
        fprintf("*** Gradient is Found, Advancing to Next Variable\n");
    end
end
fprintf("** Gradient Evaluation Complete\n");

Y = Gradient;
end
