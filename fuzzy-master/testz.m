%Test Fpa demo
clc
clear all

 sys= find_system('Name','ProbotISCI2016');
 open_system('ProbotISCI2016');
 set_param(gcs,'SimulationCommand','start');
  pause(4);
mejor = fpa_algorithm(data);

 m2 = readfis('BaseRobotFA.fis');
figure
subplot(5,1,1); plotmf(m2,'input',1);
subplot(5,1,2); plotmf(m2,'input',2);
subplot(5,1,3); plotmf(m2,'output',1);
subplot(5,1,4); plotmf(m2,'output',1);
subplot(5,1,5);plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
figure
plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
figure
plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
% Output/display
disp(['Total number of evaluations: ',num2str(N_iter*n)]);
disp(['Total number of iterations: ',num2str(t)]);
disp(['Best solution=',num2str(best),'   fmin=',num2str(fmin)]);
save('Abril2018');
disp(mejor);