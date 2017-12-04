%Pruebas para cambiar los parámetros de las funciones de membresía de 
% un sistema difuso

a = readfis('controlador1.fis');

% Funciones de membresía de la entrada, tiene sus restricciones
a.input(1).mf(1).params = [-1.8 -1 -0.6]; %Rango [-1.8 -1 -0.986], [-1.8 -1 0.99]
a.input(1).mf(2).params =  [-0.8 0 0.8]; %[-1.01 0 0.8] , [-0.0143 0 0.8]
a.input(1).mf(3).params =  [0 1 1.8]; %[-0.871 -0.855 0.0918] , [-0.871 0.92 0.998]

%Funciones de membresía de salida1 Vl (Velocidad lineal left). (Sacar la
%velocidad mínima y la velocidad máxima en la vida real).
a.output(1).mf(1).params =   [-40 0 40];
a.output(1).mf(2).params =  [10 50 90];
a.output(1).mf(3).params =  [50 100 140];

%Funciones de membresía de salida1 Vr (Velocidad lineal Right). (Sacar la
%velocidad mínima y máximo en la vida real). 
a.output(2).mf(1).params =  [-40 0 40];
a.output(2).mf(2).params =   [10 50 90];
a.output(2).mf(3).params =   [60 100 140];

save('a');
writefis(a,'controlador1.fis');



