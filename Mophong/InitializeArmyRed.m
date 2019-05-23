function [r_Image,r_Alpha,RedPlot]=InitializeArmyRed()
global ArmyBlue;
global ArmyRed;
global ImageWidth;


[r_Image, ~, r_Alpha]	= imread('bird_r.png');
r_Image = imresize(r_Image, [ImageWidth ImageWidth], 'lanczos3' );
r_Alpha = imresize(r_Alpha, [ImageWidth ImageWidth], 'lanczos3' );

[c_Image, ~, c_Alpha]	= imread('Contin.png');
c_Image = imresize(c_Image, [ImageWidth ImageWidth], 'lanczos3' );
c_Alpha = imresize(c_Alpha, [ImageWidth ImageWidth], 'lanczos3' );

for BoidIndex = 1 : 7
    angle = atan(ArmyRed(BoidIndex,2) / ArmyRed(BoidIndex,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(r_Image, angle);
    alpha_i = imrotate(r_Alpha, angle );
    RedPlot(BoidIndex) = image(ArmyRed(BoidIndex,1)- ImageWidth/2, ArmyRed(BoidIndex,2)-ImageWidth/2, img_i);
    RedPlot(BoidIndex).AlphaData = alpha_i;   
end
    angle = atan(ArmyRed(8,2) / ArmyRed(8,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(c_Image, angle);
    alpha_i = imrotate(c_Alpha, angle );
    RedPlot(8) = image(ArmyRed(8,1)- ImageWidth/2, ArmyRed(8,2)-ImageWidth/2, img_i);
    RedPlot(8).AlphaData = alpha_i;

