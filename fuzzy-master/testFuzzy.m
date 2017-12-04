function [ output ] = testFuzzy( u0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

        u0 = sort(u0);        
        a = readfis('BaseRobotFA.fis');
        sys= find_system('Name','ProbotISCI2016');
        open_system('ProbotISCI2016');
        set_param(gcs,'SimulationCommand','start');
        pause(5);
        
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

        
        save('a');
        writefis(a,'BaseRobotFA.fis');
        
        plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
        
        output=-1;
end

