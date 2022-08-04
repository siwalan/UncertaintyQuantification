function [Y] = modelFunc(X)

    try
        Y = uq_Beam(X);
    catch 
        Y = nan
    end

end

