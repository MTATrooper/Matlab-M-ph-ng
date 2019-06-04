function [v_Image,v_Alpha, d_Image,d_Alpha,BoidsPlot, DoorPlot, fHandler]=InitializeGraphics()
global EnvironmentWidth;
global HeliWidth DoorWidth;
global Boids;
global Helicopter;
global ArtDoor;

[v_Image, ~, v_Alpha]	= imread('helicopter22.png');
v_Image = imresize(v_Image, [HeliWidth HeliWidth], 'lanczos3' );
v_Alpha = imresize(v_Alpha, [HeliWidth HeliWidth], 'lanczos3' );

DoorWidth = EnvironmentWidth/8;
[d_Image, ~, d_Alpha]	= imread('door.png');
d_Image = imresize(d_Image, [DoorWidth DoorWidth], 'lanczos3' );
d_Alpha = imresize(d_Alpha, [DoorWidth DoorWidth], 'lanczos3' );

fHandler = figure;
fHandler.Color = 'white';
fHandler.MenuBar =  'none';
fHandler.ToolBar = 'none';
fHandler.Name = 'UNSW - Boids implementation';
fHandler.NumberTitle = 'off';
rectangle('position',[-EnvironmentWidth -EnvironmentWidth 2*EnvironmentWidth 2*EnvironmentWidth],'EdgeColor','k','LineWidth',1);
hold on
xlabel('X axis')
ylabel('Y axis')
axis manual;
%axis off;
%axis([-EnvironmentMargin EnvironmentWidth+EnvironmentMargin -EnvironmentMargin EnvironmentWidth+EnvironmentMargin]);
axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);

%Ve may bay
    angle = atan(Boids(1,2) / Boids(1,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(v_Image, angle);
    alpha_i = imrotate(v_Alpha, angle );
    BoidsPlot(1) = image(Boids(1,1)- HeliWidth/2, Boids(1,2)-HeliWidth/2, img_i);
    BoidsPlot(1).AlphaData = alpha_i;
    Helicopter = BoidsPlot(1);
%Ve nha
    %ArtHouse = rectangle('Position',[-100 -300 200 200],'EdgeColor','b','LineWidth',2);
    plot([-100 -100],[-100 -300],'b-');
    plot([-100 100],[-300 -300],'b-');
    plot([100 100],[-300 -100],'b-');
    plot([20 100],[-100 -100],'b-');
    plot([-20 -100],[-100 -100],'b-');
    
    % 
    x1 = [250 -400 250 -400];
    y1 = [-400 -400 100 0];
    for i = 1:4
        [h_Image, ~, h_Alpha]	= imread('house.png');
        h_Image = imresize(h_Image, [150 150], 'lanczos3' );
        h_Alpha = imresize(h_Alpha, [150 150], 'lanczos3' );
        angle = 180;%atan(Boids(1,2) / Boids(1,1)) * 180 / pi - 90;	% imrotate rotates ccw     
        img_i = imrotate(h_Image, angle);
        alpha_i = imrotate(h_Alpha, angle );
        house_img(1) = image(x1(i),y1(i),img_i);
        house_img(1).AlphaData = alpha_i;
        house = house_img(1);
    end
    
    % ve co
    x1 = [-300 -280 200 250 150 -150];
    y1 = [-100 200 200 50 -370 -320];
    for i = 1:6
        [t_Image, ~, t_Alpha]	= imread('grass.png');
        angle = 180;%atan(Boids(1,2) / Boids(1,1)) * 180 / pi - 90;	% imrotate rotates ccw     
        img_i = imrotate(t_Image, angle);
        alpha_i = imrotate(t_Alpha, angle );
        house_img(1) = image(x1(i),y1(i),img_i);
        house_img(1).AlphaData = alpha_i;
        tree = house_img(1);
    end
    
    % ve cay
    x1 = [-280 -200 200 250];
    y1 = [-300 -100 -100 -250];
    for i = 1:4
        [t_Image, ~, t_Alpha]	= imread('tree.png');
        angle = 180;%atan(Boids(1,2) / Boids(1,1)) * 180 / pi - 90;	% imrotate rotates ccw     
        img_i = imrotate(t_Image, angle);
        alpha_i = imrotate(t_Alpha, angle );
        house_img(1) = image(x1(i),y1(i),img_i);
        house_img(1).AlphaData = alpha_i;
        tree = house_img(1);
    end
%Ve cua
    angle = 0;%atan(Boids(1,2) / Boids(1,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(d_Image, angle);
    alpha_i = imrotate(d_Alpha, angle );
    DoorPlot(1) = image(-25, -120, img_i);
    DoorPlot(1).AlphaData = alpha_i;
    ArtDoor = DoorPlot(1);

