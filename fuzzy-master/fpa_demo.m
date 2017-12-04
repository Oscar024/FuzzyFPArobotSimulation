% --------------------------------------------------------------------% 
% Flower pollenation algorithm (FPA), or flower algorithm             %
% Programmed by Xin-She Yang @ May 2012                               % 
% --------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Notes: This demo program contains the very basic components of      %
% the flower pollination algorithm (FPA), or flower algorithm (FA),   % 
% for single objective optimization.    It usually works well for     %
% unconstrained functions only. For functions/problems with           % 
% limits/bounds and constraints, constraint-handling techniques       %
% should be implemented to deal with constrained problems properly.   %
%                                                                     %   
% Citation details:                                                   % 
%1)Xin-She Yang, Flower pollination algorithm for global optimization,%
% Unconventional Computation and Natural Computation,                 %
% Lecture Notes in Computer Science, Vol. 7445, pp. 240-249 (2012).   %
%2)X. S. Yang, M. Karamanoglu, X. S. He, Multi-objective flower       %
% algorithm for optimization, Procedia in Computer Science,           %
% vol. 18, pp. 861-868 (2013).                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
beep off
tic; 

n=23;           % Population size, typically 10 to 25
p=0.8;           % probabibility switch

% Iteration parameters
N_iter=4e4;            % Total number of iterations

% Dimension of the search variables
d=40;
Lb=-1*ones(1,d);
Ub=1*ones(1,d);

parada=9e-7;

sys= find_system('Name','ProbotISCI2016');
open_system('ProbotISCI2016');
set_param(gcs,'SimulationCommand','start');
pause(3);

% Initialize the population/solutions
% for i=1:n,
%   Sol(i,:)=Lb+(Ub-Lb).*rand(1,d);
%   Fitness(i)=Fun(Sol(i,:));
% end

for i=1:n
    r = -1 + (1+1)*rand(1,d);
    Sol(i,:)= r; 
    Fitness(i)=Fun(Sol(i,:),data); 
    x=0;
end

% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
S=Sol; 

% Start the iterations -- Flower Algorithm 
for t=1:N_iter,
        % Loop over all bats/solutions
        
               
        for i=1:n,
          % Pollens are carried by insects and thus can move in
          % large scale, large distance.
          % This L should replace by Levy flights  
          % Formula: x_i^{t+1}=x_i^t+ L (x_i^t-gbest)
          if rand>p,
          %% L=rand;
          L=Levy(d);
          dS=L.*(Sol(i,:)-best);
          S(i,:)=Sol(i,:)+dS;
          
          % Check if the simple limits/bounds are OK
          S(i,:)=simplebounds(S(i,:),Lb,Ub);
          
          % If not, then local pollenation of neighbor flowers 
          else
              epsilon=rand;
              % Find random flowers in the neighbourhood
              JK=randperm(n);
              % As they are random, the first two entries also random
              % If the flower are the same or similar species, then
              % they can be pollenated, otherwise, no action.
              % Formula: x_i^{t+1}+epsilon*(x_j^t-x_k^t)
              S(i,:)=S(i,:)+epsilon*(Sol(JK(1),:)-Sol(JK(2),:));
              % Check if the simple limits/bounds are OK
              S(i,:)=simplebounds(S(i,:),Lb,Ub);
          end
          
          set_param(gcs,'SimulationCommand','start')
          pause(0.020);
          % Evaluate new solutions
           Fnew=Fun(S(i,:),data);
%            if (Fnew<parada)
%                 break
%            end
           
%            Fnew=Fun(S(i,:));
          % If fitness improves (better solutions found), update then
            if (Fnew<=Fitness(i)),
                Sol(i,:)=S(i,:);
                Fitness(i)=Fnew;
           end
           
          % Update the current global best
          if Fnew<=fmin,
                best=S(i,:)   ;
                fmin=Fnew   ;
                disp(['Total number of iterations: ',num2str(t)]);
                disp('Current best: ');
                disp(fmin);
                
          end
          subplot(5,1,5);
          plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
          %Break 1 
          
%           disp('Current best: ');
%           disp (fmin);  
           if (fmin<parada)
                break
           end

        end
        
        
        % Display results every 100 iterations
        if round(t/100)==t/100,
            best
            fmin
        end
        
        if (fmin<parada)
                break
        end
       
end

tiempo = toc; 
fprintf('El proceso ha tardado %d segundos', tiempo);
beep on
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

% Application of simple constraints



% Objective function and here we used Rosenbrock's 3D function
% function z=Fun(u)
%     % Sphere function with fmin=0 at (0,0,...,0)
%     z=sum(u.^2);
% end


