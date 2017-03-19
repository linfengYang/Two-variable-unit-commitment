function new_dataUC = expend(dataUC, time, t_time)
if dataUC.expended == 1
    printf('This system have been expended, so it can not be expended again!');
    new_dataUC = dataUC; 
else
    new_dataUC = dataUC;
    %%%%  下面扩展系统，根据机组倍数，还有时段倍数
    if (time>1)
        
        new_dataUC.expended = 1;

        new_dataUC.N = dataUC.N*time;
        
        new_dataUC.alpha = []; new_dataUC.beta = []; new_dataUC.gamma = []; new_dataUC.p_low =[]; new_dataUC.p_up = [];
        new_dataUC.Cold_hour = []; new_dataUC.Hot_cost =[]; new_dataUC.Cold_cost =[]; new_dataUC.time_on_off_ini = [];new_dataUC.time_min_on =[];
        new_dataUC.time_min_off =[]; new_dataUC.u0 =[]; new_dataUC.p_startup =[]; new_dataUC.p_rampup=[]; new_dataUC.p_shutdown =[];
        new_dataUC.p_rampdown =[];  new_dataUC.p_initial =[];
        for i = 1:dataUC.N
            new_dataUC.alpha = [new_dataUC.alpha;dataUC.alpha(i)*ones(time,1)];new_dataUC.beta = [new_dataUC.beta;dataUC.beta(i)*ones(time,1)];new_dataUC.gamma = [new_dataUC.gamma;dataUC.gamma(i)*ones(time,1)];
            new_dataUC.p_low = [new_dataUC.p_low;dataUC.p_low(i)*ones(time,1)];new_dataUC.p_up = [new_dataUC.p_up;dataUC.p_up(i)*ones(time,1)];
            
            new_dataUC.Cold_hour = [new_dataUC.Cold_hour;dataUC.Cold_hour(i)*ones(time,1)];
            
            new_dataUC.Hot_cost = [new_dataUC.Hot_cost;dataUC.Hot_cost(i)*ones(time,1)];new_dataUC.Cold_cost = [new_dataUC.Cold_cost;dataUC.Cold_cost(i)*ones(time,1)];
            
            new_dataUC.time_on_off_ini = [new_dataUC.time_on_off_ini;dataUC.time_on_off_ini(i)*ones(time,1)];
            new_dataUC.time_min_on = [new_dataUC.time_min_on;dataUC.time_min_on(i)*ones(time,1)];
            new_dataUC.time_min_off = [new_dataUC.time_min_off;dataUC.time_min_off(i)*ones(time,1)];
            new_dataUC.u0 = [new_dataUC.u0;dataUC.u0(i)*ones(time,1)];
            
            new_dataUC.p_startup=[new_dataUC.p_startup;dataUC.p_startup(i)*ones(time,1)];   new_dataUC.p_rampup=[new_dataUC.p_rampup;dataUC.p_rampup(i)*ones(time,1)];
            new_dataUC.p_shutdown=[new_dataUC.p_shutdown;dataUC.p_shutdown(i)*ones(time,1)];   new_dataUC.p_rampdown=[new_dataUC.p_rampdown;dataUC.p_rampdown(i)*ones(time,1)];
            new_dataUC.p_initial=[new_dataUC.p_initial;dataUC.p_initial(i)*ones(time,1)];
        end
        
        
        new_dataUC.PD = new_dataUC.PD * time;
        new_dataUC.spin = new_dataUC.spin * time;
        
    end
    
    if (t_time >1 )
        
        new_dataUC.expended = 1;
        
        new_dataUC.T = dataUC.T*t_time;
        
        new_dataUC.PD = [];
        new_dataUC.spin = [];
        
        PD_insert = 1;
        PD_copy = 0;
        
        %%%对pd0*time后进行进行插值
        if PD_insert == 1
            PD_ini = [dataUC.PD(1)*1;dataUC.PD];
            spin_ini = [dataUC.spin(1)*1;dataUC.spin];

            for i=2:25
                a       = PD_ini(i-1);
                b       = PD_ini(i);
                deltaPD = (b-a)/t_time;
                c = spin_ini(i-1);
                d = spin_ini(i);
                delta_spin = (d-c)/t_time;
                for j=1:t_time
                    new_dataUC.PD = [new_dataUC.PD;a+j*deltaPD];
                    new_dataUC.spin = [new_dataUC.spin; c+j*delta_spin];
                end
            end
        end
        
        % 对pd0*time后 copy扩展t_time次，
        if PD_copy == 1
            PD1=time*dataUC.PD;
            spin1 = time*dataUC.spin;
            for i=1:t_time
                new_dataUC.PD = [new_dataUC.PD;PD1];
                new_dataUC.spin = [new_dataUC.spin;spin1];
            end
            new_dataUC.PD = new_dataUC.PD(1:new_dataUC.T);
            new_dataUC.spin = new_dataUC.spin(1:new_dataUC.T);
            new_dataUC.spin = new_dataUC.spin + new_dataUC.PD *0.00;
        end
    end
end
end
