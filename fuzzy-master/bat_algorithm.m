% ======================================================== % 
% Files of the Matlab programs included in the book:       %
% Xin-She Yang, Nature-Inspired Metaheuristic Algorithms,  %
% Second Edition, Luniver Press, (2010).   www.luniver.com %
% ======================================================== %    

% -------------------------------------------------------- %
% Bat-inspired algorithm for continuous optimization (demo)%
% Programmed by Xin-She Yang @Cambridge University 2010    %
% -------------------------------------------------------- %
% Usage: bat_algorithm([20 1000 0.5 0.5]);                 %


% -------------------------------------------------------------------
% This is a simple demo version only implemented the basic          %
% idea of the bat algorithm without fine-tuning the parameters,     % 
% Then, though this demo works very well, it is expected that       %
% this demo is much less efficient than the work reported in        % 
% the following papers:                                             %
% (Citation details):                                               %
% 1) Yang X.-S., A new metaheuristic bat-inspired algorithm,        %
%    in: Nature Inspired Cooperative Strategies for Optimization    %
%    (NISCO 2010) (Eds. J. R. Gonzalez et al.), Studies in          %
%    Computational Intelligence, Springer, vol. 284, 65-74 (2010).  %
% 2) Yang X.-S., Nature-Inspired Metaheuristic Algorithms,          %
%    Second Edition, Luniver Presss, Frome, UK. (2010).             %
% 3) Yang X.-S. and Gandomi A. H., Bat algorithm: A novel           %
%    approach for global engineering optimization,                  %
%    Engineering Computations, Vol. 29, No. 5, pp. 464-483 (2012).  %
% -------------------------------------------------------------------


% Main programs starts here

% Display help
%  help bat_algorithm.m

% Default parameters
clc 
clear all
n=40;      % Population size, typically 10 to 40
N_gen=2 ;  % Number of generations
A=0.9;      % Loudness  (constant or decreasing)
r=1;      % Pulse rate (constant or decreasing)
% ev=0;
% ew=0;
% This frequency range determines the scalings
% You should change these values if necessary
Qmin=0;         % Frequency minimum
Qmax=1;         % Frequency maximum
% Iteration parameters
N_iter=0;       % Total number of function evaluations
% Dimension of the search variables
d=40;           % Number of dimensions 
% Lower limit/bounds/ a vector
Lb=-1*ones(1,d);
% Upper limit/bounds/ a vector
Ub=1*ones(1,d);
% Initializing arrays
Q=zeros(n,1);   % Frequency
v=zeros(n,d);   % Velocities

sys= find_system('Name','ProbotISCI2016');

open_system('ProbotISCI2016');


set_param(gcs,'SimulationCommand','start');



pause(6);
% set_param(gcs,'SimulationCommand','Start');
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


% Find the initial best solution
[fmin,I]=min(Fitness);
best=Sol(I,:);

% ======================================================  %
% Note: As this is a demo, here we did not implement the  %
% reduction of loudness and increase of emission rates.   %
% Interested readers can do some parametric studies       %
% and also implementation various changes of A and r etc  %
% ======================================================  %

% Start the iterations -- Bat Algorithm (essential part)  %
for t=1:N_gen, 
% Loop over all bats/solutions
        for i=1:n,
          Q(i)=Qmin+(Qmin-Qmax)*rand;
          v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
          S(i,:)=Sol(i,:)+v(i,:);
          % Apply simple bounds/limits
          Sol(i,:)=simplebounds(Sol(i,:),Lb,Ub);
          % Pulse rate
          if rand>r
          % The factor 0.001 limits the step sizes of random walks 
              S(i,:)=best+0.001*randn(1,d);
          end

     % Evaluate new solutions
%            sys= find_system('Name','ProbotISCI2016');

%             open_system('ProbotISCI2016');
% 
%             set_param('sumar/Constant','Value','5')
%             pause(2);
%            set_param(gcs,'SimulationCommand','Start');
           set_param(gcs,'SimulationCommand','start')
           pause(1);
                
           Fnew=Fun(S(i,:),data);
            if (Fnew<0.5)
                break
            end
     % Update if the solution improves, or not too loud
           if (Fnew<=Fitness(i)) %& (rand<A) ,
                Sol(i,:)=S(i,:);
                Fitness(i)=Fnew;
           end

          % Update the current best solution
          if Fnew<=fmin,
                best=S(i,:);
                fmin=Fnew;
          end
          plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
          
        end
        N_iter=N_iter+n;
        if (Fnew<0.5)
                break
        end
       
end

disp('end');
% Output/display
% disp(['Number of evaluations: ',num2str(N_iter)]);
% disp(['Best =',num2str(best),' fmin=',num2str(fmin)]);

% Application of simple limits/bounds

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Objective function: your own objective function can be written here
% Note: When you use your own function, please remember to 
%       change limits/bounds Lb and Ub (see lines 52 to 55) 
%       and the number of dimension d (see line 51). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% ============ end ====================================
