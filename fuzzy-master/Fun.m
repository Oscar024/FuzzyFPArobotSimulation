function z=Fun(u0 , data)
% Sphere function with fmin=0 at (0,0,...,0)

        
        u0 = sort(u0);        
        a = readfis('BaseRobotFA.fis');
        
        %Ordena los valore de forma ascendente que ayuda al traslape de la funcion
        u0 = sort(u0);
        %Cambiar los parametros de las funciones de membresia
        a.input(1).mf(1).params = [-1.72  u0(5) u0(7) u0(15)];
        a.input(1).mf(2).params = [u0(11) u0(22) u0(30)];
        a.input(1).mf(3).params = [u0(23) u0(31) u0(35) 1.72];
        a.input(2).mf(1).params = [-1.72 u0(6) u0(8) u0(16)];
        a.input(2).mf(2).params = [u0(12) u0(21) u0(29)];
        a.input(2).mf(3).params = [u0(24) u0(32) u0(36) 1.72];
        a.output(1).mf(1).params = [-1.8 u0(9) u0(12)];
        a.output(1).mf(2).params = [u0(13) u0(20) u0(28)];
        a.output(1).mf(3).params = [u0(25) u0(33) 1.8];
        a.output(2).mf(1).params = [-1.8 u0(10) u0(18)];
        a.output(2).mf(2).params = [u0(14) u0(19) u0(27)];
        a.output(2).mf(3).params = [u0(26) u0(34) 1.8];

        ruleList=[1 1 1 1;
          1 2 1 1;
          1 3 1 1;
          2 1 1 1;
          2 2 1 1;
          2 3 1 1;
          3 1 1 1;
          3 2 1 1;
          3 3 1 1];
      
        vmse = mse(data.signals.values(:,2) - data.signals.values(:,1));%llanta una
        wmse = mse(data.signals.values(:,4) - data.signals.values(:,3));%llanta dos
    
        best= vmse + wmse;
%         disp('Current best: ');
%         disp (best);
        save('a');
        writefis(a,'BaseRobotFA.fis');
        m1 = readfis('BaseRobotFA.fis');
        
        subplot(5,1,1); plotmf(m1,'input',1);
        subplot(5,1,2); plotmf(m1,'input',2);
        subplot(5,1,3); plotmf(m1,'output',1);
        subplot(5,1,4); plotmf(m1,'output',1);
        
        
        
z=best;