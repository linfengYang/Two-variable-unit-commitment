%%%  ylf in USYD  2016.8.31
%%%  form miqp model for UC
%%% 变量排列顺序  机组1：u p_wan s 机组2的 u p_wan s .... 
%%% 约束排列，unit 1的所有约束一组，接着是unit 2的所有约束....

function [ miqp_i, miqp ] = miqpUC( dataUC )
%%%% start of function

N = dataUC.N;   T = dataUC.T;
x_L = cell(N,1);    x_U = cell(N,1);
A = cell(N,1);      b = cell(N,1);
B = cell(N,1);      B_wan = cell(N,1);
Q_UC = cell(N,1);   c_UC = cell(N,1);
ctype = cell(N,1);

DiagE_T_T = sparse(1:T,1:T,1);
for i = 1:N   % 按照机组分块形成约束，对机组i，生成所有其相关约束作为一块
    x_L{i} = sparse(2*T,1);
    x_U{i} = ones(2*T,1);
    
    % unit generation limits 
    A_low_up = [ -DiagE_T_T, DiagE_T_T];
    b_low_up = sparse(T,1);   
    

    % form A_i  b_i
    A{i} = [    A_low_up;
        ];
    b{i} = [    b_low_up;
        ];
    
    % 对功率平衡和旋转备用约束形成约束
    B{i} =  [ sparse(1:T,1:T,-dataUC.p_up(i)), sparse(T, 1*T)];
    B_wan{i} = [sparse(1:T,1:T,dataUC.p_low(i)), sparse(1:T,1:T, dataUC.p_up(i) - dataUC.p_low(i) )];

    % 目标函数
    c_UC{i} = [ dataUC.alpha(i) * ones(T,1); 
                dataUC.beta(i) * ones(T,1); 
                ];
    Q_UC{i} = blkdiag(sparse(T,T), sparse(1:T,1:T, 2*dataUC.gamma(i)));
    
    ctype_ascii_miqp = [66*ones(1,T), 67*ones(1,T)];
    ctype{i} = char(ctype_ascii_miqp);    
end

% 形成功率平衡和备用约束的右端项
c = -(dataUC.PD + dataUC.spin);
c_wan = dataUC.PD;

% 返回分块的模型数据
miqp_i.A = A;           miqp_i.b = b;
miqp_i.B = B;           miqp_i.c = c;
miqp_i.B_wan = B_wan;   miqp_i.c_wan = c_wan;
miqp_i.c_UC = c_UC;     miqp_i.Q_UC = Q_UC;
miqp_i.x_L = x_L;       miqp_i.x_U = x_U;
miqp_i.N = N;           miqp_i.T = T;
miqp_i.ctype = ctype;

% 形成并返回 完整MIQP模型的参数
miqp.A = [];           miqp.b = [];
miqp.B = [];           miqp.c = c;
miqp.B_wan = [];   miqp.c_wan = c_wan;
miqp.c_UC = [];     miqp.Q_UC = [];
miqp.x_L = [];       miqp.x_U = [];
miqp.ctype = [];
for i = 1:N
   miqp.A = blkdiag(miqp.A, A{i});
   miqp.b = [miqp.b; b{i}];
   miqp.B = [miqp.B, B{i}];
   miqp.B_wan = [miqp.B_wan, B_wan{i}];
   miqp.c_UC = [miqp.c_UC; c_UC{i}];
   miqp.Q_UC = blkdiag(miqp.Q_UC, Q_UC{i});
   miqp.x_L = [miqp.x_L; x_L{i}];
   miqp.x_U = [miqp.x_U; x_U{i}];
   miqp.ctype = [miqp.ctype, ctype{i}];
end
miqp.A_all =  [     miqp.A;
                    miqp.B;
%                     miqp.B_wan;
    ];
miqp.lhs_all = [    -inf * ones(size(miqp.A,1),1);
                    -inf * ones(size(miqp.B,1),1);
%                     miqp.c_wan;
    ];
miqp.rhs_all = [    miqp.b;
                    miqp.c;
%                     miqp.c_wan;
    ];
miqp.N = N;
miqp.T = T;

%%%% end of function
end

