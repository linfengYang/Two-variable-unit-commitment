function  printout( x, dataUC, flag )
if flag == 1
    disp('-----------------------------start output--------------------------------------------');
    disp('*********************************************************************************');
    
    
    
    N = dataUC.N;
    T = dataUC.T;
    
    array_u = [];
    array_p_wan = [];
    array_s = [];
    array_S_wan = [];
    
    for i = 1:N
        x_i = x(:,i);
        
        u_k_i = x_i(1:T);
        array_u = [array_u; u_k_i'];
        
        p_wan_k_i = x_i(T+1:2*T);
        array_p_wan = [array_p_wan; p_wan_k_i'];
        
        s_k_i = x_i(2*T+1:3*T);
        array_s = [array_s; s_k_i'];
        
        S_wan_k_i = x_i(3*T+1:4*T);
        array_S_wan = [array_S_wan; S_wan_k_i'];
    end
    
    format_str_int = [];
    for t = 1:T
        format_str_int = strcat(format_str_int, '%8d');
    end
    format_str_int = strcat(format_str_int, '\n');
    format_str_f = [];
    for t = 1:T
        format_str_f = strcat(format_str_f, '%8.2f');
    end
    format_str_f = strcat(format_str_f, '\n');
    
    
    %% Êä³ö u_k
    u = array_u;
    disp('*********************************************************************************');
    disp('           **********   final  value  of  u    **********');
    
    fprintf(['       ', format_str_int],1:T);
    for i=1:N
        fprintf(['%4d   ', format_str_f],i,full((u(i,:))));
        %         disp('---------------------------------------------------------------------------------');
    end
    
    
    %% Êä³öp_wan_k
    p = array_p_wan;
    disp('*********************************************************************************');
    disp('           **********   final  value  of  p    **********');
    fprintf(['       ', format_str_int],1:T);
    for i=1:N
        %     if i>1 & (sum(abs(p(i,:) - p(i-1,:)))>1)
        fprintf(['%4d   ', format_str_f],i,full((p(i,:))));
        %     end
        %     disp('---------------------------------------------------------------------------------');
    end
    
    
    
    %% Êä³öp_k
    p = array_p_wan;
    for i = 1:N
        p(i,:) = u(i,:).*dataUC.p_low(i)+(dataUC.p_up(i)-dataUC.p_low(i))* p(i,:);
    end
    disp('*********************************************************************************');
    disp('           **********   final  value  of  p    **********');
    fprintf(['       ', format_str_int],1:T);
    for i=1:N
        %     if i>1 & (sum(abs(p(i,:) - p(i-1,:)))>1)
        fprintf(['%4d   ', format_str_f],i,full((p(i,:))));
        %     end
        %     disp('---------------------------------------------------------------------------------');
    end
end
end

