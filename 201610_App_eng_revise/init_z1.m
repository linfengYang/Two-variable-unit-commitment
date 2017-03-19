function [z1_k] = init_z1(miqp, dataUC)

opt = 0;

N = miqp.N;
T = miqp.T;

if opt == 1  % 直接用MIQP的解作为z1,z2的初始值

    
    % Use arrays to populate the model    
    cplex_miqp = Cplex('MIQP for UC');
    cplex_miqp.Model.sense = 'minimize';
    cplex_miqp.Model.obj   = miqp.c_UC;  %%%%%
    cplex_miqp.Model.Q = miqp.Q_UC;
    cplex_miqp.Model.lb    = miqp.x_L;
    cplex_miqp.Model.ub    = miqp.x_U;
    cplex_miqp.Model.A =   miqp.A_all;  
    cplex_miqp.Model.lhs = miqp.lhs_all;
    cplex_miqp.Model.rhs = miqp.rhs_all;
    cplex_miqp.Model.ctype = miqp.ctype;
    
    cplex_miqp.Param.mip.tolerances.mipgap.Cur = 1e-5;
    
    cplex_miqp.writeModel('myprob.lp');
    
    cplex_miqp.solve();
    
    x = cplex_miqp.Solution.x;
    
    z1_k = sparse(4*T,N);
    for i = 1:N
        z1_k(:,i) = x( (i-1) * 4*T + 1 :  i * 4*T );
    end
else   % 其他的初始化z1，z2的方法
    z1_k = [];
    for i = 1:N
        tmp = [sparse(1:4*T, 1, 0); ];
        z1_k = [z1_k , tmp];
    end   
end

%%% end of function
end

