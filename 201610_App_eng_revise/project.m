function [ new_dataUC ] = project( dataUC )
if dataUC.projected == 1
    printf('This system have been projected, so it can not be projected again!');
    new_dataUC = dataUC;
else
    new_dataUC = dataUC;
    new_dataUC.projected = 1;
    
    new_dataUC.alpha = dataUC.alpha + dataUC.beta .* dataUC.p_low + dataUC.gamma .* dataUC.p_low .* dataUC.p_low;
    new_dataUC.beta = (dataUC.p_up - dataUC.p_low) .* (dataUC.beta + 2 * dataUC.gamma .* dataUC.p_low);
    new_dataUC.gamma = dataUC.gamma .* (dataUC.p_up - dataUC.p_low) .* (dataUC.p_up - dataUC.p_low);
    
    new_dataUC.p_rampup = dataUC.p_rampup./(dataUC.p_up - dataUC.p_low);
    new_dataUC.p_rampdown = dataUC.p_rampdown ./ (dataUC.p_up - dataUC.p_low);
    new_dataUC.p_startup = (dataUC.p_startup - dataUC.p_low) ./ (dataUC.p_up - dataUC.p_low);
    new_dataUC.p_shutdown = (dataUC.p_shutdown - dataUC.p_low) ./ (dataUC.p_up - dataUC.p_low);
    new_dataUC.p_initial = (dataUC.p_initial - dataUC.u0 .* dataUC.p_low) ./ (dataUC.p_up - dataUC.p_low);
end
end

