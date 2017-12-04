function [ fmin ] = fpa_algorithm( data )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%                     clear all;
%                 clc;
%                 beep off

                n=20;           % Population size, typically 10 to 25
                p=0.7;           % probabibility switch

                % Iteration parameters
                N_iter=10;            % Total number of iterations

                % Dimension of the search variables
                d=40;
                Lb=-1*ones(1,d);
                Ub=1*ones(1,d);

                parada=0.1564;

%                 sys= find_system('Name','ProbotISCI2016');
%                 open_system('ProbotISCI2016');
%                 set_param(gcs,'SimulationCommand','start');
%                 pause(4);

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
                        disp(['Total number of iterations: ',num2str(t)]);
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
                                disp('Current best: ');
                                disp(fmin);

                          end
                          
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


               




end

