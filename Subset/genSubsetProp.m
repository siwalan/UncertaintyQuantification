function [proposal, status] = genSubsetProp(seeds,marg,RV_parameters,Lo,iLo,proposal_Parameters)
    proposal_PDF_Type = proposal_Parameters(1);
    U = x_to_u(seeds,marg,RV_parameters,iLo);
    proposal =zeros(size(marg,1),1);
    for varIter = 1:size(marg,1)
        if proposal_PDF_Type == 1
            currentSeed = seeds(varIter);
            cRV_Parameters = RV_parameters(varIter,:);
            cMarg = marg(varIter);
            w =1;
            mean_val = U(varIter);
            prop = unifrnd(mean_val-w, mean_val+w);
            tempU = U;
            tempU(varIter) = prop;
            X_prop = u_to_x(tempU,marg,RV_parameters,Lo);
            X_prop = X_prop(varIter);
            top = getPDF(X_prop,cMarg,cRV_Parameters);
            bottom = getPDF(currentSeed,cMarg,cRV_Parameters);
            r = top/bottom;
            r = min(1,r);
            if rand <= r
                proposal(varIter) = X_prop;
                status = 1;
            else
                proposal(varIter) = currentSeed;
                status = 0;
            end
        elseif proposal_PDF_Type == 2

        end
    end


end

