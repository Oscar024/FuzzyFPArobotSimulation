%Generación de individuos en la población
clear all
clc
n=22; %Population size, typically 10 to 25
A=0.25; %Loudness (constant or decreasing)
r=0.5; %Pulse rate (constant or decreasing)
% This frequency range determines the scaling
Qmin=0; %Frequency minimum
Qmax=2; %Frequency maximum
%Iteration parameters
tol=10^(-6); %Stop tolerance
N_iter=0; % Total number of functions evaluations
% Dimension of search variables
d=33;
%Initial arrays 
Q=zeros(n,1); %Frequency
v=zeros(n,d); %Velocities

%Initialize the population/solutions
for i=1:n
%   Generate a 10-by-1 column vector of uniformly distributed numbers in the interval (-5,5).
    r = -1 + (1+1)*rand(1,d);
    Sol(i,:)= r;    
end

sorter=sort(Sol);



