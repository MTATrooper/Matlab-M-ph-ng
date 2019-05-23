function SET_GLOBAL_VARIABLES()
global EnvironmentWidth ImageWidth SafeDistance AlignmentRange CohesionRange...
    wanderAngle FleeDistance SpeedCorrection ...
    BoidsNum Boids TargetsNum Targets D_BehindLeader ObstaclesNum Obstacles...
    ArmyRed ArmyBlue TargetH blueImg redImg heliImg HeliWidth;

%% change global variables here (use user input or something)
EnvironmentWidth = 400;
ImageWidth = EnvironmentWidth/10;
HeliWidth = EnvironmentWidth/6;
SafeDistance = EnvironmentWidth/20; % set separation range
AlignmentRange = EnvironmentWidth/5; % set alignment range
CohesionRange = EnvironmentWidth/4; % set cohesion range
wanderAngle = 5;
FleeDistance = 80;
SpeedCorrection = 100;
%Number of Boids
BoidsNum = 300;
%Number of Targets
TargetsNum = 1;
D_BehindLeader = 130;

blueImg = zeros(1,14);
blueImg(1,:) = 0;

redImg = zeros(1,14);
redImg(1,:) = 0;

heliImg = 0;
%%Tao vi tri quan do
ArmyRed = zeros(50,14);
ArmyRed(1,1)= -100;
ArmyRed(2,1)= -66.66;
ArmyRed(3,1)= -33.33;
ArmyRed(4,1)= -0;
ArmyRed(5,1)= 33.33;
ArmyRed(6,1)= 66.66;
ArmyRed(7,1)= 100;
ArmyRed(:,2)= 300;
ArmyRed(8,1) = 0;
ArmyRed(8,2) = -200;
ArmyRed(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
ArmyRed(:,10) = 2;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
ArmyRed(:,11) = 0.2; % set maxforce
ArmyRed(:,13) = 200; % set max see ahead
ArmyRed(:,14) = 10; % set max avoid force
%Tao vi tri quan xanh
ArmyBlue = zeros(50,14);
ArmyBlue(1,1) = -100;
ArmyBlue(1,2) = -80;
ArmyBlue(2,1) = 100;
ArmyBlue(2,2) = -80;
ArmyBlue(3,1) = 0;
ArmyBlue(3,2) = -150;
ArmyBlue(4,1) = 50;
ArmyBlue(4,2) = -200;
ArmyBlue(5,1) = -50;
ArmyBlue(5,2) = -200;
ArmyBlue(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
ArmyBlue(:,10) = 2;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
ArmyBlue(:,11) = 0.2; % set maxforce
ArmyBlue(:,13) = 200; % set max see ahead
ArmyBlue(:,14) = 10; % set max avoid force
%% Tao vi tri may bay
TargetH(1) = 0;%rand([TargetsNum,2])-1; % set random position
TargetH(2) = 300;
TargetH(4:5) = 2*(2*rand([TargetsNum,2])-1); % set random velocity
TargetH(10) = 2; % set maxspeed
TargetH(11) = 2; % set maxforce
TargetH(13) = 20; % set max see ahead
TargetH(14) = 2; % set max avoid force

%% Boids data
%List of Boids
Boids = zeros(BoidsNum,14); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision avoidance)
%}
%Boids(:,1:2) = EnvironmentWidth*(2*rand([BoidsNum,2])-1); % set random position
Boids(:,1) = -400;
Boids(:,2) = 300;
Boids(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Boids(:,10) = 2;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Boids(:,11) = 0.2; % set maxforce
Boids(:,13) = 200; % set max see ahead
Boids(:,14) = 10; % set max avoid force

%% Targets data. The targets may be leaders, persuaders... that the flock of agents want to follow.
%List of targets
Targets = zeros(TargetsNum,14);
Targets(:,1:2) = rand([TargetsNum,2])-1; % set random position
Targets(:,4:5) = 2*(2*rand([TargetsNum,2])-1); % set random velocity
Targets(:,10) = 2; % set maxspeed
Targets(:,11) = 2; % set maxforce
Targets(:,13) = 20; % set max see ahead
Targets(:,14) = 2; % set max avoid force

%% Set static Obstacle data
ObstaclesNum = 1;
Obstacles = [0 0 0 0];

%Predefined Obstacles
% Obstacles = [300 200 0 30;
%              -100 200 0 45;
%              200 -200 0 50];

%{1-3 position of obstacle, 4: radius
