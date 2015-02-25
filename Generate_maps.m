clc;
clear all;
close all;

CityNumber = 50;            % number of cities
LengthOfArea = 1;          %square area
Thershold = 0;              % distance akceptable to end algorithm

%%
% parameters of algorithm
NumberOfGenerations = 5000;            % maximum numbers of generations
InitialTemp = 5;                        % Initial temperature
CoolingRate = 0.9;                      % cooling rate of Simulated Annealing
NumberOfCitiesToSwap = CityNumber;      % initializated number of city swap in Simulated Annealing

%%
Cities = LengthOfArea * rand(2,CityNumber);                % randomly distribute cities


DistanceBefore = distance(Cities);           % distance if consider trace look like 1,2,3,4,5...

figure(1)
plotcities (Cities)

%% optymalization

tic
[CitiesAfterOPT, Parameters] = simulatedannealing(Cities, InitialTemp, CoolingRate, Thershold, NumberOfGenerations, NumberOfCitiesToSwap); %
Duration = toc
DistanceAfter = distance(CitiesAfterOPT);       % distance after optymalization 
Improvement = DistanceBefore / DistanceAfter    % improvement of optymalization process
figure(2)
plotcities (CitiesAfterOPT)

%%
figure(3)
subplot(3,1,1);
plot(Parameters.distance);
xlabel('Iteration')
ylabel('Distance')
subplot(3,1,2);
plot(Parameters.temperature);
xlabel('Iteration')
ylabel('Temperature')
subplot(3,1,3);
plot(Parameters.numberofcitiestoswap);
xlabel('Iteration')
ylabel('Number Of Cities To Swap')

