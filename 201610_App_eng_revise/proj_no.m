%%%  ylf in USYD  2016.10.1
%%%  对Applied energy文章修改，验证机组处理上下界约束更好了。
function H_ADMM(pathAndFilename)

%%
clc
% build data for UC
% pathAndFilename='UC_AF/10_std.mod';
pathAndFilename='UC_AF/10_0_1_w.mod';
time = 1;   t_time = 1;
dataUC = readdataUC(pathAndFilename);
dataUC = expend(dataUC, time, t_time);
% dataUC = sub_system(dataUC, 5, 4);

no_proj_dataUC = dataUC;
N = dataUC.N;
T = dataUC.T;


[no_proj_miqp_i, no_proj_miqp] = miqpUC_no_proj(no_proj_dataUC);

% Use arrays to populate the model
cplex_miqp = Cplex('MIQP for UC');
cplex_miqp.Model.sense = 'minimize';
cplex_miqp.Model.obj   = no_proj_miqp.c_UC;  %%%%%
cplex_miqp.Model.Q = no_proj_miqp.Q_UC;
cplex_miqp.Model.lb    = no_proj_miqp.x_L;
cplex_miqp.Model.ub    = no_proj_miqp.x_U;
cplex_miqp.Model.A =   no_proj_miqp.A_all;
cplex_miqp.Model.lhs = no_proj_miqp.lhs_all;
cplex_miqp.Model.rhs = no_proj_miqp.rhs_all;
cplex_miqp.Model.ctype = no_proj_miqp.ctype;

% cplex_miqp.Param.mip.tolerances.mipgap.Cur = 1e-5;
cplex_miqp.Param.threads.Cur = 1;
% cplex_miqp.Param.mip.display.Cur = 4;
cplex_miqp.writeModel('myprob.lp');

cplex_miqp.solve();




end


