function [b_Image,b_Alpha,r_Image,r_Alpha, BluePlot, RedPlot]=InitializeArmyBlue_Victim()
global ArmyBlue;
global ArmyRed;
global ImageWidth;


[b_Image, ~, b_Alpha]	= imread('bird_b.png');
b_Image = imresize(b_Image, [ImageWidth ImageWidth], 'lanczos3' );
b_Alpha = imresize(b_Alpha, [ImageWidth ImageWidth], 'lanczos3' );

[r_Image, ~, r_Alpha]	= imread('Contin.png');
r_Image = imresize(r_Image, [ImageWidth ImageWidth], 'lanczos3' );
r_Alpha = imresize(r_Alpha, [ImageWidth ImageWidth], 'lanczos3' );

for BoidIndex = 1 : 5
    angle = atan(ArmyBlue(BoidIndex,2) / ArmyBlue(BoidIndex,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(b_Image, angle);
    alpha_i = imrotate(b_Alpha, angle );
    BluePlot(BoidIndex) = image(ArmyBlue(BoidIndex,1)- ImageWidth/2, ArmyBlue(BoidIndex,2)-ImageWidth/2, img_i);
    BluePlot(BoidIndex).AlphaData = alpha_i;   
end
    angle = 0;%atan(ArmyRed(11,2) / ArmyRed(11,1)) * 180 / pi - 90;	% imrotate rotates ccw     
    img_i = imrotate(r_Image, angle);
    alpha_i = imrotate(r_Alpha, angle );
    RedPlot(8) = image(ArmyRed(8,1)- ImageWidth/2, ArmyRed(8,2)-ImageWidth/2, img_i);
    RedPlot(8).AlphaData = alpha_i;

