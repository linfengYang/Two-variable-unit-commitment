function dataUC = sub_system(dataUC, N, T)

dataUC.N = N;
dataUC.T = T;

dataUC.alpha = dataUC.alpha(1:N);
dataUC.beta = dataUC.beta(1:N);
dataUC.gamma = dataUC.gamma(1:N);
dataUC.p_low = dataUC.p_low(1:N);
dataUC.p_up = dataUC.p_up(1:N);
dataUC.time_on_off_ini = dataUC.time_on_off_ini(1:N);
dataUC.time_min_on = dataUC.time_min_on(1:N);
dataUC.time_min_off = dataUC.time_min_off(1:N);
dataUC.Cold_hour = dataUC.Cold_hour(1:N);
dataUC.Cold_cost = dataUC.Cold_cost(1:N);
dataUC.Hot_cost = dataUC.Hot_cost(1:N);
dataUC.p_initial = dataUC.p_initial(1:N);
dataUC.p_rampup = dataUC.p_rampup(1:N);
dataUC.p_rampdown = dataUC.p_rampdown(1:N);
dataUC.p_startup = dataUC.p_startup(1:N);
dataUC.p_shutdown = dataUC.p_shutdown(1:N);
dataUC.u0 = dataUC.u0(1:N);

% dataUC.PD = dataUC.PD(1:T) / 1.5;
% dataUC.spin = dataUC.spin(1:T) / 1.5;

dataUC.PD = dataUC.PD(1:T);
dataUC.spin = dataUC.spin(1:T);

end
