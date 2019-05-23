function Behaviour__Seek_ComeBack ()
%% global variables
global TimeSteps;
global BoidsNum;
global Boids;
global HeliWidth;
global Helicopter;
global heliImg;
%% ma bay
delete(Helicopter);
[v_Image, ~, v_Alpha]	= imread('helicopter22.png');
v_Image = imresize(v_Image, [HeliWidth HeliWidth], 'lanczos3' );
v_Alpha = imresize(v_Alpha, [HeliWidth HeliWidth], 'lanczos3' );
angle = atan(Boids(1,2) / Boids(1,1)) * 180 / pi - 90;	% imrotate rotates ccw     
img_i = imrotate(v_Image, angle);
alpha_i = imrotate(v_Alpha, angle );
BoidsPlot(1) = image(Boids(1,1)- HeliWidth/2, Boids(1,2)-HeliWidth/2, img_i);
BoidsPlot(1).AlphaData = alpha_i;
heliImg = BoidsPlot(1);
%% target is optional, if target is undefined,
% then get mouse position on move cursor as target

Target(1) = 400;%rand([TargetsNum,2])-1; % set random position
Target(2) = 300;
Target(4:5) = 2*(2*rand([1,2])-1); % set random velocity
Target(10) = 2; % set maxspeed
Target(11) = 2; % set maxforce
Target(13) = 20; % set max see ahead
Target(14) = 2; % set max avoid force

SaveTarget = plot(Target(1), Target(2), '.','MarkerSize',1, 'MarkerFaceColor','w','Color','w');

%% calculate agents' positions to move to each iteration
timeTick = 1;

while (timeTick < TimeSteps)
    Boids = updateAtBoundary(Boids,1);
    %Steering Force
    CurrentBoid = Boids(1, :);
    force = steer_seek(CurrentBoid, Target);
    Boids(1,:) = applyForce(CurrentBoid, force);
    
    % redraw
    RedrawGraphics(Boids,BoidsNum,v_Image,v_Alpha,BoidsPlot);
    timeTick = timeTick+1;
    if(dist(Boids(1,:),Target(:)) < 40)
        delete(heliImg);
        break;
    end
end
end