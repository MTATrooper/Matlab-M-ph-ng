function Boid_simulation ()
%% Global variables
global TimeSteps;
TimeSteps = 50000;
global BoidsNum;

% Set global variables
SET_GLOBAL_VARIABLES()

%% -------------------BEGIN IMPLEMENTATION--------------------------------
    BoidsNum = 1;
    Behaviour__Seek();
    BehaviorMain();
end
%---------------------- END IMPLEMENTATION------------------------------
