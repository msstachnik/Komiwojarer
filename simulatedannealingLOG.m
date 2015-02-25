function [City, Parameters] = simulatedannealingLOG(Inputcities,Initial_Temperature,...
    CoolingRate,Threshold,MaxIterations,NumberOfCitiesToSwap)
% SIMULATEDANNEALING
% S = SIMULATEDANNEALING(inputcities,initial_temperature,cooling_rate)
% returns the new configuration of cities with an optimal solution for the
% traveling salesman problem for n cities. 
%
%The input arguments are
% INPUTCITIES         - The cordinates for n cities are represented as 2
%                       rows and n columns and is passed as an argument for
%                       SIMULATEDANNEALING.
% INITIAL_TEMPERATURE - The initial temperature to start the
%                       simulatedannealing process.
% COOLING_RATE        - Cooling rate for the simulatedannealing process. 
%                       Cooling rate should always be less than one.
% THRESHOLD           - Threshold is the stopping criteria and it is the
%                       acceptable distance for n cities.
% MaxIterations       - Maximum of Iteration in algorithm
% NUMBEROFCITIESTOSWAP- Specify the maximum number of pair of cities to
%                       swap. As temperature decreases the number of cities
%                       to be swapped decreases and eventually reaches one
%                       pair of cities.

% Keep the count for number of iterations.


% Set the current temperature to initial temperature.
temperature = Initial_Temperature;

% This is specific to TSP problem. In this algorithm as the temperature
% decreases the number of pairs of cities to swap reduces. Which means as
% the temperature cools down the search is carried without by gradient
% descent and search is carried out locally.

% Initialize the iteration number.


% This is a flag used to cool the current temperature after 10 iterations
% irrespective of wether or not the function is minimized. This is my
% receipie and done based on my experience. This is not part of the
% original algorithm.
if nargout == 2
    Parameters.distance = [];
    Parameters.numberofcitiestoswap = [];
    Parameters.temperature = [];
end
iteration = 0;  %iteration of all alhorithm
True_iteration = 0 ; %iteration of positive condition
    

% This is my objective function, the total distance for the routes.
previous_distance = distance(Inputcities);
City = Inputcities;
while previous_distance > Threshold
    
    temp_cities = swapcities(City,NumberOfCitiesToSwap);
    current_distance = distance(temp_cities);
    diff = abs(current_distance - previous_distance);
    
    if or(current_distance < previous_distance, rand(1) < exp(-diff/(temperature)))
        City = temp_cities;
        if rem(iteration,100) == 0
            plotcities(City);
        end

            temperature = Initial_Temperature / log(exp(1) + True_iteration)* CoolingRate;

            
        
        NumberOfCitiesToSwap = round(NumberOfCitiesToSwap * exp ( -diff / temperature));
        if NumberOfCitiesToSwap < 2
            NumberOfCitiesToSwap = 2;
        end
        
        True_iteration = True_iteration + 1;
        
        % if want to save parameters
        if nargout == 2
            Parameters.distance(True_iteration)= previous_distance;
            Parameters.numberofcitiestoswap(True_iteration)= NumberOfCitiesToSwap;
            Parameters.temperature(True_iteration)= temperature;
            
            if current_distance < previous_distance
                Parameters.case(True_iteration)= 0; % distance case
            else
                Parameters.case(True_iteration)= 1; % propability case
            end

            
        end
        previous_distance = current_distance;
        
    else
        %there is no else
  
    end
    

    
    iteration = iteration + 1;
    if iteration > MaxIterations
        break; % braek conditions
    end
    
      
end