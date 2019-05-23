function Behaviour__Seek ()
%% global variables
global TimeSteps;
global BoidsNum;
global Boids;
global ArmyBlue;
%% first draw
[v_Image,v_Alpha,BoidsPlot,fHandler] = InitializeGraphics();
[b_Image,b_Alpha,r_Image,r_Alpha, BluePlot, RedPlot]=InitializeArmyBlue_Victim();

%% target is optional, if target is undefined,
% then get mouse position on move cursor as target

Target = [0 300 0];
Target1 = zeros(5,14);
Target1(1,1)= -100;Target1(1,2)= -80;
Target1(2,1)= 100;Target1(2,2)= -80;
Target1(3,1)= 0;Target1(3,2)= -150;
Target1(4,1)= 50;Target1(4,2)= -200;
Target1(5,1)= -50;Target1(5,2)= -200;

SaveTarget = plot(Target(1), Target(2), '.','MarkerSize',1, 'MarkerFaceColor','w','Color','w');

%% calculate agents' positions to move to each iteration
timeTick = 1;

while (timeTick < TimeSteps)
    for i = 1:5
        CurrentBoid = ArmyBlue(i, :);
        force = steer_seek(CurrentBoid, Target1(i,:));
        ArmyBlue(i,:) = applyForce(CurrentBoid, force);
        % redraw
    end
    RedrawGraphics(ArmyBlue,5,b_Image,b_Alpha,BluePlot);
    Boids = updateAtBoundary(Boids,1);
    if(Boids(1,1)>0)
        for i=1:5
            delete(BluePlot(i));
        end
        delete(RedPlot(8));
        break;
    end
    %Steering Force
    CurrentBoid = Boids(1, :);
    force = steer_seek(CurrentBoid, Target);
    Boids(1,:) = applyForce(CurrentBoid, force);
    % redraw
    RedrawGraphics(Boids,BoidsNum,v_Image,v_Alpha,BoidsPlot);
    timeTick = timeTick+1;
end
end