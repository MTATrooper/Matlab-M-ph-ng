function [v_Image,v_Alpha,BoidsPlot,fHandler]=InitializeGraphics()
global EnvironmentWidth;
global HeliWidth;
global Boids;
global ArtHouse;
global Helicopter;

[v_Image, ~, v_Alpha]	= imread('helicopter22.png');
v_Image = imresize(v_Image, [HeliWidth HeliWidth], 'lanczos3' );
v_Alpha = imresize(v_Alpha, [HeliWidth HeliWidth], 'lanczos3' );

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
    ArtHouse = rectangle('Position',[-100 -300 200 200],'EdgeColor','b','LineWidth',2);

